import 'package:ch4nge/features/layers/data/datasources/datasource_achievements.dart';
import 'package:ch4nge/features/layers/data/datasources/datasource_auth.dart';
import 'package:ch4nge/features/layers/data/datasources/mini_challenge_datasource.dart';
import 'package:ch4nge/features/layers/data/repositories/achievement_repository.dart';
import 'package:ch4nge/features/layers/data/repositories/action_repository.dart';
import 'package:ch4nge/features/layers/data/repositories/activity_repository.dart';
import 'package:ch4nge/features/layers/data/repositories/auth_repository_impl.dart';
import 'package:ch4nge/features/layers/data/repositories/mini_challenge.dart';
import 'package:ch4nge/features/layers/data/repositories/post_repository.dart';
import 'package:ch4nge/features/layers/data/repositories/user_repository.dart';
import 'package:ch4nge/features/layers/data/repositories/weekly_challenge_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/achievement_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/action_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/activity_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/auth_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/mini_challenge_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/post_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/weekly_challenge_repository.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_achievement_progress.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_all_achievements.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_all_users.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_current_location.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_friends.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_friends_activities.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_mini_challenges.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_next_achievement.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_posts.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_user.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_weekly_challenge.dart';
import 'package:ch4nge/features/layers/domain/use_cases/upload_action.dart';
import 'package:ch4nge/features/layers/domain/use_cases/upload_post_form.dart';
import 'package:ch4nge/features/layers/presentation/screens/authentication/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ch4nge/core/network/network_client.dart';
import 'package:ch4nge/core/shared/config.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

setupServiceLocator() async {
  serviceLocator.registerSingleton(Config());
  serviceLocator.registerSingleton(
      NetworkClient(config: serviceLocator<Config>()));
  serviceLocator.registerFactory(() => serviceLocator<NetworkClient>().dio);
  serviceLocator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  // Datasources
  serviceLocator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  serviceLocator.registerFactory<IAchievementsDatasource>(() => AchievementsRemote());
  serviceLocator.registerFactory<IMiniChallengeDatasource>(
      () => MiniChallengeRemote());


  // Repositories
  serviceLocator.registerLazySingleton<IAuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
  serviceLocator
      .registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  serviceLocator.registerLazySingleton<WeeklyChallengeRepository>(
      () => WeeklyChallengeRepositoryImpl());
  serviceLocator.registerLazySingleton<AchievementRepository>(
      () => AchievementRepositoryImpl(datasource: serviceLocator()));
  serviceLocator.registerLazySingleton<MiniChallengeRepository>(
      () => MiniChallengeRepositoryImpl(datasource: serviceLocator()));
  serviceLocator.registerLazySingleton<ActivityRepository>(
      () => ActivityRepositoryImpl());
  serviceLocator
      .registerLazySingleton<ActionRepository>(() => ActionRepositoryImpl());
  serviceLocator
      .registerLazySingleton<PostRepository>(() => PostRepositoryImpl());

  // Use cases
  serviceLocator.registerFactory(() => GetUserUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetWeeklyChallengeUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetNextAchievementUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetAchievementProgressUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetMiniChallengesUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetAllAchievementsUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllUsersUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => GetFriendsUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetFriendsActivitiesUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => UploadActionUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => GetCurrentLocationUseCase());
  serviceLocator.registerFactory(() => GetPostsUseCase(
        serviceLocator(),
        serviceLocator(),
      ));
  serviceLocator.registerFactory(() => UploadPostFormUseCase(serviceLocator()));

  // Blocs
  serviceLocator.registerLazySingleton(() => AuthBloc());
}
