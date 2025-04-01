import 'package:ch4nge/features/layers/data/datasources/datasource_auth.dart';
import 'package:ch4nge/features/layers/data/repositories/auth_repository_impl.dart';
import 'package:ch4nge/features/layers/domain/repositories/auth_repository.dart';
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
      .registerFactory(<IAuthenticationDatasource>() => AuthenticationRemote());

  // Repositories
  serviceLocator.registerLazySingleton<IAuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
}
