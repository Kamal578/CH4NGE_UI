import 'package:ch4nge/core/di/service_locator.dart';
import 'package:ch4nge/core/utils/exception.dart';
import 'package:ch4nge/features/layers/data/datasources/datasource_auth.dart';
import 'package:ch4nge/features/layers/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';

class AuthenticationRepositoryImpl implements IAuthenticationRepository {
  final IAuthenticationDatasource _datasource =
      serviceLocator<IAuthenticationDatasource>();

  @override
  Future<Either<String, String>> login(String email, String password) async {
    try {
      String token = await _datasource.login(email, password);
      if (token.isNotEmpty) {
        return Right('login');
      } else {
        return Left("Error");
      }
    } on ApiException catch (ex) {
      return Left("${ex.message}");
    }
  }

  @override
  Future<Either<String, String>> register(String email, String password,
      String confirmPassword, String name) async {
    try {
      await _datasource.register(email, password, confirmPassword, name);
      return Right('Done');
    } on ApiException catch (ex) {
      return Left("${ex.message}");
    }
  }
}
