import 'package:bloc/bloc.dart';
import 'package:crowfunding_app_with_bloc/app/data/repository/graphql/post_repository.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'rooms_events.dart';
part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  final PostRepository postRepository;

  RoomsBloc({required this.postRepository}) : super(roomInitialState) {
    on<InitialRoomsEvent>(_initial);
    // on<GetAllPosts>(_getAllPosts);
    // on<GetPostsYourFriend>(_getPostsYourFriend);
    // on<GetYourPosts>(_getYourPosts);
    // on<ChangeTabHomeEvent>(_changeTab);
    // on<JumpToPage>(_jumpToPage);
  }

  void _initial(InitialRoomsEvent event, Emitter<RoomsState> emit) async {
    print("initial rooms bloc");
    emit(state.copyWith(loading: true));
    await Future.delayed(500.ms);
    emit(state.copyWith(loading: false));

    // add(GetAllPosts());
    // add(GetPostsYourFriend());
    // add(GetYourPosts());
  }

  // void _getAllPosts(
  //   GetAllPosts event,
  //   Emitter<RoomsState> emit,
  // ) async {
  //   bool checkNullPageNum = event.pageNumber == null;
  //   if (!checkNullPageNum) {
  //     emit(state.copyWith(loadingAllPosts: true));
  //   }
  //   final response = await postRepository.getAllPosts(
  //     pageSize: pageSize,
  //     pageNumber: event.pageNumber ?? state.pageNumberPostsAll,
  //   );

  //   if (response.success == true) {
  //     emit(
  //       state.copyWith(
  //         loadingAllPosts: false,
  //         allPosts: !checkNullPageNum
  //             ? response.data ?? []
  //             : [...state.allPosts, ...response.data!],
  //         pageNumberPostAll: !checkNullPageNum
  //             ? event.pageNumber! + 1
  //             : state.pageNumberPostsAll + 1,
  //       ),
  //     );
  //   } else {
  //     emit(state.copyWith(loadingAllPosts: false));
  //   }
  // }

  // void _getPostsYourFriend(
  //   GetPostsYourFriend event,
  //   Emitter<RoomsState> emit,
  // ) async {
  //   bool checkNullPageNum = event.pageNumber == null;
  //   if (!checkNullPageNum) {
  //     emit(state.copyWith(loadingPostsYourFriends: true));
  //   }
  //   final response = await postRepository.getPostsYourFriend(
  //     pageSize: pageSize,
  //     pageNumber: event.pageNumber ?? state.pageNumberPostsYourFr,
  //   );

  //   if (response.success == true) {
  //     emit(
  //       state.copyWith(
  //         loadingPostsYourFriends: false,
  //         postsYourFriends: !checkNullPageNum
  //             ? response.data ?? []
  //             : [...state.postsYourFriends, ...response.data!],
  //         pageNumberPostsYourFr: !checkNullPageNum
  //             ? event.pageNumber! + 1
  //             : state.pageNumberPostsYourFr + 1,
  //       ),
  //     );
  //   } else {
  //     emit(state.copyWith(loadingPostsYourFriends: false));
  //   }
  // }

  // void _getYourPosts(
  //   GetYourPosts event,
  //   Emitter<RoomsState> emit,
  // ) async {
  //   bool checkNullPageNum = event.pageNumber == null;
  //   if (!checkNullPageNum) {
  //     emit(state.copyWith(loadingYourPosts: true));
  //   }
  //   final response = await postRepository.getYourPosts(
  //     pageSize: pageSize,
  //     pageNumber: event.pageNumber ?? state.pageNumberYourPosts,
  //   );

  //   if (response.success == true) {
  //     emit(
  //       state.copyWith(
  //         loadingYourPosts: false,
  //         yourPosts: !checkNullPageNum
  //             ? response.data ?? []
  //             : [...state.yourPosts, ...response.data!],
  //         pageNumberYourPosts: !checkNullPageNum
  //             ? event.pageNumber! + 1
  //             : state.pageNumberYourPosts + 1,
  //       ),
  //     );
  //   } else {
  //     emit(state.copyWith(loadingYourPosts: false));
  //   }
  // }

  // void _changeTab(ChangeTabHomeEvent event, Emitter<RoomsState> emit) async {
  //   if (event.index == state.tabIndex) {
  //     switch (event.index) {
  //       case 0:
  //         add(GetYourPosts(pageNumber: 1));
  //         break;
  //       case 1:
  //         add(GetPostsYourFriend(pageNumber: 1));
  //         break;
  //       case 2:
  //         add(GetAllPosts(pageNumber: 1));
  //         break;
  //     }
  //   } else {
  //     if (!event.gesture) {
  //       add(JumpToPage(index: event.index));
  //     }
  //     emit(state.copyWith(tabIndex: event.index));
  //   }
  // }

  // void _jumpToPage(JumpToPage event, Emitter<RoomsState> emit) async {
  //   if (event.index == state.tabIndex) {
  //     add(ChangeTabHomeEvent(index: event.index));
  //   } else {
  //     state.pageController.jumpToPage(event.index);
  //   }
  // }
}
