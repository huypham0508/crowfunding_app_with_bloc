part of '../../index.dart';

class ForgotPwBloc extends Bloc<ForgotPwEvent, ForgotPwState> {
  final AuthRepository authRepository;

  ForgotPwBloc({
    required this.authRepository,
  }) : super(ForgotPwInitialState) {
    on<BackModelForgotPwEvent>(_backDialog);
    on<ClosePopupForgotPwEvent>(_closePopup);
    on<StartedForgotPwEvent>(
      _forgotPw,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
  }

  void _forgotPw(
    StartedForgotPwEvent event,
    Emitter<ForgotPwState> emit,
  ) async {
    String? valueValidation = event.validate();
    _emitErrorMessage(emit, valueValidation);
    bool checkType = (event.type == StartedForgotPwEventEnum.submitted);
    if (checkType && valueValidation == null) {
      await _processForgotPw(event, emit);
    }
  }

  void _emitErrorMessage(Emitter<ForgotPwState> emit, String? errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage ?? ""));
  }

  _processForgotPw(
    StartedForgotPwEvent event,
    Emitter<ForgotPwState> emit,
  ) async {
    emit(state.copyWith(status: ForgotPwStatus.loading));

    Map<int, CallToServerStatus> statusMap = {
      0: CallToServerStatus.sendMailSuccess,
      1: CallToServerStatus.sendOtpSuccess,
      2: CallToServerStatus.sendNewPasswordSuccess,
    };

    try {
      late final ForgotPwResponse result;

      switch (event.step) {
        case 0:
          result = await authRepository.sendOtpWithEmail(event.forgotPwModel);
          break;
        case 1:
          result = await authRepository.submitOTP(event.forgotPwModel);
          break;
        case 2:
          event.forgotPwModel.token = state.token;
          result = await authRepository.resetPassword(event.forgotPwModel);
          break;
      }
      if (result.success == true) {
        emit(state.copyWith(
          step: event.step + 1,
          textButton: event.textNext,
          status: ForgotPwStatus.nothing,
          callApiStatus: statusMap[event.step],
          token: result.accessToken,
        ));
      } else {
        emit(state.copyWith(
          status: ForgotPwStatus.nothing,
          errorMessage: result.message ?? "",
          callApiStatus: CallToServerStatus.failed,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPwStatus.nothing,
        errorMessage: e.toString(),
        callApiStatus: CallToServerStatus.failed,
      ));
    }
    add(BackModelForgotPwEvent());
  }

  Future _closePopup(
    ClosePopupForgotPwEvent event,
    Emitter<ForgotPwState> emit,
  ) async {
    emit(state.copyWith(callApiStatus: CallToServerStatus.normal));
  }

  //local function
  Future _backDialog(
    BackModelForgotPwEvent event,
    Emitter<ForgotPwState> emit,
  ) async {
    emit(state.copyWith(status: ForgotPwStatus.backDialog));
  }
}
