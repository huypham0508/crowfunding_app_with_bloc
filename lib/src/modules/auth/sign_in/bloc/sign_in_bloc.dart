part of '../../index.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;
  final BiometricService biometric;

  SignInBloc({
    required this.authRepository,
    required this.biometric,
  }) : super(signInInitialState) {
    on<InitialSignInEvent>(_initial);
    on<StartedLoginEvent>(
      _login,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
  }

  _initial(InitialSignInEvent event, Emitter<SignInState> emit) async {
    // emit(state.copyWith(loginBiometric: await biometric.checkSupported()));
  }

  void _login(StartedLoginEvent event, Emitter<SignInState> emit) async {
    String? valueValidation = event.validate();
    _emitErrorMessage(emit, valueValidation);

    bool checkType = (event.type == StartedLoginEventEnum.submitted);
    if (checkType && valueValidation == null) {
      await _processLogin(event, emit);
    }
  }

  //local function
  Future _backDialog(Emitter<SignInState> emit) async {
    emit(state.copyWith(status: SignInStatus.backDialog));
  }

  void _emitErrorMessage(Emitter<SignInState> emit, String? errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage ?? ""));
  }

  Future<void> _processLogin(
    StartedLoginEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: SignInStatus.loading));
    try {
      final result = await authRepository.login(event.loginModel);
      await _backDialog(emit);
      if (result.success == true) {
        emit(state.copyWith(status: SignInStatus.loginSuccess));
      } else {
        emit(state.copyWith(
          status: SignInStatus.loginFailure,
          errorMessage: result.message,
        ));
      }
    } catch (e) {
      await _backDialog(emit);
      emit(state.copyWith(
        status: SignInStatus.loginFailure,
        errorMessage: e.toString(),
      ));
    }
  }
}
