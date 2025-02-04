import 'package:crowfunding_app_with_bloc/src/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/src/models/search_friend.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultItem extends StatefulWidget {
  final FriendResult friendResult;
  final void Function()? onTapIcon;

  const ResultItem({super.key, required this.friendResult, this.onTapIcon});

  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  @override
  Widget build(BuildContext context) {
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
                    "${ConfigGraphQl.baseUrl}${widget.friendResult.avatar}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(AppImages.imAvatar);
                    },
                  ),
                ),
              ),
            ),
            GlobalStyles.sizedBoxWidth,
            Expanded(
              child: Text(
                widget.friendResult.email ?? '',
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
                  onTap: () async {
                    if (widget.onTapIcon != null) {
                      widget.onTapIcon!();
                      await Future.delayed(300.ms);
                      setState(() {
                        widget.friendResult.status = 'pending';
                      });
                    }
                  },
                  child: Column(
                    children: [
                      if (widget.friendResult.status == 'nothing') _iconAdd(),
                      if (widget.friendResult.status == 'accepted')
                        _iconAccepted(),
                      if (widget.friendResult.status == 'pending')
                        _iconPending(),
                    ],
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

  Container _iconAdd() {
    return Container(
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
    );
  }

  Container _iconAccepted() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.whitish100,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 1, color: AppColors.primary600),
      ),
      child: Center(
        child: Icon(
          Icons.people,
          size: 15,
          color: AppColors.primary600,
        ),
      ),
    );
  }

  Container _iconPending() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.primary600,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Icon(
          Icons.pending_outlined,
          size: 15,
          color: AppColors.whitish100,
        ),
      ),
    );
  }
}
