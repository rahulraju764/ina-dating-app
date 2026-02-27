import { Component } from '@angular/core';
import { LucideAngularModule, Search, Filter, Plus, Edit, Trash2, Gift, Eye } from 'lucide-angular';
import { NgClass } from '@angular/common';

@Component({
    selector: 'app-gifts',
    standalone: true,
    imports: [LucideAngularModule, NgClass],
    templateUrl: './gifts.component.html'
})
export class GiftsComponent {
    readonly Search = Search;
    readonly Filter = Filter;
    readonly Plus = Plus;
    readonly Edit = Edit;
    readonly Trash2 = Trash2;
    readonly Gift = Gift;
    readonly Eye = Eye;

    categories = ['All', 'Romantic', 'Fun', 'Premium', 'Celebration'];
    activeCategory = 'All';

    gifts = [
        { name: 'Red Rose', emoji: '🌹', price: 50, category: 'Romantic', sent: 12480, active: true },
        { name: 'Teddy Bear', emoji: '🧸', price: 100, category: 'Romantic', sent: 8320, active: true },
        { name: 'Diamond Ring', emoji: '💍', price: 500, category: 'Premium', sent: 2150, active: true },
        { name: 'Party Popper', emoji: '🎉', price: 30, category: 'Celebration', sent: 15600, active: true },
        { name: 'Love Letter', emoji: '💌', price: 25, category: 'Romantic', sent: 18900, active: true },
        { name: 'Chocolate Box', emoji: '🍫', price: 75, category: 'Romantic', sent: 9400, active: true },
        { name: 'Crown', emoji: '👑', price: 300, category: 'Premium', sent: 3200, active: true },
        { name: 'Laughing Face', emoji: '😂', price: 10, category: 'Fun', sent: 24500, active: true },
        { name: 'Fire', emoji: '🔥', price: 15, category: 'Fun', sent: 21800, active: true },
        { name: 'Star', emoji: '⭐', price: 20, category: 'Fun', sent: 19200, active: true },
        { name: 'Birthday Cake', emoji: '🎂', price: 60, category: 'Celebration', sent: 7600, active: true },
        { name: 'Champagne', emoji: '🍾', price: 200, category: 'Premium', sent: 4100, active: false },
    ];

    get filteredGifts() {
        if (this.activeCategory === 'All') return this.gifts;
        return this.gifts.filter(g => g.category === this.activeCategory);
    }

    getCategoryColor(category: string): string {
        switch (category) {
            case 'Romantic': return 'bg-brand-pink/10 text-brand-pink border-brand-pink/20';
            case 'Fun': return 'bg-[#00C896]/10 text-[#00C896] border-[#00C896]/20';
            case 'Premium': return 'bg-[#9B1FDB]/10 text-[#9B1FDB] border-[#9B1FDB]/20';
            case 'Celebration': return 'bg-[#FFD93D]/10 text-[#FFD93D] border-[#FFD93D]/20';
            default: return 'bg-[#2A2A3E] text-[#B0B0C3] border-[#2A2A3E]';
        }
    }
}
