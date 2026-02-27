import { Component, OnInit, inject } from '@angular/core';
import { CommonModule, NgClass, DatePipe } from '@angular/common';
import { FormsModule, ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { LucideAngularModule, Search, CheckCircle, XCircle, CreditCard, User, Clock, Check, X, Building, Wallet, Landmark } from 'lucide-angular';
import { Firestore, collection, getDocs, doc, getDoc, setDoc, updateDoc, Timestamp, query, orderBy, where } from '@angular/fire/firestore';
import { WithdrawalRequest } from '../../../models/coin.model';

@Component({
  selector: 'app-withdrawals',
  standalone: true,
  imports: [CommonModule, NgClass, FormsModule, ReactiveFormsModule, LucideAngularModule, DatePipe],
  templateUrl: './withdrawals.component.html'
})
export class WithdrawalsComponent implements OnInit {
  // Icons
  readonly Search = Search;
  readonly CheckCircle = CheckCircle;
  readonly XCircle = XCircle;
  readonly CreditCard = CreditCard;
  readonly User = User;
  readonly Clock = Clock;
  readonly Check = Check;
  readonly X = X;
  readonly Building = Building;
  readonly WalletIcon = Wallet;
  readonly Landmark = Landmark;

  firestore = inject(Firestore);
  fb = inject(FormBuilder);

  requests: WithdrawalRequest[] = [];
  userCache: Record<string, any> = {};
  isLoading = false;

  filterStatus: 'All' | 'pending' | 'processing' | 'completed' | 'rejected' = 'All';

  // Modal State
  showProcessModal = false;
  selectedRequest: WithdrawalRequest | null = null;
  processForm: FormGroup;
  actionType: 'approve' | 'reject' | null = null;

  constructor() {
    this.processForm = this.fb.group({
      adminNote: ['', Validators.required]
    });
  }

  ngOnInit(): void {
    this.loadRequests();
  }

  async loadRequests() {
    this.isLoading = true;
    try {
      let q = query(collection(this.firestore, 'withdrawalRequests'), orderBy('requestedAt', 'desc'));

      if (this.filterStatus !== 'All') {
        q = query(collection(this.firestore, 'withdrawalRequests'), where('status', '==', this.filterStatus), orderBy('requestedAt', 'desc'));
      }

      const querySnapshot = await getDocs(q);
      const docs = querySnapshot.docs;

      this.requests = docs.map(doc => {
        const data = doc.data() as any;
        return {
          id: doc.id,
          ...data,
          requestedAt: data.requestedAt?.toDate ? data.requestedAt.toDate() : data.requestedAt,
          processedAt: data.processedAt?.toDate ? data.processedAt.toDate() : data.processedAt
        } as WithdrawalRequest;
      });

      // Load user details for each unique user
      const uniqueUserIds = [...new Set(this.requests.map(r => r.userId))];
      await Promise.all(uniqueUserIds.map(uid => this.loadUserDetails(uid)));

    } catch (e) {
      console.error("Error loading withdrawal requests:", e);
    } finally {
      this.isLoading = false;
    }
  }

  async loadUserDetails(userId: string) {
    if (this.userCache[userId]) return;
    try {
      const userDoc = await getDoc(doc(this.firestore, `users/${userId}`));
      if (userDoc.exists()) {
        this.userCache[userId] = userDoc.data();
      } else {
        this.userCache[userId] = { name: 'Unknown User (Deleted)' };
      }
    } catch (e) {
      this.userCache[userId] = { name: 'Error loading' };
    }
  }

  getUserName(userId: string): string {
    return this.userCache[userId]?.name || userId;
  }

  getUserEmail(userId: string): string {
    return this.userCache[userId]?.email || 'N/A';
  }

  openProcessModal(req: WithdrawalRequest, action: 'approve' | 'reject') {
    this.selectedRequest = req;
    this.actionType = action;
    this.processForm.reset();

    if (action === 'approve') {
      this.processForm.patchValue({ adminNote: `Processed on ${new Date().toLocaleDateString()}` });
    }
    this.showProcessModal = true;
  }

  closeModal() {
    this.showProcessModal = false;
    this.selectedRequest = null;
    this.actionType = null;
  }

  async processRequest() {
    if (this.processForm.invalid || !this.selectedRequest || !this.actionType) return;

    this.isLoading = true;
    try {
      const formValue = this.processForm.value;
      const docRef = doc(this.firestore, `withdrawalRequests/${this.selectedRequest.id}`);

      const newStatus = this.actionType === 'approve' ? 'completed' : 'rejected';

      await updateDoc(docRef, {
        status: newStatus,
        adminNote: formValue.adminNote,
        processedAt: Timestamp.now(),
        // processedBy is theoretically the admin user uid, but for now we put email
        processedBy: 'admin'
      });

      // If rejected, refund coins
      if (this.actionType === 'reject') {
        const userDocRef = doc(this.firestore, `users/${this.selectedRequest.userId}`);
        const userDoc = await getDoc(userDocRef);
        if (userDoc.exists()) {
          const currentBalance = userDoc.data()?.['coinBalance'] || 0;
          await updateDoc(userDocRef, {
            coinBalance: currentBalance + this.selectedRequest.coinsRequested
          });

          // Log refund transaction
          const txnRef = doc(collection(this.firestore, 'coinTransactions'));
          await setDoc(txnRef, {
            userId: this.selectedRequest.userId,
            type: 'refund',
            amount: this.selectedRequest.coinsRequested,
            balanceAfter: currentBalance + this.selectedRequest.coinsRequested,
            referenceId: this.selectedRequest.id,
            referenceType: 'withdrawal',
            description: 'Refund for rejected withdrawal',
            createdAt: Timestamp.now(),
            status: 'completed'
          });
        }
      }

      this.closeModal();
      await this.loadRequests();
    } catch (e) {
      console.error("Error processing request:", e);
      alert("Failed to process request. Check permissions.");
    } finally {
      this.isLoading = false;
    }
  }
}
