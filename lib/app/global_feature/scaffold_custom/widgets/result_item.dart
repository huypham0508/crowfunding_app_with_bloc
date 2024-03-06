import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeMoveLeftToRight(
      child: Container(
        height: 60,
        padding: const EdgeInsets.only(left: 15, right: 10),
        child: Center(
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    AppImages.fakeImageNetwork,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              GlobalStyles.sizedBoxWidth,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHighlight(
                      text: 'Education fund for Durgham Family',
                      words: {
                        'Education': HighlightedWord(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.textPrimary,
                          ),
                        )
                      },
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary200,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SelectableText(
                      'By Durgham Family',
                      maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary200,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
