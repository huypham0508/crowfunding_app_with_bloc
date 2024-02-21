part of 'app_bar_bloc.dart';

AppBarState appBarInitialState = AppBarState(
  status: AppBarStatus.initial,
  searchController: TextEditingController(),
);

enum AppBarStatus {
  loading,
  searching,
  success,
  initial,
}

class AppBarState {
  final AppBarStatus status;
  final TextEditingController searchController;
  const AppBarState({
    required this.status,
    required this.searchController,
  });

  AppBarState copyWith({
    AppBarStatus? status,
  }) {
    return AppBarState(
      status: status ?? this.status,
      searchController: searchController,
    );
  }
}
