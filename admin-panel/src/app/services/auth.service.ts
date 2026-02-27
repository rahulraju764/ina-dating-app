import { Injectable, inject } from '@angular/core';
import { Auth, signInWithEmailAndPassword, signOut, user, User } from '@angular/fire/auth';
import { Observable } from 'rxjs';

@Injectable({
    providedIn: 'root'
})
export class AuthService {
    private auth: Auth = inject(Auth);

    // Expose the authenticated user as an Observable
    public authState$: Observable<User | null> = user(this.auth);

    async login(email: string, pass: string) {
        return signInWithEmailAndPassword(this.auth, email, pass);
    }

    async logout() {
        return signOut(this.auth);
    }
}
