part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class InitialThemeEvent extends ThemeEvent {}

class SwitchModeThemeEvent extends ThemeEvent {
  final ThemeStatus mode;
  SwitchModeThemeEvent({required this.mode});
}
