export interface SubscriptionPlan {
    id?: string;
    name: string;      // Free, Gold, Platinum
    price: string;     // $14.99
    duration: string;  // /month, /year
    features: string;  // comma-separated or simple text
    activeUsers: number;
    status: 'Active' | 'Paused';
    tier: 'Free' | 'Gold' | 'Platinum';
    createdAt?: any;   // Timestamp
    updatedAt?: any;   // Timestamp
}

export interface SubscriptionTransaction {
    id?: string;
    userId: string;
    userName: string;
    userEmail: string;
    planId: string;
    planName: string;
    amount: string;
    date: any;         // Timestamp
    status: 'Completed' | 'Refunded' | 'Failed';
    avatarUrl?: string;
}
