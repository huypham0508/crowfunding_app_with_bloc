import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/src/data/repository/graphql/appBar_repository.dart';
import 'package:crowfunding_app_with_bloc/src/global/blocs/scaffold_custom/app_bar_bloc.dart';
import 'package:crowfunding_app_with_bloc/src/global/features/scaffold_custom/widgets/action_button.dart';
import 'package:crowfunding_app_with_bloc/src/global/features/scaffold_custom/widgets/drawer_custom.dart';
import 'package:crowfunding_app_with_bloc/src/global/features/scaffold_custom/widgets/event_wapper.dart';
import 'package:crowfunding_app_with_bloc/src/global/features/scaffold_custom/widgets/primary_content.dart';
import 'package:crowfunding_app_with_bloc/src/global/features/scaffold_custom/widgets/search_dynamic.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/animated/fade_linear_to_ease_out.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/src/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  final bool actionButtons;
  final Clip? bottomNavigationBarClipBehavior;
  final double? bottomAppBarElevation;
  final Color? bottomAppBarColor;
  final NotchedShape? bottomAppBarShape;
  // final bool drawerEnableOpenDragGesture;

  final Color? drawerScrimColor;
  // final bool endDrawerEnableOpenDragGesture;
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
    this.actionButtons = true,
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
    // this.drawerEnableOpenDragGesture = true,
    this.drawerScrimColor,
    // this.endDrawerEnableOpenDragGesture = true,
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
          create: (context) => AppBarBloc(
            appBarRepository: AppBarRepository(
              graphQLClient: context.read<GraphQlAPIClient>(),
            ),
          ),
        ),
      ],
      child: Stack(
        children: [
          Positioned.fill(
            child: Scaffold(
              key: key,
              body: CustomChild(
                body: body,
                drawer: drawer,
                actionButtons: actionButtons,
              ),
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
              // drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
              drawerScrimColor: drawerScrimColor,
              // endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
              onDrawerChanged: onDrawerChanged,
              onEndDrawerChanged: onEndDrawerChanged,
              persistentFooterAlignment: persistentFooterAlignment,
              restorationId: restorationId,
            ),
          ),
          Positioned(
            bottom: 30,
            right: 0,
            left: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoxShadowCustom(
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.black500,
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: RadialGradient(
                              center: Alignment.center,
                              colors: [
                                AppColors.primary600,
                                AppColors.primary100,
                              ],
                              stops: [0.75, 1.0],
                              radius: 0.5,
                            ),
                          ),
                          child: new IconButton(
                            icon: new Icon(
                              Icons.home_filled,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.black100,
                            border: Border.all(color: AppColors.neutral400),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: new IconButton(
                            icon: new Icon(
                              Icons.admin_panel_settings,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.black100,
                            border: Border.all(color: AppColors.neutral400),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: new IconButton(
                            icon: new Icon(
                              Icons.verified_user,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.black100,
                            border: Border.all(color: AppColors.neutral400),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: new IconButton(
                            icon: new Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: 1.seconds).slideY(
                        begin: 3,
                        end: 0,
                        duration: 1000.ms,
                        curve: Curves.bounceInOut,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomChild extends StatefulWidget {
  const CustomChild({
    super.key,
    required this.body,
    required this.drawer,
    required this.actionButtons,
  });
  final Widget body;
  final Widget? drawer;
  final bool actionButtons;

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
    return Indexer(
      children: [
        const Indexed(
          index: 2,
          child: SearchDynamic(),
        ),
        if (widget.actionButtons) actionButtonWidget(),
        primaryContent(),
        drawerWrapper(height, width),
      ],
    );
  }

  BlocBuilder<AppBarBloc, AppBarState> primaryContent() {
    return BlocBuilder<AppBarBloc, AppBarState>(builder: (context, state) {
      return Indexed(
        index: state.status == AppBarStatus.searching ? 1 : 3,
        child: PrimaryContent(
          body: widget.body,
        ),
      );
    });
  }

  BlocBuilder<AppBarBloc, AppBarState> actionButtonWidget() {
    return BlocBuilder<AppBarBloc, AppBarState>(builder: (context, state) {
      return Indexed(
        index: state.status == AppBarStatus.searching ? 1 : 3,
        child: ActionButtons(
          onTapMenu: () {
            appBarBloc.add(
              WipeLeftToRightAppBarEvent(
                wipeDx: 185,
              ),
            );
          },
          onTapAvatar: () {
            if (GoRouterState.of(context).name != RoutePaths.PROFILE) {
              context.push(RoutePaths.PROFILE);
            }
          },
        ),
      );
    });
  }

  Indexed drawerWrapper(double height, double width) {
    return Indexed(
      index: 4,
      child: BlocBuilder<AppBarBloc, AppBarState>(builder: (context, state) {
        return FadeLinearToEaseOut(
          child: EventWrapper(
            child: AnimatedContainer(
              curve: Curves.linear,
              height: height,
              duration: state.drawerWidth > 180 ? 500.ms : 0.ms,
              width: state.drawerWidth > 180 ? width : state.drawerWidth,
              color: AppColors.whitish100.withOpacity(
                state.drawerWidth > 180
                    ? 1
                    : calculateOpacity(
                        state.drawerWidth,
                      ),
              ),
              child: Visibility(
                visible: state.drawerWidth > 180,
                child: widget.drawer ?? const DrawerCustom(),
              ),
            ),
          ),
        );
      }),
    );
  }

  double calculateOpacity(double width) {
    return width / 300;
  }
}
