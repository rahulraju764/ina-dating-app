import { Timestamp } from '@angular/fire/firestore';

export interface CoinTransaction {
    id?: string;
    userId: string;
    type: "purchase" | "spend" | "earn" | "withdrawal" | "refund" | "admin_adjustment";
    amount: number;
    balanceAfter: number;
    referenceId: string;
    referenceType: "payment" | "game" | "gift" | "call" | "withdrawal" | "admin";
    description: string;
    createdAt: Timestamp | Date;
    status: "completed" | "pending" | "failed" | "reversed";
}

export interface CoinPackage {
    id?: string;
    name: string;
    emoji: string;
    priceINR: number;
    coinsAwarded: number;
    bonusCoins: number;
    isActive: boolean;
    isFeatured: boolean;
    sortOrder: number;
    createdAt?: Timestamp | Date;
    updatedAt?: Timestamp | Date;
}

export interface WithdrawalRequest {
    id?: string;
    userId: string;
    coinsRequested: number;
    inrEquivalent: number;
    payoutMethod: "upi" | "bank" | "wallet";
    payoutDetails: string;
    status: "pending" | "processing" | "completed" | "rejected";
    requestedAt: Timestamp | Date;
    processedAt: Timestamp | Date | null;
    adminNote: string | null;
    processedBy: string | null;
}
