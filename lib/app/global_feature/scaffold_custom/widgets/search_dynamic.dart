import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/bloc/app_bar_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/search_result.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDynamic extends StatelessWidget {
  const SearchDynamic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appBarBloc = context.read<AppBarBloc>();
    return BlocConsumer<AppBarBloc, AppBarState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isLoadingSearch =
            state.searchDynamicStatus == SearchDynamicStatus.loading;
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
                        _fakeButtonMenuSize(),
                        Expanded(
                          child: SearchInput(
                            focusNode: state.focusNode,
                            controller: state.searchController,
                            loading: isLoadingSearch,
                            onSearch: () => appBarBloc.add(
                              SubmitSearchAppBarEvent(),
                            ),
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
                        _fakeAvatarSize(),
                      ],
                    ),
                  ),
                  if (state.searchResults.isNotEmpty &&
                      state.status == AppBarStatus.searching)
                    const SearchResult()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Visibility _fakeAvatarSize() {
    return Visibility(
      visible: false,
      maintainAnimation: true,
      maintainSize: true,
      maintainState: true,
      child: Container(
        margin: GlobalStyles.paddingPageLeftRight_24,
        child: const CircleAvatar(),
      ),
    );
  }

  Visibility _fakeButtonMenuSize() {
    return Visibility(
      visible: false,
      maintainAnimation: true,
      maintainSize: true,
      maintainState: true,
      child: Container(
        margin: GlobalStyles.paddingPageLeftRight_24,
        child: const Icon(
          Icons.menu,
          color: AppColors.black500,
          size: 28,
        ),
      ),
    );
  }
}
