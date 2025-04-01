import 'package:either_dart/either.dart';

abstract class IAuthenticationRepository {
  Future<Either<String, String>> register(String email, String password, String confirmPassword, String name);
  Future<Either<String, String>> login(String email, String password);
}
