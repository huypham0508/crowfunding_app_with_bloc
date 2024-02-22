import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/result_item.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:highlight_text/highlight_text.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SearchResultContainer(
        children: [
          _topButtons(),
          GlobalStyles.sizedBoxHeight_10,
          const ResultItem(),
          GlobalStyles.sizedBoxHeight_5,
          const ResultItem(),
          GlobalStyles.sizedBoxHeight_5,
          const ResultItem(),
          GlobalStyles.sizedBoxHeight_5,
          const ResultItem(),
          GlobalStyles.sizedBoxHeight_5,
          const ResultItem(),
          GlobalStyles.sizedBoxHeight_5,
          const ResultItem(),
          GlobalStyles.sizedBoxHeight_24,
          const ReletedSearchs()
        ],
      ),
    );
  }

  Container _topButtons() {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(left: 15, right: 10),
      decoration: BoxDecoration(
        color: AppColors.whitish200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'See all 10,124 fundraisier',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              decoration: TextDecoration.underline,
            ),
          ),
          Container(
            height: 34,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.red500.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: GestureDetector(
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
    return Padding(
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
    );
  }
}

class SearchResultContainer extends StatelessWidget {
  const SearchResultContainer({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Container(
              width: double.maxFinite,
              constraints: BoxConstraints(
                maxHeight: constraints.maxHeight * 0.9,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: AppColors.whitish100,
                borderRadius: BorderRadius.circular(20),
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
      }),
    )
        .animate()
        .fade(
          delay: 300.ms,
          duration: 1000.ms,
          curve: Curves.linearToEaseOut,
        )
        .scaleY(
          delay: 300.ms,
          begin: 0,
          end: 1,
          curve: Curves.ease,
          duration: 300.milliseconds,
        );
  }
}
