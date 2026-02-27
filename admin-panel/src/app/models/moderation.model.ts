import { Timestamp } from '@angular/fire/firestore';

export interface ModerationReport {
    id?: string;
    type: 'Image' | 'Profile' | 'Chat';
    status: 'Pending' | 'Reviewed' | 'Action Taken';
    targetId: string;      // ID of the image, profile, or chat
    targetType: string;
    reporterId?: string;   // Who reported it (optional if auto-flagged)
    reason: string;        // 'NSFW Detected', 'User Reported Spam', etc.
    imageUrl?: string;     // The content being reviewed
    nsfwScore?: number;    // From Vision API, 0.0 to 1.0
    createdAt: any;        // Timestamp
    updatedAt?: any;       // Timestamp

    // Denormalized uploader data for easier queue viewing
    uploaderId: string;
    uploader: {
        name: string;
        avatar: string;
        joined: string;
        reports: number;
    };

    // Moderator info metadata
    resolvedBy?: string;
    resolvedAt?: any;
    resolutionNotes?: string;
}
