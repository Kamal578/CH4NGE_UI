part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginRequest extends AuthEvent {
  String email;
  String password;

  AuthLoginRequest(this.email, this.password);
}

class AuthRegisterRequest extends AuthEvent {
  String email;
  String username;
  String password;
  String confirmPassword;
  
  AuthRegisterRequest(this.email, this.username, this.password, this.confirmPassword);
}
