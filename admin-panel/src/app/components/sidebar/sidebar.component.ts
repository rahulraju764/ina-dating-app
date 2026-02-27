import { Component, inject } from '@angular/core';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { LucideAngularModule, LayoutDashboard, Users, ShieldAlert, CreditCard, Gift, Send, Settings, LogOut } from 'lucide-angular';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [RouterLink, RouterLinkActive, LucideAngularModule],
  templateUrl: './sidebar.component.html',
})
export class SidebarComponent {
  readonly LayoutDashboard = LayoutDashboard;
  readonly Users = Users;
  readonly ShieldAlert = ShieldAlert;
  readonly CreditCard = CreditCard;
  readonly Gift = Gift;
  readonly Send = Send;
  readonly Settings = Settings;
  readonly LogOut = LogOut;

  private authService = inject(AuthService);
  private router = inject(Router);

  menuItems = [
    { label: 'Dashboard', route: '/dashboard', icon: LayoutDashboard },
    { label: 'Users', route: '/users', icon: Users },
    { label: 'Moderation', route: '/moderation', icon: ShieldAlert },
    { label: 'Subscriptions', route: '/subscriptions', icon: CreditCard },
    { label: 'Gift Catalogue', route: '/gifts', icon: Gift },
    { label: 'Push Campaigns', route: '/campaigns', icon: Send },
    { label: 'Settings', route: '/settings', icon: Settings },
  ];

  async logout() {
    await this.authService.logout();
    this.router.navigate(['/login']);
  }
}
