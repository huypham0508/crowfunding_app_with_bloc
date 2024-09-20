import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/data/exceptions.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/graphql_response_model.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/modules/friend/models/friend_model.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/modules/friend/models/list_friend_model.dart';

part '../repository/friend_repository.dart';
part 'friend_events.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final FriendRepository friendRepository;

  FriendBloc({required this.friendRepository}) : super(authInitialState) {
    on<InitialFriendEvent>(_initial);
    on<GetFriendsEvent>(_getFriends);
    on<GetFriendsRequestEvent>(_getFriendsRequest);
    on<RejectRequestEvent>(_rejectRequest);
    on<AcceptRequestEvent>(_acceptRequest);
  }

  void _initial(InitialFriendEvent event, Emitter<FriendState> emit) async {
    add(GetFriendsEvent());
    add(GetFriendsRequestEvent());
  }

  void _rejectRequest(
    RejectRequestEvent event,
    Emitter<FriendState> emit,
  ) async {
    try {
      final response = await friendRepository.rejectedRequest(event.requestId);
      if (response.success == true) {
        state.friendsRequest.removeWhere((item) => item.id == event.requestId);

        emit(state.copyWith());
      }
    } catch (e) {
      print(e);
    }
  }

  void _acceptRequest(
    AcceptRequestEvent event,
    Emitter<FriendState> emit,
  ) async {
    try {
      final response = await friendRepository.acceptRequest(event.requestId);
      print(response.message);
      if (response.success == true) {
        final findRequest = state.friendsRequest.firstWhere(
          (element) => element.id == event.requestId,
        );
        state.friendsRequest.removeWhere((item) => item.id == event.requestId);

        final newFriends = [
          ...[findRequest],
          ...state.friends,
        ];

        emit(state.copyWith(friends: newFriends));
      }
    } catch (e) {
      print(e);
    }
  }

  void _getFriends(GetFriendsEvent event, Emitter<FriendState> emit) async {
    try {
      final response = await friendRepository.getFriends();
      if (response.success == true) {
        emit(state.copyWith(friends: response.data ?? []));
        return;
      }
      emit(state.copyWith(status: FriendStatus.loadFailed));
    } catch (e) {
      emit(state.copyWith(status: FriendStatus.loadFailed));
    }
  }

  void _getFriendsRequest(
    GetFriendsRequestEvent event,
    Emitter<FriendState> emit,
  ) async {
    try {
      final response = await friendRepository.getFriendsRequest();
      if (response.success == true) {
        emit(
          state.copyWith(
            status: FriendStatus.loaded,
            friendsRequest: response.data ?? [],
          ),
        );
        return;
      }
      emit(state.copyWith(status: FriendStatus.loadFailed));
    } catch (e) {
      emit(state.copyWith(status: FriendStatus.loadFailed));
    }
  }
}
