import { Component, OnInit, inject } from '@angular/core';
import { CommonModule, NgClass, DatePipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { LucideAngularModule, ArrowUpRight, ArrowDownRight, Filter, Download, CreditCard, TrendingUp, UserMinus, Search, Edit, Trash2, ToggleLeft, ToggleRight, X } from 'lucide-angular';
import { Firestore, collection, getDocs, doc, setDoc, deleteDoc, updateDoc, query, orderBy, limit, Timestamp } from '@angular/fire/firestore';
import { SubscriptionPlan, SubscriptionTransaction } from '../../models/subscription.model';

@Component({
  selector: 'app-subscriptions',
  standalone: true,
  imports: [CommonModule, NgClass, FormsModule, LucideAngularModule, DatePipe],
  templateUrl: './subscriptions.component.html'
})
export class SubscriptionsComponent implements OnInit {
  // Icons
  readonly ArrowUpRight = ArrowUpRight;
  readonly ArrowDownRight = ArrowDownRight;
  readonly Filter = Filter;
  readonly Download = Download;
  readonly CreditCard = CreditCard;
  readonly TrendingUp = TrendingUp;
  readonly UserMinus = UserMinus;
  readonly Search = Search;
  readonly Edit = Edit;
  readonly Trash2 = Trash2;
  readonly ToggleLeft = ToggleLeft;
  readonly ToggleRight = ToggleRight;
  readonly X = X;

  firestore = inject(Firestore);

  plans: SubscriptionPlan[] = [];
  transactions: SubscriptionTransaction[] = [];

  isLoadingPlans = false;
  isLoadingTxns = false;

  // Modal State
  isModalOpen = false;
  isSaving = false;
  currentPlan: Partial<SubscriptionPlan> = {};
  isEditing = false;

  activeTab: 'plans' | 'transactions' = 'plans';

  stats = [
    { label: 'Active Subscribers', value: '17,483', change: '+4.2%', positive: true, icon: CreditCard },
    { label: 'Monthly Revenue', value: '$24,850', change: '+12.5%', positive: true, icon: TrendingUp },
    { label: 'Churn Rate', value: '2.4%', change: '-0.3%', positive: true, icon: UserMinus }
  ];

  ngOnInit(): void {
    this.loadPlans();
    this.loadTransactions();
  }

  async loadPlans() {
    this.isLoadingPlans = true;
    try {
      const plansCol = collection(this.firestore, 'plans');
      const q = query(plansCol, orderBy('createdAt', 'asc')); // Order by creation to keep Free on top usually
      const snapshot = await getDocs(q);

      this.plans = snapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data()
      })) as SubscriptionPlan[];

      // Calculate Active Subscribers stat dynamically (approximate)
      const totalActive = this.plans.reduce((sum, p) => sum + (p.activeUsers || 0), 0);
      this.stats[0].value = totalActive.toLocaleString();

    } catch (e) {
      console.error('Error loading plans', e);
    } finally {
      this.isLoadingPlans = false;
    }
  }

  async loadTransactions() {
    this.isLoadingTxns = true;
    try {
      const txnsCol = collection(this.firestore, 'transactions'); // Using general transactions collection
      const q = query(txnsCol, orderBy('date', 'desc'), limit(10));

      const snapshot = await getDocs(q);

      if (snapshot.empty) {
        await this.populateMockTransactionsWithFirebaseUsers();
      } else {
        this.transactions = snapshot.docs.map(doc => {
          const data = doc.data() as any;
          return {
            id: doc.id,
            ...data,
            date: data.date?.toDate ? data.date.toDate() : data.date
          } as SubscriptionTransaction;
        });
      }
    } catch (e) {
      console.error('Error loading transactions, using mocks', e);
      await this.populateMockTransactionsWithFirebaseUsers();
    } finally {
      this.isLoadingTxns = false;
    }
  }

  async populateMockTransactionsWithFirebaseUsers() {
    try {
      // Fetch up to 5 real users from Firebase to use in Mock Transactions
      const usersCol = collection(this.firestore, 'users');
      const usersQuery = query(usersCol, limit(5));
      const userSnapshot = await getDocs(usersQuery);

      const realUsers = userSnapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data() as any
      }));

      // Base mock transactions
      const baseMocks: Partial<SubscriptionTransaction>[] = [
        { id: '1', planId: 'p1', planName: 'Gold', amount: '$14.99', date: new Date(Date.now() - 86400000), status: 'Completed' },
        { id: '2', planId: 'p2', planName: 'Platinum', amount: '$29.99', date: new Date(Date.now() - 172800000), status: 'Completed' },
        { id: '3', planId: 'p3', planName: 'Gold Annual', amount: '$99.99', date: new Date(Date.now() - 259200000), status: 'Completed' },
        { id: '4', planId: 'p4', planName: 'Platinum', amount: '$29.99', date: new Date(Date.now() - 345600000), status: 'Refunded' },
        { id: '5', planId: 'p5', planName: 'Gold', amount: '$14.99', date: new Date(Date.now() - 432000000), status: 'Completed' },
      ];

      this.transactions = baseMocks.map((mock, index) => {
        // Use a real user if available, otherwise fallback
        const realUser = realUsers[index % realUsers.length];

        return {
          ...mock,
          userId: realUser?.id || `u${index + 1}`,
          userName: realUser?.displayName || `User ${index + 1}`,
          userEmail: realUser?.email || `user${index + 1}@example.com`,
          avatarUrl: (realUser?.photoUrls && realUser.photoUrls.length > 0) ? realUser.photoUrls[0] : `https://i.pravatar.cc/150?u=${index + 1}`
        } as SubscriptionTransaction;
      });

    } catch (error) {
      console.error('Error fetching users for mocked transactions', error);
      // Fallback to static static mocks
      this.transactions = [
        { id: '1', userId: 'u1', userName: 'Meera M.', userEmail: 'meera@example.com', planId: 'p1', planName: 'Gold', amount: '$14.99', date: new Date(Date.now() - 86400000), status: 'Completed', avatarUrl: 'https://i.pravatar.cc/150?u=1' },
      ];
    }
  }

  openAddModal() {
    this.isEditing = false;
    this.currentPlan = {
      name: '',
      price: '$0.00',
      duration: '/month',
      features: '',
      activeUsers: 0,
      status: 'Active',
      tier: 'Gold'
    };
    this.isModalOpen = true;
  }

  openEditModal(plan: SubscriptionPlan) {
    this.isEditing = true;
    this.currentPlan = { ...plan };
    this.isModalOpen = true;
  }

  closeModal() {
    this.isModalOpen = false;
  }

  async savePlan() {
    if (!this.currentPlan.name || !this.currentPlan.price) return;

    this.isSaving = true;
    try {
      const plansCol = collection(this.firestore, 'plans');
      let docRef;

      if (this.isEditing && this.currentPlan.id) {
        docRef = doc(this.firestore, 'plans', this.currentPlan.id);
      } else {
        docRef = doc(plansCol);
        this.currentPlan.id = docRef.id;
        this.currentPlan.createdAt = Timestamp.now();
        this.currentPlan.activeUsers = 0; // default for new
      }

      this.currentPlan.updatedAt = Timestamp.now();

      await setDoc(docRef, this.currentPlan);

      await this.loadPlans();
      this.closeModal();
    } catch (e) {
      console.error('Error saving plan', e);
      alert('Failed to save plan.');
    } finally {
      this.isSaving = false;
    }
  }

  async deletePlan(planId: string) {
    if (confirm('Are you sure you want to delete this subscription plan? Users currently on this plan will still have their active subscription, but nobody else can purchase it.')) {
      try {
        await deleteDoc(doc(this.firestore, 'plans', planId));
        await this.loadPlans();
      } catch (e) {
        console.error('Error deleting plan', e);
        alert('Failed to delete plan.');
      }
    }
  }

  async populateMockPlans() {
    if (!confirm('This will wipe existing plans and insert mock data. Proceed?')) return;

    this.isLoadingPlans = true;
    try {
      const mockPlans: SubscriptionPlan[] = [
        { name: 'Free', price: '$0', duration: 'Forever', features: 'Basic swipes, Limited likes', activeUsers: 85000, status: 'Active', tier: 'Free' },
        { name: 'Gold', price: '$14.99', duration: '/month', features: 'Unlimited likes, See who liked you, 5 Super Likes/day', activeUsers: 12000, status: 'Active', tier: 'Gold' },
        { name: 'Platinum', price: '$29.99', duration: '/month', features: 'Priority boost, Unlimited Super Likes, Read receipts, Undo swipes', activeUsers: 5483, status: 'Active', tier: 'Platinum' },
        { name: 'Gold Annual', price: '$99.99', duration: '/year', features: 'All Gold features, 2 months free', activeUsers: 3200, status: 'Active', tier: 'Gold' },
      ];

      for (const plan of mockPlans) {
        const docRef = doc(collection(this.firestore, 'plans'));
        plan.createdAt = Timestamp.now();
        await setDoc(docRef, plan);
      }
      await this.loadPlans();
    } catch (e) {
      console.error(e);
      alert('Failed to insert mock plans');
    } finally {
      this.isLoadingPlans = false;
    }
  }

  async refundTransaction(tx: SubscriptionTransaction) {
    if (confirm(`Are you sure you want to refund this transaction of ${tx.amount} for ${tx.userName}?`)) {
      try {
        if (tx.id && tx.id.length > 5) { // Assuming mock ids are short '1', '2' etc. Real firestore ID is 20 chars
          const txRef = doc(this.firestore, 'transactions', tx.id);
          await updateDoc(txRef, { status: 'Refunded' });
        }
        tx.status = 'Refunded';
      } catch (e) {
        console.error('Error refunding transaction', e);
        alert('Failed to process refund.');
      }
    }
  }
}
