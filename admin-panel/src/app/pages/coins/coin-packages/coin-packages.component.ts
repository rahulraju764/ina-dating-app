import { Component, OnInit, inject } from '@angular/core';
import { CommonModule, NgClass } from '@angular/common';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { LucideAngularModule, Search, Plus, Edit, Trash2, Check, X, Coins, Settings } from 'lucide-angular';
import { Firestore, collection, getDocs, doc, setDoc, updateDoc, deleteDoc, Timestamp, query, orderBy } from '@angular/fire/firestore';
import { CoinPackage } from '../../../models/coin.model';

@Component({
  selector: 'app-coin-packages',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule, LucideAngularModule, NgClass],
  templateUrl: './coin-packages.component.html'
})
export class CoinPackagesComponent implements OnInit {
  // Icons
  readonly Search = Search;
  readonly Plus = Plus;
  readonly Edit = Edit;
  readonly Trash2 = Trash2;
  readonly Check = Check;
  readonly X = X;
  readonly Coins = Coins;
  readonly Settings = Settings;

  firestore = inject(Firestore);
  fb = inject(FormBuilder);

  packages: CoinPackage[] = [];
  isLoading = false;

  // Modal State
  showModal = false;
  isEditing = false;
  editingId: string | null = null;
  packageForm: FormGroup;

  constructor() {
    this.packageForm = this.fb.group({
      name: ['', Validators.required],
      emoji: ['🪙', Validators.required],
      priceINR: [0, [Validators.required, Validators.min(1)]],
      coinsAwarded: [0, [Validators.required, Validators.min(1)]],
      bonusCoins: [0, Validators.min(0)],
      sortOrder: [0, Validators.required],
      isActive: [true],
      isFeatured: [false]
    });
  }

  ngOnInit(): void {
    this.loadPackages();
  }

  async loadPackages() {
    this.isLoading = true;
    try {
      const q = query(collection(this.firestore, 'coinPackages'), orderBy('sortOrder', 'asc'));
      const querySnapshot = await getDocs(q);
      const docs = querySnapshot.docs;

      this.packages = docs.map(doc => {
        const data = doc.data();
        return {
          id: doc.id,
          ...data
        } as CoinPackage;
      });
    } catch (e) {
      console.error("Error loading coin packages:", e);
    } finally {
      this.isLoading = false;
    }
  }

  openAddModal() {
    this.isEditing = false;
    this.editingId = null;
    this.packageForm.reset({
      emoji: '🪙',
      priceINR: 100,
      coinsAwarded: 100,
      bonusCoins: 0,
      sortOrder: this.packages.length + 1,
      isActive: true,
      isFeatured: false
    });
    this.showModal = true;
  }

  openEditModal(pkg: CoinPackage) {
    this.isEditing = true;
    this.editingId = pkg.id || null;
    this.packageForm.patchValue({
      name: pkg.name,
      emoji: pkg.emoji,
      priceINR: pkg.priceINR,
      coinsAwarded: pkg.coinsAwarded,
      bonusCoins: pkg.bonusCoins,
      sortOrder: pkg.sortOrder,
      isActive: pkg.isActive,
      isFeatured: pkg.isFeatured
    });
    this.showModal = true;
  }

  closeModal() {
    this.showModal = false;
  }

  async savePackage() {
    if (this.packageForm.invalid) return;

    this.isLoading = true;
    try {
      const formValue = this.packageForm.value;

      if (this.isEditing && this.editingId) {
        // Update existing
        const docRef = doc(this.firestore, `coinPackages/${this.editingId}`);
        await updateDoc(docRef, { ...formValue, updatedAt: Timestamp.now() });
      } else {
        // Create new
        const newDocRef = doc(collection(this.firestore, 'coinPackages'));
        await setDoc(newDocRef, {
          ...formValue,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now()
        });
      }

      this.closeModal();
      await this.loadPackages();
    } catch (e) {
      console.error("Error saving package:", e);
      alert("Failed to save. Check permissions.");
    } finally {
      this.isLoading = false;
    }
  }

  async deletePackage(pkg: CoinPackage) {
    if (confirm(`Are you sure you want to delete ${pkg.name}?`)) {
      this.isLoading = true;
      try {
        await deleteDoc(doc(this.firestore, `coinPackages/${pkg.id}`));
        await this.loadPackages();
      } catch (e) {
        console.error("Error deleting package", e);
        alert("Failed to delete.");
      } finally {
        this.isLoading = false;
      }
    }
  }

  async toggleActive(pkg: CoinPackage) {
    try {
      pkg.isActive = !pkg.isActive; // optimistic update
      const docRef = doc(this.firestore, `coinPackages/${pkg.id}`);
      await updateDoc(docRef, { isActive: pkg.isActive });
    } catch (e) {
      console.error("Error toggling active status", e);
      pkg.isActive = !pkg.isActive; // revert
    }
  }
}
