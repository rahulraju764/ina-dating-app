import { Component } from '@angular/core';
import { LucideAngularModule, ArrowUpRight, ArrowDownRight, Filter, Download, CreditCard, TrendingUp, UserMinus, Search, Edit, Trash2, ToggleLeft, ToggleRight } from 'lucide-angular';
import { NgClass } from '@angular/common';

@Component({
  selector: 'app-subscriptions',
  standalone: true,
  imports: [LucideAngularModule, NgClass],
  templateUrl: './subscriptions.component.html'
})
export class SubscriptionsComponent {
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

  stats = [
    { label: 'Active Subscribers', value: '17,483', change: '+4.2%', positive: true, icon: CreditCard },
    { label: 'Monthly Revenue', value: '$24,850', change: '+12.5%', positive: true, icon: TrendingUp },
    { label: 'Churn Rate', value: '2.4%', change: '-0.3%', positive: true, icon: UserMinus }
  ];

  plans = [
    { name: 'Free', price: '$0', duration: 'Forever', features: 'Basic swipes, Limited likes', activeUsers: 85000, status: 'Active', tier: 'Free' },
    { name: 'Gold', price: '$14.99', duration: '/month', features: 'Unlimited likes, See who liked you, 5 Super Likes/day', activeUsers: 12000, status: 'Active', tier: 'Gold' },
    { name: 'Platinum', price: '$29.99', duration: '/month', features: 'Priority boost, Unlimited Super Likes, Read receipts, Undo swipes', activeUsers: 5483, status: 'Active', tier: 'Platinum' },
    { name: 'Gold Annual', price: '$99.99', duration: '/year', features: 'All Gold features, 2 months free', activeUsers: 3200, status: 'Active', tier: 'Gold' },
    { name: 'Platinum Annual', price: '$199.99', duration: '/year', features: 'All Platinum features, 3 months free', activeUsers: 1850, status: 'Active', tier: 'Platinum' },
    { name: 'Weekly Boost', price: '$4.99', duration: '/week', features: 'Profile boost for 7 days', activeUsers: 890, status: 'Paused', tier: 'Free' },
  ];

  transactions = [
    { user: 'Meera M.', email: 'meera@example.com', plan: 'Gold', amount: '$14.99', date: 'Feb 26, 2026', status: 'Completed', avatar: 'https://i.pravatar.cc/150?u=1' },
    { user: 'Rahul R.', email: 'rahul@example.com', plan: 'Platinum', amount: '$29.99', date: 'Feb 25, 2026', status: 'Completed', avatar: 'https://i.pravatar.cc/150?u=2' },
    { user: 'Anjali K.', email: 'anjali@example.com', plan: 'Gold Annual', amount: '$99.99', date: 'Feb 24, 2026', status: 'Completed', avatar: 'https://i.pravatar.cc/150?u=3' },
    { user: 'Arjun P.', email: 'arjun@example.com', plan: 'Platinum', amount: '$29.99', date: 'Feb 23, 2026', status: 'Refunded', avatar: 'https://i.pravatar.cc/150?u=4' },
    { user: 'Sneha L.', email: 'sneha@example.com', plan: 'Gold', amount: '$14.99', date: 'Feb 22, 2026', status: 'Completed', avatar: 'https://i.pravatar.cc/150?u=5' },
  ];
}
