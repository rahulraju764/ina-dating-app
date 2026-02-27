import { Component } from '@angular/core';
import { LucideAngularModule, Send, Users, CheckCircle, MousePointerClick, Plus, Eye, Copy, Trash2, Clock, Bell, Target, ArrowUpRight } from 'lucide-angular';
import { NgClass } from '@angular/common';

@Component({
    selector: 'app-campaigns',
    standalone: true,
    imports: [LucideAngularModule, NgClass],
    templateUrl: './campaigns.component.html'
})
export class CampaignsComponent {
    readonly Send = Send;
    readonly Users = Users;
    readonly CheckCircle = CheckCircle;
    readonly MousePointerClick = MousePointerClick;
    readonly Plus = Plus;
    readonly Eye = Eye;
    readonly Copy = Copy;
    readonly Trash2 = Trash2;
    readonly Clock = Clock;
    readonly Bell = Bell;
    readonly Target = Target;
    readonly ArrowUpRight = ArrowUpRight;

    stats = [
        { label: 'Total Sent', value: '184,200', icon: Send, color: 'brand-pink' },
        { label: 'Delivered', value: '179,850', icon: CheckCircle, color: '[#00C896]' },
        { label: 'Opened', value: '62,340', icon: Eye, color: '[#FFD93D]' },
        { label: 'Click Rate', value: '8.4%', icon: MousePointerClick, color: '[#9B1FDB]' }
    ];

    campaigns = [
        { title: 'Valentine\'s Day Special', audience: 'All Users', sent: '102,483', delivered: '99,200', opened: '34,800', ctr: '12.3%', status: 'Sent', date: 'Feb 14, 2026' },
        { title: 'New Match Alert Template', audience: 'Active Users', sent: '14,821', delivered: '14,500', opened: '8,200', ctr: '22.1%', status: 'Sent', date: 'Feb 20, 2026' },
        { title: 'Weekend Boost Promo', audience: 'Free Tier', sent: '85,000', delivered: '82,000', opened: '18,400', ctr: '6.2%', status: 'Sent', date: 'Feb 22, 2026' },
        { title: 'Gold Upgrade Reminder', audience: 'Free Tier', sent: '0', delivered: '0', opened: '0', ctr: '0%', status: 'Scheduled', date: 'Mar 01, 2026' },
        { title: 'Spring Festival Campaign', audience: 'All Users', sent: '0', delivered: '0', opened: '0', ctr: '0%', status: 'Draft', date: '—' },
    ];

    showCompose = false;
    audiences = ['All Users', 'Active Users', 'Free Tier', 'Gold Tier', 'Platinum Tier', 'Inactive (30d+)'];
}
