import 'package:flutter/widgets.dart';

class TabBarCustom extends StatefulWidget {
  final List<Widget> tabs;
  final List<Widget> tabsContents;
  final PageController? controller;
  final void Function(int)? onPageChanged;
  const TabBarCustom({
    super.key,
    required this.tabs,
    required this.tabsContents,
    this.onPageChanged,
    this.controller,
  });

  @override
  State<TabBarCustom> createState() => _TabBarCustomState();
}

class _TabBarCustomState extends State<TabBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          _tabsContent(widget.tabsContents),
          _tabs(widget.tabs),
        ],
      ),
    );
  }

  Positioned _tabsContent(children) {
    return Positioned.fill(
      right: 10,
      left: 10,
      bottom: 20,
      child: PageView(
        // physics: ClampingScrollPhysics(),
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: widget.onPageChanged,
        controller: widget.controller,
        allowImplicitScrolling: false,
        children: children,
      ),
    );
  }

  Positioned _tabs(children) {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
