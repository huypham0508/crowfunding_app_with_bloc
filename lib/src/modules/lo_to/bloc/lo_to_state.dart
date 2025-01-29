part of 'lo_to_bloc.dart';

const lotoInitialState = LotoState(
  status: LotoStatus.loading,
  count: 0,
  listUsers: [],
  userName: '',
);

enum LotoStatus { loading, userNameSuccess, userNameFailure, backDialog }

class LotoState {
  final LotoStatus status;
  final int count;
  final List listUsers;
  final String userName;
  const LotoState({
    required this.status,
    required this.count,
    required this.listUsers,
    required this.userName,
  });

  LotoState copyWith({
    LotoStatus? status,
    int? count,
    List? listUsers,
    String? userName,
  }) {
    return LotoState(
      status: status ?? this.status,
      count: count ?? this.count,
      listUsers: listUsers ?? this.listUsers,
      userName: userName ?? this.userName,
    );
  }
}
