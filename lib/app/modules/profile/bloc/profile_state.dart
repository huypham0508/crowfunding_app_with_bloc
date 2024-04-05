part of 'profile_bloc.dart';

ProfileState authInitialState = ProfileState(
  status: ProfileStatus.loading,
  avatar: '',
  username: '',
  userNameController: TextEditingController(),
);

enum ProfileStatus {
  loading,
  nothing,
  loadSuccess,
  loadFailure,
  backModel,
}

class ProfileState {
  final ProfileStatus status;
  final String avatar;
  final String username;
  final TextEditingController userNameController;
  const ProfileState({
    required this.avatar,
    required this.username,
    required this.status,
    required this.userNameController,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String? avatar,
    String? username,
  }) {
    return ProfileState(
      status: status ?? this.status,
      avatar: avatar ?? this.avatar,
      username: username ?? this.username,
      userNameController: userNameController,
    );
  }
}
