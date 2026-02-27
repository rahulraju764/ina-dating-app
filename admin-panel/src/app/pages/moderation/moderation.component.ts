import { Component, OnInit, inject } from '@angular/core';
import { LucideAngularModule, Search, Filter, ShieldAlert, Check, Trash2, Ban, ShieldOff } from 'lucide-angular';
import { CommonModule, NgClass, DatePipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Firestore, collection, getDocs, doc, setDoc, updateDoc, deleteDoc, query, orderBy, where, Timestamp, limit } from '@angular/fire/firestore';
import { ModerationReport } from '../../models/moderation.model';

@Component({
  selector: 'app-moderation',
  standalone: true,
  imports: [CommonModule, LucideAngularModule, NgClass, FormsModule, DatePipe],
  templateUrl: './moderation.component.html'
})
export class ModerationComponent implements OnInit {
  readonly ShieldAlert = ShieldAlert;
  readonly Check = Check;
  readonly Trash2 = Trash2;
  readonly Ban = Ban;
  readonly ShieldOff = ShieldOff;

  firestore = inject(Firestore);

  isLoading = false;
  isActionLoading = false;

  tabs = ['Images', 'Profiles', 'Chats'];
  activeTab = 'Images';

  reports: ModerationReport[] = [];
  selectedItem: ModerationReport | null = null;
  moderatorNotes: string = '';

  ngOnInit() {
    this.loadReports();
  }

  async loadReports() {
    this.isLoading = true;
    try {
      const reportsCol = collection(this.firestore, 'reports');
      const q = query(reportsCol, where('status', '==', 'Pending'), orderBy('createdAt', 'desc'));
      const snapshot = await getDocs(q);

      if (snapshot.empty) {
        await this.populateMockQueue();
      } else {
        this.reports = snapshot.docs.map(doc => {
          const data = doc.data() as any;
          return {
            id: doc.id,
            ...data,
            createdAt: data.createdAt?.toDate ? data.createdAt.toDate() : data.createdAt
          } as ModerationReport;
        });
      }

      this.filterList();

    } catch (e) {
      console.error("Error loading reports", e);
      await this.populateMockQueue();
    } finally {
      this.isLoading = false;
    }
  }

  get queue(): ModerationReport[] {
    // Filter by active tab type
    return this.reports.filter(r => {
      if (this.activeTab.includes('Images')) return r.type === 'Image';
      if (this.activeTab.includes('Profiles')) return r.type === 'Profile';
      if (this.activeTab.includes('Chats')) return r.type === 'Chat';
      return true;
    });
  }

  filterList() {
    const queueItems = this.queue;
    if (queueItems.length > 0 && !this.selectedItem) {
      this.selectItem(queueItems[0]);
    } else if (queueItems.length === 0) {
      this.selectedItem = null;
    }
  }

  switchTab(tab: string) {
    this.activeTab = tab;
    this.selectedItem = null;
    this.filterList();
  }

  selectItem(item: ModerationReport) {
    this.selectedItem = item;
    this.moderatorNotes = '';
  }

  async takeAction(action: 'Approve' | 'Remove' | 'Suspend' | 'Ban') {
    if (!this.selectedItem || !this.selectedItem.id) return;

    this.isActionLoading = true;
    try {
      const reportRef = doc(this.firestore, 'reports', this.selectedItem.id);
      const userRef = doc(this.firestore, 'users', this.selectedItem.uploaderId || 'unknown');

      const updateData: any = {
        status: 'Action Taken',
        resolvedBy: 'Admin', // In reality, getCurrentUser()
        resolvedAt: Timestamp.now(),
        resolutionNotes: this.moderatorNotes || `Action: ${action}`
      };

      if (action === 'Approve') {
        updateData.status = 'Reviewed';
      } else if (action === 'Remove') {
        // Would also delete from Storage or mark image as deleted in DB
      } else if (action === 'Suspend') {
        try { await setDoc(userRef, { isSuspended: true, suspendedUntil: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) }, { merge: true }); } catch (e) { }
      } else if (action === 'Ban') {
        try { await setDoc(userRef, { isBanned: true, isActive: false }, { merge: true }); } catch (e) { }
      }

      // Use setDoc with merge in case the mock document wasn't successfully saved to Firestore initially
      await setDoc(reportRef, updateData, { merge: true });

      // Remove from local array
      this.reports = this.reports.filter(r => r.id !== this.selectedItem?.id);
      this.selectedItem = null;
      this.filterList();

    } catch (e) {
      console.error("Action failed", e);
      alert("Failed to process action.");
    } finally {
      this.isActionLoading = false;
    }
  }

  async populateMockQueue() {
    // Find real users to attach to mock reports
    const usersCol = collection(this.firestore, 'users');
    const q = query(usersCol, limit(3));
    let realUsers: any[] = [];
    try {
      const snap = await getDocs(q);
      realUsers = snap.docs.map(doc => ({ id: doc.id, ...doc.data() as any }));
    } catch (e) { }

    const r1 = realUsers[0] || { id: 'u1', displayName: 'Rahul R', photoUrls: ['https://i.pravatar.cc/150?u=2'] };
    const r2 = realUsers[1] || { id: 'u2', displayName: 'Priya K', photoUrls: ['https://i.pravatar.cc/150?u=3'] };
    const r3 = realUsers[2] || { id: 'u3', displayName: 'Amit S', photoUrls: ['https://i.pravatar.cc/150?u=4'] };

    const mocks: ModerationReport[] = [
      {
        id: 'm1', type: 'Image', status: 'Pending', targetId: 'img1', targetType: 'ProfilePhoto',
        reason: 'NSFW Detected', imageUrl: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
        nsfwScore: 0.82, createdAt: new Date(Date.now() - 120000), uploaderId: r1.id,
        uploader: { name: r1.displayName, avatar: r1.photoUrls?.[0] || 'https://i.pravatar.cc/150', joined: 'Nov 02, 2025', reports: 2 }
      },
      {
        id: 'm2', type: 'Image', status: 'Pending', targetId: 'img2', targetType: 'MessagePhoto', reporterId: r3.id,
        reason: 'User Reported Explicit Content', imageUrl: 'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&auto=format&fit=crop&w=150&q=80',
        nsfwScore: 0.45, createdAt: new Date(Date.now() - 900000), uploaderId: r2.id,
        uploader: { name: r2.displayName, avatar: r2.photoUrls?.[0] || 'https://i.pravatar.cc/150', joined: 'Oct 15, 2025', reports: 1 }
      },
      {
        id: 'm3', type: 'Profile', status: 'Pending', targetId: r3.id, targetType: 'User', reporterId: r1.id,
        reason: 'Fake Profile / Catfish',
        createdAt: new Date(Date.now() - 3600000), uploaderId: r3.id,
        uploader: { name: r3.displayName, avatar: r3.photoUrls?.[0] || 'https://i.pravatar.cc/150', joined: 'Dec 01, 2025', reports: 5 }
      }
    ];

    this.reports = mocks;

    // Save them if they don't exist
    try {
      const reportsCol = collection(this.firestore, 'reports');
      for (let m of mocks) {
        await setDoc(doc(reportsCol, m.id), {
          ...m,
          createdAt: Timestamp.fromDate(m.createdAt as Date)
        });
      }
    } catch (e) { }
  }
}
