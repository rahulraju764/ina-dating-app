import { inject } from '@angular/core';
import { Router, CanActivateFn } from '@angular/router';
import { AuthService } from '../services/auth.service';
import { map, take } from 'rxjs/operators';

export const authGuard: CanActivateFn = () => {
    const authService = inject(AuthService);
    const router = inject(Router);

    return authService.authState$.pipe(
        take(1),
        map(user => {
            if (user) {
                return true;
            }

            // Redirect to login if not authenticated
            router.navigate(['/login']);
            return false;
        })
    );
};
