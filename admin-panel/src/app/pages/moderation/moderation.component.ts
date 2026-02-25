import { Component } from '@angular/core';
import { LucideAngularModule, Search, Filter, ShieldAlert, Check, Trash2, Ban, ShieldOff } from 'lucide-angular';
import { NgClass } from '@angular/common';

@Component({
  selector: 'app-moderation',
  standalone: true,
  imports: [LucideAngularModule, NgClass],
  templateUrl: './moderation.component.html'
})
export class ModerationComponent {
  readonly ShieldAlert = ShieldAlert;
  readonly Check = Check;
  readonly Trash2 = Trash2;
  readonly Ban = Ban;
  readonly ShieldOff = ShieldOff;

  tabs = ['Images (18)', 'Profiles (3)', 'Chats (2)'];
  activeTab = 'Images (18)';

  queue = [
    { id: 1, type: 'NSFW Detected', time: '2 mins ago', priority: 'High', image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&auto=format&fit=crop&w=150&q=80', active: true },
    { id: 2, type: 'User Reported', time: '15 mins ago', priority: 'Medium', image: 'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&auto=format&fit=crop&w=150&q=80', active: false },
    { id: 3, type: 'NSFW Detected', time: '1 hour ago', priority: 'High', image: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=150&q=80', active: false }
  ];

  selectedItem = {
    imageUrl: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
    nsfwScore: 0.82,
    uploader: { name: 'Rahul R.', avatar: 'https://i.pravatar.cc/150?u=2', joined: 'Nov 02, 2025', reports: 2 }
  };
}
