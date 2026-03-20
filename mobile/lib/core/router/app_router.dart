import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/auth/splash_screen.dart';
import '../../presentation/auth/welcome_screen.dart';
import '../../presentation/auth/login_screen.dart';
import '../../presentation/auth/register_screen.dart';
import '../../presentation/home/home_shell.dart';
import '../../presentation/discovery/discovery_screen.dart';
import '../../presentation/matches/matches_screen.dart';
import '../../presentation/chat/chat_screen.dart';
import '../../presentation/profile/my_profile_screen.dart';
import '../../presentation/profile/edit_profile_screen.dart';
import '../../presentation/profile/public_profile_screen.dart';
import '../../presentation/gifts/gift_shop_screen.dart';
import '../../presentation/purchases/premium_screen.dart';
import '../../presentation/discovery/match_animation_screen.dart';
import '../../presentation/calls/incoming_call_screen.dart';
import '../../presentation/calls/video_call_screen.dart';
import '../../presentation/onboarding/profile_setup_screen.dart';
import '../../presentation/settings/settings_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const ProfileSetupScreen(),
    ),
    GoRoute(
      path: '/match-animation',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return MatchAnimationScreen(
          matchedUserName: extra?['userName'] ?? 'Someone',
          matchedUserPhoto: extra?['userPhoto'] ?? '',
          myPhoto: extra?['myPhoto'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/incoming-call',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return IncomingCallScreen(
          callerName: extra?['callerName'] ?? 'Unknown',
          callerPhoto: extra?['callerPhoto'] ?? '',
          isVideoCall: extra?['isVideoCall'] ?? true,
        );
      },
    ),
    GoRoute(
      path: '/video-call',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return VideoCallScreen(
          partnerName: extra?['partnerName'] ?? 'Unknown',
          partnerPhoto: extra?['partnerPhoto'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/profile/:userId',
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        return PublicProfileScreen(userId: userId);
      },
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/premium',
      builder: (context, state) => const PremiumScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => HomeShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const DiscoveryScreen(),
        ),
        GoRoute(
          path: '/matches',
          builder: (context, state) => const MatchesScreen(),
        ),
        GoRoute(
          path: '/chat/:chatId',
          builder: (context, state) {
            final chatId = state.pathParameters['chatId']!;
            final extra = state.extra as Map<String, dynamic>?;
            return ChatScreen(
              chatId: chatId,
              partnerName: extra?['partnerName'] ?? '',
              partnerPhoto: extra?['partnerPhoto'] ?? '',
              isOnline: extra?['isOnline'] ?? false,
            );
          },
        ),
        GoRoute(
          path: '/gifts',
          builder: (context, state) => const GiftShopScreen(),
        ),
        GoRoute(
          path: '/my-profile',
          builder: (context, state) => const MyProfileScreen(),
        ),
      ],
    ),
  ],
);
