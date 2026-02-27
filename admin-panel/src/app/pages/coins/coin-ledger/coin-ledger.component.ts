import { Component, OnInit, inject } from '@angular/core';
import { CommonModule, NgClass, DatePipe } from '@angular/common';
import { FormsModule, ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { LucideAngularModule, Search, History, Coins, ArrowUpRight, ArrowDownRight, RefreshCcw, Landmark, User, ShieldAlert, ArrowLeftRight } from 'lucide-angular';
import { Firestore, collection, getDocs, doc, getDoc, setDoc, updateDoc, Timestamp, query, orderBy, where, limit } from '@angular/fire/firestore';
import { CoinTransaction } from '../../../models/coin.model';

@Component({
  selector: 'app-coin-ledger',
  standalone: true,
  imports: [CommonModule, NgClass, FormsModule, ReactiveFormsModule, LucideAngularModule, DatePipe],
  templateUrl: './coin-ledger.component.html'
})
export class CoinLedgerComponent implements OnInit {
  // Icons
  readonly Search = Search;
  readonly History = History;
  readonly Coins = Coins;
  readonly ArrowUpRight = ArrowUpRight;
  readonly ArrowDownRight = ArrowDownRight;
  readonly RefreshCcw = RefreshCcw;
  readonly Landmark = Landmark;
  readonly User = User;
  readonly ShieldAlert = ShieldAlert;
  readonly ArrowLeftRight = ArrowLeftRight;

  firestore = inject(Firestore);
  fb = inject(FormBuilder);

  transactions: CoinTransaction[] = [];
  isLoading = false;

  // Search state
  searchUserId: string = '';
  searchEmail: string = '';
  searchedUser: any = null;

  // Manual Adjustment Modal
  showAdjustModal = false;
  adjustForm: FormGroup;

  constructor() {
    this.adjustForm = this.fb.group({
      operation: ['credit', Validators.required],
      amount: [0, [Validators.required, Validators.min(1)]],
      description: ['', Validators.required]
    });
  }

  ngOnInit(): void {
    // Initial load: show latest 50 global transactions
    this.loadTransactions();
  }

  async loadTransactions(userId?: string) {
    this.isLoading = true;
    try {
      let q;
      if (userId) {
        q = query(collection(this.firestore, 'coinTransactions'), where('userId', '==', userId), orderBy('createdAt', 'desc'), limit(100));
      } else {
        q = query(collection(this.firestore, 'coinTransactions'), orderBy('createdAt', 'desc'), limit(50));
      }

      const querySnapshot = await getDocs(q);
      const docs = querySnapshot.docs;

      this.transactions = docs.map(doc => {
        return {
          id: doc.id,
          ...doc.data()
        } as CoinTransaction;
      });

    } catch (e) {
      console.error("Error loading transactions:", e);
    } finally {
      this.isLoading = false;
    }
  }

  async searchUser() {
    if (!this.searchEmail.trim()) {
      this.searchedUser = null;
      this.searchUserId = '';
      this.loadTransactions();
      return;
    }

    this.isLoading = true;
    try {
      // Find user by email (we assume email query works, or we can query by ID if needed)
      // Since email might not be indexed for direct root queries easily without composite index, we try direct matches
      const usersRef = collection(this.firestore, 'users');
      const q = query(usersRef, where('email', '==', this.searchEmail.trim().toLowerCase()), limit(1));
      const snapshot = await getDocs(q);

      if (!snapshot.empty) {
        const userDoc = snapshot.docs[0];
        this.searchedUser = { id: userDoc.id, ...userDoc.data() };
        this.searchUserId = userDoc.id;
        await this.loadTransactions(this.searchUserId);
      } else {
        alert("No user found with that email.");
        this.searchedUser = null;
        this.searchUserId = '';
      }
    } catch (e) {
      console.error("Error searching user:", e);
    } finally {
      this.isLoading = false;
    }
  }

  openAdjustModal() {
    if (!this.searchedUser) {
      alert("Please search for a user first to adjust their balance.");
      return;
    }
    this.adjustForm.reset({ operation: 'credit', amount: 0, description: '' });
    this.showAdjustModal = true;
  }

  closeModal() {
    this.showAdjustModal = false;
  }

  async submitAdjustment() {
    if (this.adjustForm.invalid || !this.searchedUser) return;

    this.isLoading = true;
    try {
      const formValue = this.adjustForm.value;
      const isCredit = formValue.operation === 'credit';
      const adjustmentAmount = Number(formValue.amount);
      const actualChange = isCredit ? adjustmentAmount : -adjustmentAmount;

      // Update user balance inside a transaction ideally, but we use sequential update here for simplicity
      const userRef = doc(this.firestore, `users/${this.searchUserId}`);
      const userSnap = await getDoc(userRef);

      if (!userSnap.exists()) throw new Error("User does not exist.");
      const currentBalance = userSnap.data()?.['coinBalance'] || 0;
      let newBalance = currentBalance + actualChange;

      if (newBalance < 0) {
        alert("Cannot deduct more than the user's current balance.");
        this.isLoading = false;
        return;
      }

      await updateDoc(userRef, { coinBalance: newBalance });

      // Create transaction record
      const txnRef = doc(collection(this.firestore, 'coinTransactions'));
      await setDoc(txnRef, {
        userId: this.searchUserId,
        type: 'admin_adjustment',
        amount: actualChange,
        balanceAfter: newBalance,
        referenceId: 'admin_' + Date.now(),
        referenceType: 'admin',
        description: `Admin: ${formValue.description}`,
        createdAt: Timestamp.now(),
        status: 'completed'
      });

      // Update local state
      this.searchedUser.coinBalance = newBalance;

      this.closeModal();
      await this.loadTransactions(this.searchUserId); // reload their history

    } catch (e) {
      console.error("Error adjusting balance:", e);
      alert("Failed to adjust balance. Check permissions.");
    } finally {
      this.isLoading = false;
    }
  }
}
