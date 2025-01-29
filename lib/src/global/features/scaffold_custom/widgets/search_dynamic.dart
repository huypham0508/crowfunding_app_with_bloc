import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/global/blocs/scaffold_custom/app_bar_bloc.dart';
import 'package:crowfunding_app_with_bloc/src/global/features/scaffold_custom/widgets/search_result.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/src/global/widget/search_input.dart';
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
                          onFocusChange: () {
                            appBarBloc.add(
                              ChangeStatusAppBarEvent(
                                status: AppBarStatus.searching,
                              ),
                            );
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
                    results: state.searchResults,
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
      child: GestureDetector(
        child: Container(
          margin: GlobalStyles.paddingPageLeftRight_24,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.whitish100,
          ),
          child: const Icon(
            Icons.person,
            color: AppColors.black500,
            size: 28,
          ),
        ),
      ),
    );
  }
}
