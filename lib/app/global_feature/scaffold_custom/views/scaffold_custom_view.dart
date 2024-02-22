import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/bloc/app_bar_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/action_button.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/primary_content.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/search_dynamic.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

class CustomChild extends StatelessWidget {
  const CustomChild({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whitish100,
      child: Indexer(
        children: [
          const Indexed(
            index: 1,
            child: ActionButtons(),
          ),
          const Indexed(
            index: 2,
            child: SearchDynamic(),
          ),
          BlocBuilder<AppBarBloc, AppBarState>(builder: (context, state) {
            return Indexed(
              index: state.status == AppBarStatus.searching ? 1 : 3,
              child: PrimaryContent(body: body),
            );
          })
        ],
      ),
    );
  }
}
