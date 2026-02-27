import { Component, OnInit, inject } from '@angular/core';
import { CommonModule, NgClass, DatePipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { LucideAngularModule, Search, Video, PhoneCall, PhoneMissed, PhoneOff, Calendar, Clock, RefreshCcw, User } from 'lucide-angular';
import { Firestore, collection, getDocs, doc, setDoc, query, orderBy, limit, Timestamp } from '@angular/fire/firestore';
import { CallLog } from '../../../models/call.model';

@Component({
  selector: 'app-call-logs',
  standalone: true,
  imports: [CommonModule, NgClass, FormsModule, LucideAngularModule, DatePipe],
  templateUrl: './call-logs.component.html'
})
export class CallLogsComponent implements OnInit {
  // Icons
  readonly Search = Search;
  readonly Video = Video;
  readonly PhoneCall = PhoneCall;
  readonly PhoneMissed = PhoneMissed;
  readonly PhoneOff = PhoneOff;
  readonly Calendar = Calendar;
  readonly Clock = Clock;
  readonly RefreshCcw = RefreshCcw;
  readonly User = User;

  firestore = inject(Firestore);

  callLogs: CallLog[] = [];
  isLoading = false;
  isGenerating = false;

  ngOnInit(): void {
    this.loadCallLogs();
  }

  async loadCallLogs() {
    this.isLoading = true;
    try {
      const q = query(
        collection(this.firestore, 'calls'),
        orderBy('startedAt', 'desc'),
        limit(50)
      );

      const querySnapshot = await getDocs(q);

      this.callLogs = querySnapshot.docs.map(doc => {
        const data = doc.data() as any;
        return {
          id: doc.id,
          ...data,
          startedAt: data.startedAt?.toDate ? data.startedAt.toDate() : data.startedAt,
          endedAt: data.endedAt?.toDate ? data.endedAt.toDate() : data.endedAt
        } as CallLog;
      });

    } catch (e) {
      console.error("Error loading call logs:", e);
    } finally {
      this.isLoading = false;
    }
  }

  // Format duration from seconds to MM:SS
  formatDuration(seconds?: number): string {
    if (!seconds) return '--';
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return `${m}:${s.toString().padStart(2, '0')}`;
  }

  // Generate 25 demo calls
  async generateDemoCalls() {
    this.isGenerating = true;
    try {
      const statuses: ('completed' | 'missed' | 'rejected' | 'failed')[] = ['completed', 'completed', 'completed', 'missed', 'rejected', 'failed'];
      const types: ('video' | 'audio')[] = ['video', 'audio'];

      // Let's create some dummy user templates since we might not have 25 active users with names
      const dummyUsers = [
        { id: 'user_A1', name: 'Alice Smith', email: 'alice@example.com' },
        { id: 'user_B2', name: 'Bob Johnson', email: 'bob@example.com' },
        { id: 'user_C3', name: 'Charlie Dave', email: 'charlie@example.com' },
        { id: 'user_D4', name: 'Diana Prince', email: 'diana@example.com' },
        { id: 'user_E5', name: 'Evan Wright', email: 'evan@example.com' },
        { id: 'user_F6', name: 'Fiona Gallagher', email: 'fiona@example.com' },
      ];

      const callsCollection = collection(this.firestore, 'calls');

      const promises = [];

      for (let i = 0; i < 25; i++) {
        // Pick two distinct users
        let callerIndex = Math.floor(Math.random() * dummyUsers.length);
        let receiverIndex = Math.floor(Math.random() * dummyUsers.length);
        while (callerIndex === receiverIndex) {
          receiverIndex = Math.floor(Math.random() * dummyUsers.length);
        }

        const caller = dummyUsers[callerIndex];
        const receiver = dummyUsers[receiverIndex];

        const type = types[Math.floor(Math.random() * types.length)];
        const status = statuses[Math.floor(Math.random() * statuses.length)];

        // Random time in the past 7 days
        const daysAgo = Math.floor(Math.random() * 7);
        const hoursAgo = Math.floor(Math.random() * 24);
        const date = new Date();
        date.setDate(date.getDate() - daysAgo);
        date.setHours(date.getHours() - hoursAgo);

        const duration = status === 'completed' ? Math.floor(Math.random() * 3600) + 10 : 0; // 10s to 1h

        const endedAtDate = new Date(date.getTime() + (duration * 1000));

        const newDocRef = doc(callsCollection);

        const callData = {
          callerId: caller.id,
          receiverId: receiver.id,
          caller: {
            userId: caller.id,
            name: caller.name,
            email: caller.email
          },
          receiver: {
            userId: receiver.id,
            name: receiver.name,
            email: receiver.email
          },
          type: type,
          status: status,
          startedAt: Timestamp.fromDate(date),
          endedAt: Timestamp.fromDate(endedAtDate),
          durationInSeconds: duration
        };

        promises.push(setDoc(newDocRef, callData));
      }

      await Promise.all(promises);
      await this.loadCallLogs(); // refresh the view
      alert('Successfully generated 25 demo call logs!');
    } catch (e) {
      console.error("Error generating calls:", e);
      alert('Failed to generate mock calls. Ensure Firestore rules allow writes to "calls" collection.');
    } finally {
      this.isGenerating = false;
    }
  }
}
