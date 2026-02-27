import { Component, inject } from '@angular/core';
import { CommonModule, NgClass } from '@angular/common';
import { FormsModule, ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { LucideAngularModule, Search, Filter, Download, MoreVertical, Eye, ShieldOff, Trash2, Plus, UserCheck, UserX, UserMinus, ShieldBan, BadgeCheck } from 'lucide-angular';

interface User {
  id: string;
  name: string;
  email: string;
  age: number;
  tier: 'Free' | 'Gold' | 'Platinum';
  joined: string;
  status: 'Active' | 'Suspended' | 'Banned';
  avatar: string;
  isVerified: boolean;
}

@Component({
  selector: 'app-users',
  standalone: true,
  imports: [CommonModule, NgClass, FormsModule, ReactiveFormsModule, LucideAngularModule],
  templateUrl: './users.component.html'
})
export class UsersComponent {
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

  users: User[] = [
    { id: 'usr_1', name: 'Meera M.', email: 'meera@example.com', age: 24, tier: 'Free', joined: 'Oct 12, 2025', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=1', isVerified: true },
    { id: 'usr_2', name: 'Rahul R.', email: 'rahul@example.com', age: 28, tier: 'Gold', joined: 'Nov 02, 2025', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=2', isVerified: false },
    { id: 'usr_3', name: 'Anjali K.', email: 'anjali@example.com', age: 26, tier: 'Platinum', joined: 'Dec 15, 2025', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=3', isVerified: true },
    { id: 'usr_4', name: 'Arjun P.', email: 'arjun@example.com', age: 22, tier: 'Free', joined: 'Jan 05, 2026', status: 'Suspended', avatar: 'https://i.pravatar.cc/150?u=4', isVerified: false },
    { id: 'usr_5', name: 'Sneha L.', email: 'sneha@example.com', age: 25, tier: 'Free', joined: 'Feb 10, 2026', status: 'Banned', avatar: 'https://i.pravatar.cc/150?u=5', isVerified: false }
  ];

  // Filtering State
  searchQuery: string = '';
  filterStatus: 'All' | 'Active' | 'Suspended' | 'Banned' = 'All';

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

  get filteredUsers(): User[] {
    return this.users.filter(user => {
      const matchesSearch = user.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        user.email.toLowerCase().includes(this.searchQuery.toLowerCase());
      const matchesStatus = this.filterStatus === 'All' || user.status === this.filterStatus;
      return matchesSearch && matchesStatus;
    });
  }

  // Add User Modal Methods
  openAddModal() {
    this.addUserForm.reset({ age: 18, tier: 'Free', status: 'Active' });
    this.showAddModal = true;
  }

  closeAddModal() {
    this.showAddModal = false;
  }

  addUser() {
    if (this.addUserForm.valid) {
      const formValue = this.addUserForm.value;
      const newUser: User = {
        id: `usr_${Date.now()}`,
        name: formValue.name,
        email: formValue.email,
        age: formValue.age,
        tier: formValue.tier,
        joined: new Date().toLocaleDateString('en-US', { month: 'short', day: '2-digit', year: 'numeric' }),
        status: formValue.status,
        avatar: `https://i.pravatar.cc/150?u=${Date.now()}`,
        isVerified: false
      };

      this.users.unshift(newUser); // Add to beginning of array
      this.closeAddModal();
    }
  }

  // Action Methods
  verifyUser(user: User) {
    user.isVerified = !user.isVerified;
  }

  suspendUser(user: User) {
    if (user.status !== 'Suspended') {
      user.status = 'Suspended';
    } else {
      user.status = 'Active'; // Un-suspend
    }
  }

  banUser(user: User) {
    if (user.status !== 'Banned') {
      user.status = 'Banned';
    } else {
      user.status = 'Active'; // Un-ban
    }
  }

  deleteUser(user: User) {
    if (confirm(`Are you sure you want to permanently delete user ${user.name}?`)) {
      this.users = this.users.filter(u => u.id !== user.id);
    }
  }
}
