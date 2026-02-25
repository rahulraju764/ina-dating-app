import { Component } from '@angular/core';
import { LucideAngularModule, RefreshCw } from 'lucide-angular';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [LucideAngularModule],
  templateUrl: './header.component.html',
})
export class HeaderComponent {
  readonly RefreshCw = RefreshCw;
  todayDate = new Date().toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
}
