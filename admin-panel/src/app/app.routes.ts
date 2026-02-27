import { Routes } from '@angular/router';
import { authGuard } from './guards/auth.guard';
import { LayoutComponent } from './layout/layout.component';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { UsersComponent } from './pages/users/users.component';
import { ModerationComponent } from './pages/moderation/moderation.component';
import { SubscriptionsComponent } from './pages/subscriptions/subscriptions.component';
import { GiftsComponent } from './pages/gifts/gifts.component';
import { CampaignsComponent } from './pages/campaigns/campaigns.component';
import { SettingsComponent } from './pages/settings/settings.component';
import { LoginComponent } from './pages/login/login.component';

export const routes: Routes = [
    { path: 'login', component: LoginComponent },
    {
        path: '',
        component: LayoutComponent,
        canActivate: [authGuard],
        children: [
            { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
            { path: 'dashboard', component: DashboardComponent },
            { path: 'users', component: UsersComponent },
            { path: 'moderation', component: ModerationComponent },
            { path: 'subscriptions', component: SubscriptionsComponent },
            { path: 'gifts', component: GiftsComponent },
            { path: 'campaigns', component: CampaignsComponent },
            { path: 'calls', loadComponent: () => import('./pages/calls/call-logs/call-logs.component').then(m => m.CallLogsComponent) },
            { path: 'coins/packages', loadComponent: () => import('./pages/coins/coin-packages/coin-packages.component').then(m => m.CoinPackagesComponent) },
            { path: 'coins/ledger', loadComponent: () => import('./pages/coins/coin-ledger/coin-ledger.component').then(m => m.CoinLedgerComponent) },
            { path: 'coins/withdrawals', loadComponent: () => import('./pages/coins/withdrawals/withdrawals.component').then(m => m.WithdrawalsComponent) },
            { path: 'settings', component: SettingsComponent },
            { path: '**', redirectTo: 'dashboard' }
        ]
    }
];
