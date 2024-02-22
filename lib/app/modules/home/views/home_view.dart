import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/views/scaffold_custom_view.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double ratio = 6.767;
    return ScaffoldCustom(
      body: Padding(
        padding: GlobalStyles.paddingPageLeftRight_24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GlobalStyles.sizedBoxHeight_10,
            GlobalStyles.sizedBoxHeight_10,
            Container(
              height: height / ratio,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                    AppImages.fakeImageNetwork,
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  'Education',
                  style: TextStyle(
                    color: AppColors.whitish100,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
