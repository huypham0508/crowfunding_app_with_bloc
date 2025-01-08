part of 'rooms_bloc.dart';

enum RoomStatus { loading, loaded, init }

RoomsState roomInitialState = RoomsState(
  loading: false,
);

class RoomsState {
  final bool loading;

  RoomsState({
    required this.loading,
  });

  RoomsState copyWith({
    bool? loading,
  }) {
    return RoomsState(
      loading: loading ?? this.loading,
    );
  }
}
