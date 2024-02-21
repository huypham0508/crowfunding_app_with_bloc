import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/app_bar/app_bar_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_linear_to_ease_out.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarDynamic extends StatelessWidget {
  const AppBarDynamic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appBarBloc = context.read<AppBarBloc>();
    return BlocConsumer<AppBarBloc, AppBarState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Positioned.fill(
          child: GestureDetector(
            onTap: () {
              appBarBloc.add(
                ChangeStatusAppBarEvent(
                  status: AppBarStatus.initial,
                ),
              );
            },
            child: AnimatedContainer(
              duration: 500.milliseconds,
              color: state.status == AppBarStatus.searching
                  ? AppColors.black400.withOpacity(0.5)
                  : AppColors.transparent,
              child: Column(
                children: [
                  GlobalStyles.sizedBoxHeight_5,
                  SafeArea(
                    bottom: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const FadeLinearToEaseOut(
                            child: Icon(Icons.menu, color: AppColors.black500)),
                        FittedBox(
                          child: SearchInput(
                            controller: state.searchController,
                            onSearch: () {
                              print(state.searchController.text);
                            },
                            onFocusChange: (value) {
                              if (value) {
                                appBarBloc.add(
                                  ChangeStatusAppBarEvent(
                                    status: AppBarStatus.searching,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const FadeLinearToEaseOut(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1707345512638-997d31a10eaa?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // if (state.status == AppBarStatus.searching)
                  //   Expanded(
                  //     child: LayoutBuilder(builder: (context, constraints) {
                  //       double height = MediaQuery.of(context).size.height;
                  //       double keyboardHeight = height - constraints.maxHeight;
                  //       return Container(
                  //         height: keyboardHeight - 40,
                  //         margin: const EdgeInsets.symmetric(
                  //           horizontal: 24,
                  //           vertical: 12,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           color: AppColors.whitish100,
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                  //       );
                  //     }),
                  //   )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
