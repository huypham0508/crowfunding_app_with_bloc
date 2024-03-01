import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/bloc/app_bar_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/action_button.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/primary_content.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/search_dynamic.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_linear_to_ease_out.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indexed/indexed.dart';

class ScaffoldCustom extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool drawerScrimBehavior;
  final double drawerEdgeDragWidth;
  final double drawerWidth;
  final double endDrawerEdgeDragWidth;
  final double? bottomNavigationBarHeight;
  final Clip? bottomNavigationBarClipBehavior;
  final double? bottomAppBarElevation;
  final Color? bottomAppBarColor;
  final NotchedShape? bottomAppBarShape;
  final bool drawerEnableOpenDragGesture;

  final Color? drawerScrimColor;
  final bool endDrawerEnableOpenDragGesture;
  final void Function(bool)? onDrawerChanged;
  final void Function(bool)? onEndDrawerChanged;
  final AlignmentDirectional persistentFooterAlignment;
  final String? restorationId;

  const ScaffoldCustom({
    Key? key,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimBehavior = true,
    this.drawerEdgeDragWidth = 20.0,
    this.drawerWidth = 304.0,
    this.endDrawerEdgeDragWidth = 20.0,
    this.bottomNavigationBarHeight,
    this.bottomNavigationBarClipBehavior,
    this.bottomAppBarElevation,
    this.bottomAppBarColor,
    this.bottomAppBarShape,
    this.drawerEnableOpenDragGesture = true,
    this.drawerScrimColor,
    this.endDrawerEnableOpenDragGesture = true,
    this.onDrawerChanged,
    this.onEndDrawerChanged,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.restorationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBarBloc(),
        ),
      ],
      child: Scaffold(
        key: key,
        body: CustomChild(body: body),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        persistentFooterButtons: persistentFooterButtons,
        drawer: drawer,
        endDrawer: endDrawer,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        primary: primary,
        drawerDragStartBehavior: drawerDragStartBehavior,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        drawerScrimColor: drawerScrimColor,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        onDrawerChanged: onDrawerChanged,
        onEndDrawerChanged: onEndDrawerChanged,
        persistentFooterAlignment: persistentFooterAlignment,
        restorationId: restorationId,
      ),
    );
  }
}

class CustomChild extends StatefulWidget {
  const CustomChild({super.key, required this.body});
  final Widget body;

  @override
  State<CustomChild> createState() => _CustomChildState();
}

class _CustomChildState extends State<CustomChild> {
  late AppBarBloc appBarBloc;

  @override
  void initState() {
    appBarBloc = context.read<AppBarBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Listener(
      onPointerMove: (PointerMoveEvent event) => appBarBloc.add(
        WipeScaffoldAppBarEvent(
          wipeDx: event.delta.dx,
        ),
      ),
      onPointerUp: (PointerUpEvent event) => appBarBloc.add(
        WipeScaffoldEndAppBarEvent(),
      ),
      child: Container(
        color: AppColors.whitish100,
        child: Indexer(
          children: [
            const Indexed(
              index: 2,
              child: SearchDynamic(),
            ),
            BlocBuilder<AppBarBloc, AppBarState>(builder: (context, state) {
              return Indexed(
                index: state.status == AppBarStatus.searching ? 1 : 3,
                child: ActionButtons(
                  onTapMenu: () {
                    appBarBloc.add(
                      WipeScaffoldAppBarEvent(
                        wipeDx: 160,
                      ),
                    );
                  },
                ),
              );
            }),
            BlocBuilder<AppBarBloc, AppBarState>(builder: (context, state) {
              return Indexed(
                index: state.status == AppBarStatus.searching ? 1 : 3,
                child: PrimaryContent(body: widget.body),
              );
            }),
            Indexed(
              index: 4,
              child: BlocBuilder<AppBarBloc, AppBarState>(
                  builder: (context, state) {
                return FadeLinearToEaseOut(
                  child: AnimatedContainer(
                    curve: Curves.linear,
                    height: height,
                    duration: state.drawerWidth > 150 ? 350.ms : 100.ms,
                    width: state.drawerWidth > 150 ? width : state.drawerWidth,
                    color: AppColors.whitish100.withOpacity(
                      state.drawerWidth > 150
                          ? 1
                          : calculateOpacity(
                              state.drawerWidth,
                            ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BoxShadowCustom(
                          child: AnimatedContainer(
                            duration: 300.ms,
                            curve: Curves.linear,
                            color: AppColors.whitish100,
                            height: height / 6 * 4,
                            width: width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            child: state.drawerWidth > 150
                                ? const Center(
                                    child: Text("123"),
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  double calculateOpacity(double width) {
    return width / 300;
  }
}
