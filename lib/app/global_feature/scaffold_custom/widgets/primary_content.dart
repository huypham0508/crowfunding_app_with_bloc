import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/event_wapper.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/search_input.dart';
import 'package:flutter/material.dart';

class PrimaryContent extends StatelessWidget {
  const PrimaryContent({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalStyles.sizedBoxHeight_5,
        SafeArea(
          bottom: false,
          child: Row(
            children: [
              _fakeInputDynamic(),
            ],
          ),
        ),
        Expanded(
          child: EventWrapper(child: body),
        )
      ],
    );
  }

  Expanded _fakeInputDynamic() {
    return const Expanded(
      child: Visibility(
        visible: false,
        maintainAnimation: true,
        maintainSize: true,
        maintainState: true,
        child: SearchInput(),
      ),
    );
  }
}
