import 'package:ch4nge/features/layers/presentation/screens/authentication/auth.dart';
import 'package:ch4nge/features/layers/presentation/screens/challenges/achievements_page.dart';
import 'package:ch4nge/features/layers/presentation/screens/challenges/challenges_page.dart';
import 'package:ch4nge/features/layers/presentation/screens/feed/feed_page.dart';
import 'package:ch4nge/features/layers/presentation/screens/home/view/actions_page.dart';
import 'package:ch4nge/features/layers/presentation/screens/home/view/home_page.dart';
import 'package:ch4nge/features/layers/presentation/screens/leaderboard/leaderboard_page.dart';
import 'package:ch4nge/features/layers/presentation/screens/map/map_page.dart';
import 'package:ch4nge/features/layers/presentation/screens/settings/settings_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    await dotenv.load(fileName: '.env.prod');
  } else {
    await dotenv.load(fileName: '.env.dev');
  }

  await setupServiceLocator();
  await serviceLocator.allReady();
  runApp(MyApp());
}

// Custom page transition builder for iOS-style transitions
Page<T> buildPageWithTransition<T extends Object?>(
  BuildContext context,
  GoRouterState state,
  Widget child, {
  PageTransitionType transitionType = PageTransitionType.slide,
}) {
  if (!kIsWeb && Platform.isIOS) {
    switch (transitionType) {
      case PageTransitionType.slide:
        return CustomTransitionPage<T>(
          key: state.pageKey,
          child: child,
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
                  CurveTween(curve: Curves.easeInOut),
                ),
              ),
              child: child,
            );
          },
        );
      case PageTransitionType.fade:
        return CustomTransitionPage<T>(
          key: state.pageKey,
          child: child,
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation.drive(
                CurveTween(curve: Curves.easeInOut),
              ),
              child: child,
            );
          },
        );
      case PageTransitionType.scale:
        return CustomTransitionPage<T>(
          key: state.pageKey,
          child: child,
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: animation.drive(
                Tween(begin: 0.8, end: 1.0).chain(
                  CurveTween(curve: Curves.easeInOut),
                ),
              ),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      case PageTransitionType.cupertino:
        return CupertinoPage<T>(
          key: state.pageKey,
          child: child,
        );
    }
  }

  // Default material page for Android
  return MaterialPage<T>(
    key: state.pageKey,
    child: child,
  );
}

// Enum for different transition types
enum PageTransitionType {
  slide,
  fade,
  scale,
  cupertino,
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/auth',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => buildPageWithTransition(
            context,
            state,
            HomePage(
              key: UniqueKey(),
              getUserUseCase: serviceLocator(),
              getWeeklyChallengeUseCase: serviceLocator(),
              getNextAchievementUseCase: serviceLocator(),
            ),
            transitionType: PageTransitionType.cupertino,
          ),
        ),
        GoRoute(
          path: '/auth',
          pageBuilder: (context, state) => buildPageWithTransition(
            context,
            state,
            AuthPage(),
            transitionType: PageTransitionType.fade,
          ),
        ),
        GoRoute(
          path: '/leaderboard',
          pageBuilder: (context, state) => buildPageWithTransition(
            context,
            state,
            LeaderboardPage(
              key: UniqueKey(),
              getAllUsersUseCase: serviceLocator(),
            ),
            transitionType: PageTransitionType.slide,
          ),
        ),
        GoRoute(
          path: '/feed',
          pageBuilder: (context, state) => buildPageWithTransition(
            context,
            state,
            FeedPage(
              key: UniqueKey(),
              getPostsUseCase: serviceLocator(),
              uploadPostFormUseCase: serviceLocator(),
              likePostUseCase: serviceLocator(),
              sharePostUseCase: serviceLocator(),
            ),
            transitionType: PageTransitionType.cupertino,
          ),
        ),
        GoRoute(
          path: '/challenges',
          pageBuilder: (context, state) => buildPageWithTransition(
            context,
            state,
            ChallengesPage(
              key: UniqueKey(),
              getWeeklyChallengeUseCase: serviceLocator(),
              getAchievementProgressUseCase: serviceLocator(),
              getMiniChallengesUseCase: serviceLocator(),
            ),
            transitionType: PageTransitionType.slide,
          ),
        ),
        GoRoute(
          path: '/map',
          pageBuilder: (context, state) => buildPageWithTransition(
            context,
            state,
            MapPage(
              key: UniqueKey(),
              getFriendsActivitiesUseCase: serviceLocator(),
              getFriendsUseCase: serviceLocator(),
              getAllUsersUseCase: serviceLocator(),
              updateFriendsUseCase: serviceLocator(),
            ),
            transitionType: PageTransitionType.cupertino,
          ),
        ),
        GoRoute(
          path: '/achievements',
          pageBuilder: (context, state) => buildPageWithTransition(
            context,
            state,
            AchievementsPage(
              key: UniqueKey(),
              getAllAchievementsUseCase: serviceLocator(),
            ),
            transitionType: PageTransitionType.scale,
          ),
        ),
        GoRoute(
          path: '/actions',
          pageBuilder: (context, state) => buildPageWithTransition(
            context,
            state,
            ActionsPage(
              uploadActionUseCase: serviceLocator(),
              getCurrentLocationUseCase: serviceLocator(),
            ),
            transitionType: PageTransitionType.slide,
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => buildPageWithTransition(
            context,
            state,
            SettingsPage(
              key: UniqueKey(),
              getUserUseCase: serviceLocator(),
            ),
            transitionType: PageTransitionType.cupertino,
          ),
        ),
      ],
    );

    return ScreenUtilInit(
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF7DD334)),
          useMaterial3: true,
        ),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
