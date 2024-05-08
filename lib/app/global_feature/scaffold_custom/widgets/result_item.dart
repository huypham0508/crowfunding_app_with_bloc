import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/search_friend_response.dart';
import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  final FriendResult friendResult;

  const ResultItem({super.key, required this.friendResult});

  @override
  Widget build(BuildContext context) {
    print("${ConfigGraphQl.baseUrl}${friendResult.avatar}");
    return FadeMoveLeftToRight(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            BoxShadowCustom(
              child: SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "${ConfigGraphQl.baseUrl}${friendResult.avatar}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            GlobalStyles.sizedBoxWidth,
            Expanded(
              child: Text(
                friendResult.email ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.black100,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.primary600,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person_add,
                        size: 15,
                        color: AppColors.whitish100,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      // child: Container(
      //   height: 60,
      //   padding: const EdgeInsets.only(left: 15, right: 10),
      //   child: Center(
      //     child: Row(
      //       children: [
      //         SizedBox(
      //           height: 50,
      //           width: 50,
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.circular(10),
      //             child: Image.network(
      //               AppImages.fakeImageNetwork,
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ),
      //         GlobalStyles.sizedBoxWidth,
      //         Expanded(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               TextHighlight(
      //                 text: 'Education fund for Durgham Family',
      //                 words: {
      //                   'Education': HighlightedWord(
      //                     textStyle: const TextStyle(
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 12,
      //                       color: AppColors.black100,
      //                     ),
      //                   )
      //                 },
      //                 textStyle: const TextStyle(
      //                   fontSize: 12,
      //                   color: AppColors.black100,
      //                 ),
      //                 maxLines: 1,
      //                 overflow: TextOverflow.ellipsis,
      //               ),
      //               const SelectableText(
      //                 'By Durgham Family',
      //                 maxLines: 1,
      //                 // overflow: TextOverflow.ellipsis,
      //                 style: TextStyle(
      //                   fontSize: 12,
      //                   color: AppColors.neutral300,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
