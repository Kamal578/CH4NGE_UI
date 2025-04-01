import 'package:ch4nge/features/layers/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';
import 'package:bloc/bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _authenticationRepository;

  AuthBloc(this._authenticationRepository) : super(AuthInitState()) {
    on<AuthLoginRequest>(_onLoginRequest);
    on<AuthRegisterRequest>(_onRegisterRequest);
  }

  void _onLoginRequest(AuthLoginRequest event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response = await _authenticationRepository.login(event.email, event.password);
    emit(AuthRequestSuccessState(response));
  }

  void _onRegisterRequest(AuthRegisterRequest event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final response = await _authenticationRepository.register(event.email, event.username, event.password, event.confirmPassword);
    emit(AuthRequestSuccessState(response));
  }
}