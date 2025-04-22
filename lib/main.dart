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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kReleaseMode) {
    await dotenv.load(fileName: '.env.prod');
  } else {
    await dotenv.load(fileName: '.env.dev');
  }

  setupServiceLocator();
  runApp(MyApp());
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
          builder: (context, state) => HomePage(
            key: UniqueKey(),
            getUserUseCase: serviceLocator(),
            getWeeklyChallengeUseCase: serviceLocator(),
            getNextAchievementUseCase: serviceLocator(),
          ),
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) => AuthPage(),
        ),
        GoRoute(
          path: '/leaderboard',
          builder: (context, state) => LeaderboardPage(
            key: UniqueKey(),
            getAllUsersUseCase: serviceLocator(),
          ),
        ),
        GoRoute(
          path: '/feed',
          builder: (context, state) => const FeedPage(),
        ),
        GoRoute(
          path: '/challenges',
          builder: (context, state) => ChallengesPage(
            key: UniqueKey(),
            getWeeklyChallengeUseCase: serviceLocator(),
            getAchievementProgressUseCase: serviceLocator(),
            getMiniChallengesUseCase: serviceLocator(),
          ),
        ),
        GoRoute(
          path: '/map',
          builder: (context, state) => MapPage(
            key: UniqueKey(),
            getFriendsActivitiesUseCase: serviceLocator(),
            getFriendsUseCase: serviceLocator(),
          ),
        ),
        GoRoute(
          path: '/achievements',
          builder: (context, state) => AchievementsPage(
            key: UniqueKey(),
            getAllAchievementsUseCase: serviceLocator(),
          ),
        ),
        GoRoute(
          path: '/actions',
          builder: (context, state) => ActionsPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => SettingsPage(),
        ),
      ],
    );

    return ScreenUtilInit(
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
