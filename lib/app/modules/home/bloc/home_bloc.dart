import 'package:bloc/bloc.dart';

part 'home_events.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(homeInitialState) {
    on<InitialHomeEvent>(_initial);
  }

  void _initial(InitialHomeEvent event, Emitter<HomeState> emit) async {
    print('initial');
  }
}
