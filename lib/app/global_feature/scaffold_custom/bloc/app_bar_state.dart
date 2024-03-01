part of 'app_bar_bloc.dart';

AppBarState appBarInitialState = AppBarState(
  hiddenSearchResults: true,
  drawerWidth: 0.0,
  status: AppBarStatus.initial,
  searchDynamicStatus: SearchDynamicStatus.nothing,
  searchController: TextEditingController(),
  focusNode: FocusNode(),
  searchResults: [],
);

enum AppBarStatus {
  searching,
  showDrawer,
  initial,
}

enum SearchDynamicStatus {
  loading,
  nothing,
}

class AppBarState {
  final bool hiddenSearchResults;
  final double drawerWidth;
  final AppBarStatus status;
  final SearchDynamicStatus searchDynamicStatus;
  final TextEditingController searchController;
  final FocusNode focusNode;
  final List searchResults;
  const AppBarState({
    required this.hiddenSearchResults,
    required this.drawerWidth,
    required this.status,
    required this.searchController,
    required this.focusNode,
    required this.searchResults,
    required this.searchDynamicStatus,
  });

  AppBarState copyWith({
    bool? hiddenSearchResults,
    double? drawerWidth,
    AppBarStatus? status,
    SearchDynamicStatus? searchDynamicStatus,
    List? searchResults,
  }) {
    return AppBarState(
      hiddenSearchResults: hiddenSearchResults ?? this.hiddenSearchResults,
      drawerWidth: drawerWidth ?? this.drawerWidth,
      status: status ?? this.status,
      searchDynamicStatus: searchDynamicStatus ?? this.searchDynamicStatus,
      searchResults: searchResults ?? this.searchResults,
      searchController: searchController,
      focusNode: focusNode,
    );
  }
}
