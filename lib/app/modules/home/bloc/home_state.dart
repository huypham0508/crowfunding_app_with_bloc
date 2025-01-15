part of '../index.dart';

const pageSize = 10;

HomeState homeInitialState = HomeState(
  tabIndex: 2,
  pageNumberPostsAll: 1,
  pageNumberPostsYourFr: 1,
  pageNumberYourPosts: 1,
  allPosts: [],
  yourPosts: [],
  postsYourFriends: [],
  loadingAllPosts: true,
  loadingPostsYourFriends: true,
  loadingYourPosts: true,
  pageController: PageController(
    initialPage: 2,
    keepPage: true,
  ),
);

class HomeState {
  final int tabIndex;
  final int pageNumberPostsAll;
  final int pageNumberPostsYourFr;
  final int pageNumberYourPosts;
  final PageController pageController;
  final List<PostsData> allPosts;
  final List<PostsData> yourPosts;
  final List<PostsData> postsYourFriends;
  final bool loadingAllPosts;
  final bool loadingPostsYourFriends;
  final bool loadingYourPosts;

  HomeState({
    required this.tabIndex,
    required this.pageNumberPostsAll,
    required this.pageNumberPostsYourFr,
    required this.pageNumberYourPosts,
    required this.pageController,
    required this.allPosts,
    required this.yourPosts,
    required this.postsYourFriends,
    required this.loadingAllPosts,
    required this.loadingPostsYourFriends,
    required this.loadingYourPosts,
  });

  HomeState copyWith({
    int? tabIndex,
    int? pageNumberPostAll,
    int? pageNumberPostsYourFr,
    int? pageNumberYourPosts,
    PageController? pageController,
    List<PostsData>? allPosts,
    List<PostsData>? yourPosts,
    List<PostsData>? postsYourFriends,
    bool? loadingAllPosts,
    bool? loadingPostsYourFriends,
    bool? loadingYourPosts,
  }) {
    return HomeState(
      tabIndex: tabIndex ?? this.tabIndex,
      pageNumberPostsAll: pageNumberPostAll ?? this.pageNumberPostsAll,
      pageNumberPostsYourFr:
          pageNumberPostsYourFr ?? this.pageNumberPostsYourFr,
      pageNumberYourPosts: pageNumberYourPosts ?? this.pageNumberYourPosts,
      pageController: pageController ?? this.pageController,
      allPosts: allPosts ?? this.allPosts,
      yourPosts: yourPosts ?? this.yourPosts,
      postsYourFriends: postsYourFriends ?? this.postsYourFriends,
      loadingAllPosts: loadingAllPosts ?? this.loadingAllPosts,
      loadingPostsYourFriends:
          loadingPostsYourFriends ?? this.loadingPostsYourFriends,
      loadingYourPosts: loadingYourPosts ?? this.loadingYourPosts,
    );
  }
}
