part of 'app_bar_bloc.dart';

AppBarState appBarInitialState = AppBarState(
  hiddenSearchResults: true,
  drawerWidth: 0.0,
  positionTouches: 0.0,
  status: AppBarStatus.initial,
  searchDynamicStatus: SearchDynamicStatus.nothing,
  searchController: TextEditingController(),
  focusNode: FocusNode(),
  searchResults: [],
);

enum AppBarStatus {
  searching,
  showDrawer,
  showEndDrawer,
  initial,
}

enum SearchDynamicStatus {
  loading,
  nothing,
}

class AppBarState {
  final bool hiddenSearchResults;
  final double drawerWidth;
  final double positionTouches;
  final AppBarStatus status;
  final SearchDynamicStatus searchDynamicStatus;
  final TextEditingController searchController;
  final FocusNode focusNode;
  final List<FriendResult> searchResults;
  const AppBarState({
    required this.hiddenSearchResults,
    required this.drawerWidth,
    required this.positionTouches,
    required this.status,
    required this.searchController,
    required this.focusNode,
    required this.searchResults,
    required this.searchDynamicStatus,
  });

  AppBarState copyWith({
    bool? hiddenSearchResults,
    double? drawerWidth,
    double? positionTouches,
    double? drawerEndWidth,
    AppBarStatus? status,
    SearchDynamicStatus? searchDynamicStatus,
    List<FriendResult>? searchResults,
  }) {
    return AppBarState(
      hiddenSearchResults: hiddenSearchResults ?? this.hiddenSearchResults,
      drawerWidth: drawerWidth ?? this.drawerWidth,
      positionTouches: positionTouches ?? this.positionTouches,
      status: status ?? this.status,
      searchDynamicStatus: searchDynamicStatus ?? this.searchDynamicStatus,
      searchResults: searchResults ?? this.searchResults,
      searchController: searchController,
      focusNode: focusNode,
    );
  }
}
