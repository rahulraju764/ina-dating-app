import { ApplicationConfig } from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideCharts, withDefaultRegisterables } from 'ng2-charts';

import { routes } from './app.routes';
import { provideFirebaseApp, initializeApp } from '@angular/fire/app';
import { getFirestore, provideFirestore } from '@angular/fire/firestore';
import { getAuth, provideAuth } from '@angular/fire/auth';

const firebaseConfig = {
  projectId: "dating-app-58efd",
  appId: "1:159421512119:web:fa869d65379db9bc24d032",
  databaseURL: "https://dating-app-58efd-default-rtdb.asia-southeast1.firebasedatabase.app",
  storageBucket: "dating-app-58efd.firebasestorage.app",
  apiKey: "AIzaSyC1PRheileuXS_m9er3LYh9bwjioaJRuHY",
  authDomain: "dating-app-58efd.firebaseapp.com",
  messagingSenderId: "159421512119",
  measurementId: "G-CHWCK040E3"
};

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    provideCharts(withDefaultRegisterables()),
    provideFirebaseApp(() => initializeApp(firebaseConfig)),
    provideFirestore(() => getFirestore()),
    provideAuth(() => getAuth())
  ]
};
