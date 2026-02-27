import { Routes } from '@angular/router';
import { LayoutComponent } from './layout/layout.component';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { UsersComponent } from './pages/users/users.component';
import { ModerationComponent } from './pages/moderation/moderation.component';
import { SubscriptionsComponent } from './pages/subscriptions/subscriptions.component';
import { GiftsComponent } from './pages/gifts/gifts.component';
import { CampaignsComponent } from './pages/campaigns/campaigns.component';
import { SettingsComponent } from './pages/settings/settings.component';

export const routes: Routes = [
    {
        path: '',
        component: LayoutComponent,
        children: [
            { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
            { path: 'dashboard', component: DashboardComponent },
            { path: 'users', component: UsersComponent },
            { path: 'moderation', component: ModerationComponent },
            { path: 'subscriptions', component: SubscriptionsComponent },
            { path: 'gifts', component: GiftsComponent },
            { path: 'campaigns', component: CampaignsComponent },
            { path: 'settings', component: SettingsComponent },
            { path: '**', redirectTo: 'dashboard' }
        ]
    }
];
