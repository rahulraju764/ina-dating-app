import { Component } from '@angular/core';
import { BaseChartDirective } from 'ng2-charts';
import { ChartConfiguration, ChartData } from 'chart.js';
import { LucideAngularModule, ArrowUpRight, AlertTriangle } from 'lucide-angular';
import { RouterLink } from '@angular/router';
import { NgClass } from '@angular/common';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [BaseChartDirective, LucideAngularModule, RouterLink, NgClass],
  templateUrl: './dashboard.component.html'
})
export class DashboardComponent {
  readonly ArrowUpRight = ArrowUpRight;
  readonly AlertTriangle = AlertTriangle;

  public lineChartOptions: ChartConfiguration['options'] = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: { display: false }
    },
    scales: {
      y: {
        grid: { color: '#2A2A3E' },
        ticks: { color: '#B0B0C3' }
      },
      x: {
        grid: { display: false },
        ticks: { color: '#B0B0C3' }
      }
    }
  };

  public lineChartData: ChartData<'line', number[], string> = {
    labels: ['1w', '2w', '3w', '4w', '5w', '6w', '7w'],
    datasets: [
      {
        data: [12000, 13400, 12800, 14200, 14000, 15100, 14821],
        label: 'DAU',
        borderColor: '#E91E8C',
        backgroundColor: 'rgba(233, 30, 140, 0.1)',
        fill: true,
        tension: 0.4
      }
    ]
  };

  public donutChartOptions: ChartConfiguration['options'] = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: { position: 'right', labels: { color: '#ffffff' } }
    }
  };

  public donutChartData: ChartData<'doughnut', number[], string> = {
    labels: ['Free', 'Gold', 'Platinum'],
    datasets: [
      {
        data: [85000, 12000, 5483],
        backgroundColor: ['#2A2A3E', '#FFD93D', '#9B1FDB'],
        borderWidth: 0
      }
    ]
  };

  recentUsers = [
    { name: 'Meera M.', email: 'meera@example.com', tier: 'Free', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=1' },
    { name: 'Rahul R.', email: 'rahul@example.com', tier: 'Gold', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=2' },
    { name: 'Anjali K.', email: 'anjali@example.com', tier: 'Platinum', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=3' },
    { name: 'Arjun P.', email: 'arjun@example.com', tier: 'Free', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=4' },
    { name: 'Sneha L.', email: 'sneha@example.com', tier: 'Free', status: 'Active', avatar: 'https://i.pravatar.cc/150?u=5' }
  ];
}
