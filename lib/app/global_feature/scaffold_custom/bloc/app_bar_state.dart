part of 'app_bar_bloc.dart';

AppBarState appBarInitialState = AppBarState(
  status: AppBarStatus.searching,
  searchDynamicStatus: SearchDynamicStatus.nothing,
  searchController: TextEditingController(),
  focusNode: FocusNode(),
  searchResults: ['123'],
);

enum AppBarStatus {
  searching,
  initial,
}

enum SearchDynamicStatus {
  loading,
  nothing,
}

class AppBarState {
  final AppBarStatus status;
  final SearchDynamicStatus searchDynamicStatus;
  final TextEditingController searchController;
  final FocusNode focusNode;
  final List searchResults;
  const AppBarState({
    required this.status,
    required this.searchController,
    required this.focusNode,
    required this.searchResults,
    required this.searchDynamicStatus,
  });

  AppBarState copyWith({
    AppBarStatus? status,
    SearchDynamicStatus? searchDynamicStatus,
    List? searchResults,
  }) {
    return AppBarState(
      status: status ?? this.status,
      searchDynamicStatus: searchDynamicStatus ?? this.searchDynamicStatus,
      searchResults: searchResults ?? this.searchResults,
      searchController: searchController,
      focusNode: focusNode,
    );
  }
}
