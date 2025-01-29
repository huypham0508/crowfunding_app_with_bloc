import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/global/blocs/scaffold_custom/app_bar_bloc.dart';
import 'package:crowfunding_app_with_bloc/src/global/features/scaffold_custom/widgets/result_item.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/src/models/search_friend.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlight_text/highlight_text.dart';

class SearchResult extends StatelessWidget {
  final List<FriendResult> results;

  const SearchResult({
    super.key,
    this.onClose,
    required this.results,
  });
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    handleOnTapIcon(friendResult) {
      context.read<AppBarBloc>().add(
            OnTapFriendAppBarEvent(friendResult: friendResult),
          );
    }

    return Expanded(
      child: SearchResultContainer(
        topWidget: _topButtons(),
        children: [
          ...results
              .map(
                (e) => ResultItem(
                  friendResult: e,
                  onTapIcon: () => handleOnTapIcon(e),
                ),
              )
              .toList(),
          if (results.isEmpty) Center(child: Text('NOT FOUND')),
        ],
      ),
    );
  }

  Container _topButtons() {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(left: 15, right: 10),
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.whitish200,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // const Text(
          //   'See all 10,124 fundraisier',
          //   style: TextStyle(
          //     fontWeight: FontWeight.w500,
          //     fontSize: 12,
          //     decoration: TextDecoration.underline,
          //   ),
          // ),
          Container(
            height: 34,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.red500.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: GestureDetector(
              onTap: onClose,
              child: const Image(image: AssetImage(AppImages.icClose)),
            ),
          )
        ],
      ),
    );
  }
}

class ReletedSearchs extends StatelessWidget {
  const ReletedSearchs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeMoveTopToBottom(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 10, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Releted searchs',
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            GlobalStyles.sizedBoxHeight_10,
            GlobalStyles.sizedBoxHeight_5,
            TextHighlight(
              text: 'education fund',
              words: {
                'education': HighlightedWord(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.black100,
                  ),
                )
              },
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textStyle: const TextStyle(
                fontSize: 12,
                color: AppColors.neutral400,
              ),
            ),
            GlobalStyles.sizedBoxHeight_10,
            TextHighlight(
              text: 'education fund',
              words: {
                'education': HighlightedWord(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.black100,
                  ),
                )
              },
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textStyle: const TextStyle(
                fontSize: 12,
                color: AppColors.neutral400,
              ),
            ),
            GlobalStyles.sizedBoxHeight_10,
            TextHighlight(
              text: 'education fund',
              words: {
                'education': HighlightedWord(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.black100,
                  ),
                )
              },
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textStyle: const TextStyle(
                fontSize: 12,
                color: AppColors.neutral400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultContainer extends StatelessWidget {
  const SearchResultContainer({
    super.key,
    required this.children,
    required this.topWidget,
  });
  final Widget topWidget;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              GlobalStyles.sizedBoxHeight_10,
              topWidget,
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: double.maxFinite,
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight * 0.75,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.whitish100,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              ),
            ],
          );
        },
      ).animate().fade(
            delay: 310.ms,
            duration: 300.ms,
            curve: Curves.linearToEaseOut,
          ),
    );
  }
}
