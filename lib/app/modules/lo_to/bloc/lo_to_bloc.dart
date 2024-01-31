library lo_to_bloc;

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';

part 'lo_to_events.dart';
part 'lo_to_state.dart';

class LoToBloc extends Bloc<LotoEvent, LotoState> {
  LoToBloc({
    required this.localDataSource,
    // required this.firebaseDatabase,
  }) : super(lotoInitialState) {
    on<InitialEvent>(_initial);
    on<ListenCount>(_listenerCount);
    on<ListenUsers>(_listenerUsers);
    on<UpdateUserName>(_updateUserName);
  }

  final LocalDataSource localDataSource;
  // final LotoFirebaseDatabase firebaseDatabase;

  void _initial(InitialEvent event, Emitter<LotoState> emit) async {
    _listenState();
    var userName = await localDataSource.getUserName();
    if (userName != null) {
      emit(state.copyWith(
        userName: userName,
        status: LotoStatus.userNameSuccess,
      ));
    }
    if (userName == null) {
      emit(state.copyWith(status: LotoStatus.userNameFailure));
    }
  }

  void _listenerCount(ListenCount event, Emitter<LotoState> emit) async {
    int newCountValue = int.parse(event.count.toString());
    emit(state.copyWith(count: newCountValue));
  }

  void _listenerUsers(ListenUsers event, Emitter<LotoState> emit) async {
    List newListUsers = jsonDecode(event.users.toString());
    emit(state.copyWith(listUsers: newListUsers));
  }

  void _updateUserName(UpdateUserName event, Emitter<LotoState> emit) async {
    emit(state.copyWith(status: LotoStatus.loading));
    localDataSource.saveUserName(event.userName);
    await _backDialog(emit);
    // await firebaseDatabase.updateUserName(event.userName, state.listUsers).then(
    //   (value) {
    //     emit(
    //       state.copyWith(
    //         userName: event.userName,
    //         status: LotoStatus.userNameSuccess,
    //       ),
    //     );
    //   },
    // ).catchError((onError) {
    //   emit(state.copyWith(status: LotoStatus.userNameFailure));
    // });
  }

// Functions only used in bloc

  void _listenState() async {
    // await firebaseDatabase.listenData(
    //   (event) async {
    //     add(ListenCount(count: event.snapshot.value.toString()));
    //   },
    // );
    // await firebaseDatabase.listenUsers(
    //   (event) async {
    //     add(ListenUsers(users: event.snapshot.value.toString()));
    //   },
    // );
  }

  Future _backDialog(Emitter<LotoState> emit) async {
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(status: LotoStatus.backDialog));
  }
}
