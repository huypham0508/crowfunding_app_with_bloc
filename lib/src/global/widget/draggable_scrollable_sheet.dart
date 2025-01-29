import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DraggableScrollableSheetCustom extends StatelessWidget {
  const DraggableScrollableSheetCustom({
    super.key,
    required this.builder,
    required this.title,
  });
  final Widget Function(ScrollController controller) builder;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.9,
      builder: (
        BuildContext context,
        ScrollController scrollController,
      ) {
        Widget child = builder(scrollController);
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xFFF1F1F1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 35),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: child,
                ),
              ),
              SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                controller: scrollController,
                child: _line(),
              ),
            ],
          ),
        );
      },
    );
  }

  IgnorePointer _line() {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF1F1F1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 5),
              Container(
                height: 4,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.neutral100,
                ),
              ),
              title,
            ],
          ),
        ),
      ),
    );
  }
}
