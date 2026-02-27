import { Component } from '@angular/core';
import { LucideAngularModule, Settings, Bell, Shield, Smartphone, Save, Globe, Mail, Key, Clock, MapPin, Heart, Users, RotateCcw } from 'lucide-angular';
import { NgClass } from '@angular/common';

@Component({
    selector: 'app-settings',
    standalone: true,
    imports: [LucideAngularModule, NgClass],
    templateUrl: './settings.component.html'
})
export class SettingsComponent {
    readonly Settings = Settings;
    readonly Bell = Bell;
    readonly Shield = Shield;
    readonly Smartphone = Smartphone;
    readonly Save = Save;
    readonly Globe = Globe;
    readonly Mail = Mail;
    readonly Key = Key;
    readonly Clock = Clock;
    readonly MapPin = MapPin;
    readonly Heart = Heart;
    readonly Users = Users;
    readonly RotateCcw = RotateCcw;

    tabs = [
        { label: 'General', icon: Settings },
        { label: 'Notifications', icon: Bell },
        { label: 'Security', icon: Shield },
        { label: 'App Config', icon: Smartphone }
    ];
    activeTab = 'General';

    // General settings
    appName = 'INA Dating App';
    supportEmail = 'support@ina-app.com';
    defaultLanguage = 'English';
    languages = ['English', 'Hindi', 'Tamil', 'Telugu', 'Malayalam', 'Kannada'];
    maintenanceMode = false;

    // Notification settings
    emailNotifications = true;
    pushNotifications = true;
    smsNotifications = false;
    marketingEmails = true;
    matchAlerts = true;
    weeklyReports = true;

    // Security settings
    twoFactorAuth = true;
    sessionTimeout = 30;
    passwordMinLength = 8;
    requireSpecialChars = true;
    maxLoginAttempts = 5;
    ipWhitelisting = false;

    // App config
    matchRadius = 50;
    dailySwipeLimit = 100;
    minimumAge = 18;
    maximumAge = 65;
    superLikesPerDay = 5;
    boostDuration = 30;
    profilePhotoMin = 2;
    profilePhotoMax = 9;
}
