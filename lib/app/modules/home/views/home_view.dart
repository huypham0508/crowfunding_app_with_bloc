import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_linear_to_ease_out.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/scaffold_custom.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldCustom(
      body: FadeLinearToEaseOut(
        child: Center(
          child: SelectableText(
            'This is home screen',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
