import 'package:crowfunding_app_with_bloc/app/global_bloc/scaffold_custom/app_bar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventWrapper extends StatefulWidget {
  const EventWrapper({super.key, required this.child});
  final Widget child;

  @override
  State<EventWrapper> createState() => _EventWrapperState();
}

class _EventWrapperState extends State<EventWrapper> {
  late AppBarBloc appBarBloc;

  @override
  void initState() {
    appBarBloc = context.read<AppBarBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Listener(
      onPointerDown: (event) {
        appBarBloc.add(
          WipeScaffoldStartAppBarEvent(position: event.position.dx),
        );
      },
      onPointerUp: (PointerUpEvent event) => appBarBloc.add(
        WipeScaffoldEndAppBarEvent(),
      ),
      onPointerMove: (PointerMoveEvent event) {
        double position = appBarBloc.state.positionTouches;
        if (position > 100 && position < width - 100) {
          if (event.position.dy < height / 4) {
            appBarBloc.add(
              WipeLeftToRightAppBarEvent(
                wipeDx: event.delta.dx,
              ),
            );
          }
        }
      },
      child: widget.child,
    );
  }
}
