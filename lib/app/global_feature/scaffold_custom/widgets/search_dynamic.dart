import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/bloc/app_bar_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/search_result.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/global_widget/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDynamic extends StatelessWidget {
  const SearchDynamic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBarBloc = context.read<AppBarBloc>();
    void onCloseSearch() {
      appBarBloc.add(
        ChangeStatusAppBarEvent(
          status: AppBarStatus.initial,
        ),
      );
    }

    return BlocBuilder<AppBarBloc, AppBarState>(
      builder: (context, state) {
        return Stack(
          children: [
            if (!state.hiddenSearchResults)
              GestureDetector(
                onTap: onCloseSearch,
                child: _filter(
                  showFilter: state.status == AppBarStatus.searching,
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
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
                          loading: state.searchDynamicStatus ==
                              SearchDynamicStatus.loading,
                        ),
                      ),
                      _fakeAvatarSize(),
                    ],
                  ),
                ),
                if (state.searchResults.isNotEmpty &&
                    state.status == AppBarStatus.searching)
                  SearchResult(
                    onClose: onCloseSearch,
                  )
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _filter({bool? showFilter}) {
    return AnimatedContainer(
      duration: 500.milliseconds,
      curve: Curves.ease,
      color: showFilter == true
          ? AppColors.black400.withOpacity(0.8)
          : AppColors.transparent,
    ).animate().fade(
          begin: 0,
          end: 0.6,
          duration: 500.milliseconds,
          curve: Curves.ease,
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
      maintainSemantics: true,
      child: Container(
        margin: GlobalStyles.paddingPageLeftRight_24,
        child: const Icon(
          Icons.menu,
          color: AppColors.red500,
          size: 28,
        ),
      ),
    );
  }
}
