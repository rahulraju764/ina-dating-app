import { Component, inject, OnInit } from '@angular/core';
import { CommonModule, NgClass } from '@angular/common';
import { FormsModule, ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { LucideAngularModule, Search, Filter, Download, MoreVertical, Eye, ShieldOff, Trash2, Plus, UserCheck, UserX, UserMinus, ShieldBan, BadgeCheck } from 'lucide-angular';
import { Firestore, collection, getDocs, doc, setDoc, updateDoc, deleteDoc, writeBatch, query, orderBy, limit, startAfter, endBefore, DocumentSnapshot, Timestamp } from '@angular/fire/firestore';

export interface User {
  id: string; // The Firestore doc id
  name: string;
  email: string;
  dob?: any;
  age?: number;
  gender?: string;
  orientation?: string;
  bio?: string;
  interests?: string[];
  relationshipGoal?: string;
  occupation?: string;
  education?: string;
  height?: number;
  languages?: string[];
  pronouns?: string;
  photoUrls?: string[];
  isVerified?: boolean;
  isPremium?: boolean;
  isActive?: boolean;
  isSnoozed?: boolean;
  isBanned?: boolean;
  location?: any;
  geohash?: string;
  preferences?: any;
  createdAt?: any;
  // Fallbacks for display
  avatar?: string;
  statusLabel?: string;
  tierLabel?: string;
}

@Component({
  selector: 'app-users',
  standalone: true,
  imports: [CommonModule, NgClass, FormsModule, ReactiveFormsModule, LucideAngularModule],
  templateUrl: './users.component.html'
})
export class UsersComponent implements OnInit {
  readonly Search = Search;
  readonly Filter = Filter;
  readonly Download = Download;
  readonly MoreVertical = MoreVertical;
  readonly Eye = Eye;
  readonly ShieldOff = ShieldOff;
  readonly Trash2 = Trash2;
  readonly Plus = Plus;
  readonly UserCheck = UserCheck;
  readonly UserX = UserX;
  readonly UserMinus = UserMinus;
  readonly ShieldBan = ShieldBan;
  readonly BadgeCheck = BadgeCheck;

  firestore = inject(Firestore);
  users: User[] = [];
  isLoading = false;

  // Filtering State
  searchQuery: string = '';
  filterStatus: 'All' | 'Active' | 'Suspended' | 'Banned' = 'All';

  // Pagination State
  pageSize = 10;
  currentPage = 1;
  firstVisible: DocumentSnapshot | null = null;
  lastVisible: DocumentSnapshot | null = null;
  hasNextPage = false;
  hasPrevPage = false;

  // Selection State
  selectedUserIds: Set<string> = new Set();
  selectAll = false;

  // Add User State
  showAddModal: boolean = false;
  addUserForm: FormGroup;
  private fb = inject(FormBuilder);

  constructor() {
    this.addUserForm = this.fb.group({
      name: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      age: [18, [Validators.required, Validators.min(18), Validators.max(100)]],
      tier: ['Free', Validators.required],
      status: ['Active', Validators.required]
    });
  }

  ngOnInit() {
    this.loadUsers();
  }

  async loadUsers(direction: 'next' | 'prev' | 'initial' = 'initial') {
    this.isLoading = true;
    this.selectedUserIds.clear();
    this.selectAll = false;

    try {
      const usersRef = collection(this.firestore, 'users');
      // Always pull one extra to check if there is a next page
      const queryLimit = this.pageSize + 1;
      let q = query(usersRef, orderBy('createdAt', 'desc'), limit(queryLimit));

      if (direction === 'next' && this.lastVisible) {
        q = query(usersRef, orderBy('createdAt', 'desc'), startAfter(this.lastVisible), limit(queryLimit));
      } else if (direction === 'prev' && this.firstVisible) {
        q = query(usersRef, orderBy('createdAt', 'desc'), endBefore(this.firstVisible), limit(this.pageSize));
      }

      const querySnapshot = await getDocs(q);
      const docs = querySnapshot.docs;

      // Check for next page
      this.hasNextPage = docs.length === queryLimit;
      const displayDocs = direction === 'prev' ? docs : docs.slice(0, this.pageSize);

      this.users = displayDocs.map(doc => {
        const data = doc.data() as any;

        let statusLabel = 'Active';
        if (data.isBanned) statusLabel = 'Banned';
        else if (data.isSnoozed) statusLabel = 'Suspended';
        else if (data.isActive === false) statusLabel = 'Inactive';

        let ageNum = 0;
        if (data.dob) {
          const dobDate = data.dob?.toDate ? data.dob.toDate() : new Date(data.dob);
          if (!isNaN(dobDate.getTime())) {
            const diff_ms = Date.now() - dobDate.getTime();
            const age_dt = new Date(diff_ms);
            ageNum = Math.abs(age_dt.getUTCFullYear() - 1970);
          }
        }

        return {
          id: doc.id,
          name: data.name || 'Unknown User',
          email: data.email || 'No Email',
          age: ageNum || data.age || 0,
          photoUrls: data.photoUrls || [],
          avatar: (data.photoUrls && data.photoUrls.length > 0) ? data.photoUrls[0] : `https://ui-avatars.com/api/?name=${encodeURIComponent(data.displayName || 'User')}&background=random`,
          isVerified: !!data.isVerified,
          isPremium: !!data.isPremium,
          tierLabel: data.isPremium ? 'Premium' : 'Free',
          statusLabel: statusLabel,
          createdAt: data.createdAt?.toDate ? data.createdAt.toDate().toLocaleDateString() : 'N/A',
          ...data
        } as User;
      });

      // Client-side filtering for Search & Status wrapper
      if (this.searchQuery || this.filterStatus !== 'All') {
        this.users = this.users.filter(u => {
          const matchesSearch = u.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
            u.email.toLowerCase().includes(this.searchQuery.toLowerCase());
          const matchesStatus = this.filterStatus === 'All' || u.statusLabel === this.filterStatus;
          return matchesSearch && matchesStatus;
        });
      }


      if (displayDocs.length > 0) {
        this.firstVisible = displayDocs[0];
        this.lastVisible = displayDocs[displayDocs.length - 1];

        this.hasPrevPage = direction === 'next' || (direction === 'prev' && this.currentPage > 1) || this.currentPage > 1;

        if (direction === 'next') this.currentPage++;
        if (direction === 'prev') this.currentPage--;
      } else {
        if (direction === 'initial') {
          this.firstVisible = null;
          this.lastVisible = null;
          this.hasNextPage = false;
          this.hasPrevPage = false;
        } else if (direction === 'next') {
          this.hasNextPage = false;
        } else if (direction === 'prev') {
          this.hasPrevPage = false;
          this.currentPage = 1;
        }
      }

    } catch (error) {
      console.error("Error loading users:", error);
    } finally {
      this.isLoading = false;
    }
  }

  // Selection Logic
  toggleSelection(userId: string) {
    if (this.selectedUserIds.has(userId)) {
      this.selectedUserIds.delete(userId);
    } else {
      this.selectedUserIds.add(userId);
    }
    this.selectAll = this.selectedUserIds.size === this.users.length && this.users.length > 0;
  }

  toggleAllSelection(event: Event) {
    const isChecked = (event.target as HTMLInputElement).checked;
    this.selectAll = isChecked;
    if (isChecked) {
      this.users.forEach(u => this.selectedUserIds.add(u.id));
    } else {
      this.selectedUserIds.clear();
    }
  }

  async deleteSelectedUsers() {
    if (this.selectedUserIds.size === 0) return;
    if (confirm(`Are you sure you want to permanently delete ${this.selectedUserIds.size} users?`)) {
      this.isLoading = true;
      try {
        const batch = writeBatch(this.firestore);
        this.selectedUserIds.forEach(id => {
          const userRef = doc(this.firestore, `users/${id}`);
          batch.delete(userRef);
        });
        await batch.commit();
        this.selectedUserIds.clear();
        this.selectAll = false;
        await this.loadUsers('initial'); // Reload list
      } catch (error) {
        console.error("Error deleting multiple users:", error);
      } finally {
        this.isLoading = false;
      }
    }
  }


  // Add User Modal Methods
  openAddModal() {
    this.addUserForm.reset({ age: 18, tier: 'Free', status: 'Active' });
    this.showAddModal = true;
  }

  closeAddModal() {
    this.showAddModal = false;
  }

  async addUser() {
    if (this.addUserForm.valid) {
      this.isLoading = true;
      try {
        const formValue = this.addUserForm.value;
        const newDocRef = doc(collection(this.firestore, 'users'));

        const today = new Date();
        const dobDate = new Date(today.getFullYear() - formValue.age, today.getMonth(), today.getDate());

        const userData = {
          name: formValue.name, // Mapping form to API
          email: formValue.email,
          dob: Timestamp.fromDate(dobDate),
          isPremium: formValue.tier !== 'Free',
          isActive: formValue.status === 'Active',
          isSnoozed: formValue.status === 'Suspended',
          isBanned: formValue.status === 'Banned',
          createdAt: Timestamp.now(),
          isVerified: false,
          photoUrls: []
        };

        await setDoc(newDocRef, userData);
        this.closeAddModal();
        await this.loadUsers('initial'); // Reload to show new user

      } catch (e) {
        console.error("Error adding user: ", e);
      } finally {
        this.isLoading = false;
      }
    }
  }

  // Action Methods updating Firestore
  async verifyUser(user: User) {
    const originalStatus = user.isVerified;
    const newStatus = !user.isVerified;
    user.isVerified = newStatus; // Optimistic UI update
    try {
      await updateDoc(doc(this.firestore, `users/${user.id}`), { isVerified: newStatus });
      alert(`User ${newStatus ? 'verified' : 'unverified'} successfully!`);
    } catch (e: any) {
      console.error("Error verifying user", e);
      user.isVerified = originalStatus; // Revert on failure
      alert('Failed to update verification status: ' + e.message);
    }
  }

  async suspendUser(user: User) {
    const originalLabel = user.statusLabel;
    const originalSnoozed = user.isSnoozed;
    const originalBanned = user.isBanned;
    const originalActive = user.isActive;

    const newSnoozedStatus = user.statusLabel !== 'Suspended';

    // Optimistic UI update
    user.statusLabel = newSnoozedStatus ? 'Suspended' : 'Active';
    user.isSnoozed = newSnoozedStatus;
    user.isBanned = false;
    user.isActive = !newSnoozedStatus;

    try {
      await updateDoc(doc(this.firestore, `users/${user.id}`), { isSnoozed: newSnoozedStatus, isBanned: false, isActive: !newSnoozedStatus });
      alert(`User ${newSnoozedStatus ? 'suspended' : 'unsuspended'} successfully!`);
    } catch (e: any) {
      console.error("Error suspending user", e);
      // Revert on failure
      user.statusLabel = originalLabel;
      user.isSnoozed = originalSnoozed;
      user.isBanned = originalBanned;
      user.isActive = originalActive;
      alert('Failed to suspend user: ' + e.message);
    }
  }

  async banUser(user: User) {
    const originalLabel = user.statusLabel;
    const originalSnoozed = user.isSnoozed;
    const originalBanned = user.isBanned;
    const originalActive = user.isActive;

    const newBannedStatus = user.statusLabel !== 'Banned';

    // Optimistic update
    user.statusLabel = newBannedStatus ? 'Banned' : 'Active';
    user.isBanned = newBannedStatus;
    user.isSnoozed = false;
    user.isActive = !newBannedStatus;

    try {
      await updateDoc(doc(this.firestore, `users/${user.id}`), { isBanned: newBannedStatus, isSnoozed: false, isActive: !newBannedStatus });
      alert(`User ${newBannedStatus ? 'banned' : 'unbanned'} successfully!`);
    } catch (e: any) {
      console.error("Error banning user", e);
      // Revert on failure
      user.statusLabel = originalLabel;
      user.isBanned = originalBanned;
      user.isSnoozed = originalSnoozed;
      user.isActive = originalActive;
      alert('Failed to ban user: ' + e.message);
    }
  }

  async deleteUser(user: User) {
    if (confirm(`Are you sure you want to permanently delete user ${user.name}?`)) {
      try {
        await deleteDoc(doc(this.firestore, `users/${user.id}`));
        this.users = this.users.filter(u => u.id !== user.id);
        this.selectedUserIds.delete(user.id);
        alert('User deleted successfully!');
      } catch (e: any) {
        console.error("Error deleting user", e);
        alert('Failed to delete user: ' + e.message);
      }
    }
  }
}
