import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'profile_events.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LocalDataSource localDataSource;

  ProfileBloc({
    required this.localDataSource,
  }) : super(authInitialState) {
    on<InitialProfileEvent>(_initial);
    on<ChangeProfileImageEvent>(_changeImage);
  }

  void _initial(InitialProfileEvent event, Emitter<ProfileState> emit) async {
    state.userNameController.text = 'tungdoan123';

    emit(state.copyWith(
      avatar: AppImages.imAvatar,
      username: 'tungdoan123',
    ));

    await Future.delayed(500.ms);

    emit(state.copyWith(status: ProfileStatus.backModel));
  }

  void _changeImage(
    ChangeProfileImageEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(avatar: event.image, status: ProfileStatus.loading));
    await Future.delayed(200.ms);
    emit(state.copyWith(status: ProfileStatus.backModel));
  }
}
