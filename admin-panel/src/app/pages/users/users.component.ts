import { Component } from '@angular/core';
import { LucideAngularModule, Search, Filter, Download, MoreVertical, Eye, ShieldOff, Trash2 } from 'lucide-angular';
import { NgClass } from '@angular/common';

@Component({
  selector: 'app-users',
  standalone: true,
  imports: [LucideAngularModule, NgClass],
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

  users = [
    { name: 'Meera M.', email: 'meera@example.com', age: 24, tier: 'Free', joined: 'Oct 12, 2025', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=1' },
    { name: 'Rahul R.', email: 'rahul@example.com', age: 28, tier: 'Gold', joined: 'Nov 02, 2025', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=2' },
    { name: 'Anjali K.', email: 'anjali@example.com', age: 26, tier: 'Platinum', joined: 'Dec 15, 2025', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=3' },
    { name: 'Arjun P.', email: 'arjun@example.com', age: 22, tier: 'Free', joined: 'Jan 05, 2026', status: 'Suspended', avatar: 'https://i.pravatar.cc/150?u=4' },
    { name: 'Sneha L.', email: 'sneha@example.com', age: 25, tier: 'Free', joined: 'Feb 10, 2026', status: 'Banned', avatar: 'https://i.pravatar.cc/150?u=5' }
  ];
}
