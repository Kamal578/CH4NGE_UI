import 'package:ch4nge/features/layers/data/datasources/datasource_auth.dart';
import 'package:ch4nge/features/layers/data/repositories/achievement_repository.dart';
import 'package:ch4nge/features/layers/data/repositories/auth_repository_impl.dart';
import 'package:ch4nge/features/layers/data/repositories/user_repository.dart';
import 'package:ch4nge/features/layers/data/repositories/weekly_challenge_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/achievement_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/auth_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/user_repository.dart';
import 'package:ch4nge/features/layers/domain/repositories/weekly_challenge_repository.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_next_achievement.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_user.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_weekly_challenge.dart';
import 'package:ch4nge/features/layers/presentation/screens/authentication/bloc/auth_bloc.dart';
import 'package:ch4nge/features/layers/presentation/screens/home/bloc/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ch4nge/core/network/network_client.dart';
import 'package:ch4nge/core/shared/config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

setupServiceLocator() async {
  serviceLocator.registerSingleton(Config());
  serviceLocator.registerSingleton(
      NetworkClient(Dio(), config: serviceLocator<Config>()));
  serviceLocator.registerFactory(() => serviceLocator<NetworkClient>().dio);
  serviceLocator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  // Register the AuthenticationRemote datasource
  serviceLocator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());

  // Repositories
  serviceLocator.registerLazySingleton<IAuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
  serviceLocator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl());
  serviceLocator.registerLazySingleton<WeeklyChallengeRepository>(
      () => WeeklyChallengeRepositoryImpl());
  serviceLocator.registerLazySingleton<AchievementRepository>(
      () => AchievementRepositoryImpl());

  // Use cases
  serviceLocator.registerFactory(() => GetUserUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetWeeklyChallengeUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetNextAchievementUseCase(serviceLocator()));

  // Blocs
  serviceLocator.registerLazySingleton(() => AuthBloc());
  serviceLocator.registerLazySingleton(() => HomePageBloc(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ));
}
