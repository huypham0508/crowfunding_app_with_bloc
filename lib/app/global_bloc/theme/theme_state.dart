part of 'theme_bloc.dart';

ThemeState authInitialState = const ThemeState(
  status: ThemeStatus.system,
);

enum ThemeStatus { system, dark, light }

class ThemeState {
  final ThemeStatus status;
  const ThemeState({
    required this.status,
  });

  ThemeState copyWith({
    ThemeStatus? status,
  }) {
    return ThemeState(
      status: status ?? this.status,
    );
  }
}
