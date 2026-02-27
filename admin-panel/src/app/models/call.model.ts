export interface CallParticipant {
    userId: string;
    name?: string;
    photoUrl?: string;
    email?: string;
}

export interface CallLog {
    id?: string;
    callerId: string;
    receiverId: string;
    caller: CallParticipant;
    receiver: CallParticipant;
    type: 'video' | 'audio';
    status: 'ongoing' | 'completed' | 'missed' | 'rejected' | 'failed';
    startedAt: any; // Timestamp or Date
    endedAt?: any; // Timestamp or Date
    durationInSeconds?: number;
}
