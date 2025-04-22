import 'package:ch4nge/core/di/service_locator.dart';
import 'package:ch4nge/features/layers/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _authenticationRepository = serviceLocator<IAuthenticationRepository>();

  AuthBloc() : super(AuthInitState()) {
    on<AuthLoginRequest>(_onLoginRequest);
    on<AuthRegisterRequest>(_onRegisterRequest);
    on<AuthLogoutRequest>(_onLogoutRequest);
  }

  void _onLoginRequest(AuthLoginRequest event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response = await _authenticationRepository.login(event.email, event.password);
    emit(AuthRequestSuccessState(response));
  }

  void _onRegisterRequest(AuthRegisterRequest event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response = await _authenticationRepository.register(event.email, event.password, event.username);
    emit(AuthRequestSuccessState(response));
  }

  void _onLogoutRequest(AuthLogoutRequest event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response = await _authenticationRepository.logout();
    emit(AuthRequestSuccessState(response));
  }
}