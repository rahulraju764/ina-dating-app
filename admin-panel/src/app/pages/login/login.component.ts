import { Component, inject } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { LucideAngularModule, Lock, Mail, AlertCircle } from 'lucide-angular';
import { NgClass } from '@angular/common';

@Component({
    selector: 'app-login',
    standalone: true,
    imports: [ReactiveFormsModule, LucideAngularModule, NgClass],
    templateUrl: './login.component.html'
})
export class LoginComponent {
    readonly Lock = Lock;
    readonly Mail = Mail;
    readonly AlertCircle = AlertCircle;

    loginForm: FormGroup;
    errorMessage: string = '';
    isLoading: boolean = false;

    private fb = inject(FormBuilder);
    private authService = inject(AuthService);
    private router = inject(Router);

    constructor() {
        this.loginForm = this.fb.group({
            email: ['', [Validators.required, Validators.email]],
            password: ['', Validators.required]
        });
    }

    async onSubmit() {
        if (this.loginForm.invalid) return;

        this.isLoading = true;
        this.errorMessage = '';

        const { email, password } = this.loginForm.value;

        try {
            await this.authService.login(email, password);
            this.router.navigate(['/dashboard']);
        } catch (error: any) {
            if (error.code === 'auth/invalid-credential' || error.code === 'auth/user-not-found' || error.code === 'auth/wrong-password') {
                this.errorMessage = 'Incorrect email or password. Please try again.';
            } else {
                this.errorMessage = 'An error occurred during login. Please try again later.';
            }
        } finally {
            this.isLoading = false;
        }
    }
}
