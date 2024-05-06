import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/bloc/app_bar_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_scale.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/box_shadow_custom.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/modules/friend/bloc/friend_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/home/modules/friend/models/friend_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FriendView extends StatelessWidget {
  const FriendView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) {
        return FriendBloc(
          friendRepository: FriendRepository(
            graphQLClient: context.read<GraphQlAPIClient>(),
          ),
        )..add(InitialFriendEvent());
      },
      child: FadeScale(
        child: BlocBuilder<FriendBloc, FriendState>(builder: (context, state) {
          final friendBloc = context.read<FriendBloc>();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _wrapper(
                height: height,
                width: width,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _title(),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.notification_add_outlined,
                      //     color: AppColors.red500,
                      //   ),
                      // )
                    ],
                  ),
                  GlobalStyles.sizedBoxHeight_30,

                  if (state.status == FriendStatus.loaded)
                    ...state.friendsRequest
                        .map((item) => RequestAddFrWidget(
                              model: item,
                              onTapAccept: () {
                                friendBloc.add(AcceptRequestEvent(
                                  requestId: item.id ?? "",
                                ));
                              },
                              onTapClose: () {
                                friendBloc.add(RejectRequestEvent(
                                  requestId: item.id ?? "",
                                ));
                              },
                            ))
                        .toList(),

                  // render list
                  if (state.status == FriendStatus.loaded)
                    ...state.friends
                        .map((item) => FriendWidget(model: item))
                        .toList(),

                  // show loading
                  if (state.status == FriendStatus.loading)
                    Center(
                      child: LoadingAnimationWidget.bouncingBall(
                        color: AppColors.primary600,
                        size: 30,
                      ),
                    ),

                  // empty list
                  if (state.status == FriendStatus.loaded &&
                      state.friends.isEmpty)
                    Center(child: Text('List is empty!')),
                ],
              ),
              CloseButton()
            ],
          );
        }),
      ),
    );
  }

  Text _title() {
    return Text(
      'List Friends',
      style: TextStyle(
        color: AppColors.black100,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  BoxShadowCustom _wrapper({
    required double height,
    required double width,
    required List<Widget> children,
  }) {
    return BoxShadowCustom(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 200.0,
          maxHeight: height * 0.7,
        ),
        child: Container(
          width: width * 0.8,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.whitish100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AppBarBloc>().add(
              WipeLeftToRightAppBarEvent(wipeDx: -180),
            );
      },
      icon: Icon(Icons.close_rounded),
    );
  }
}

class FriendWidget extends StatelessWidget {
  final FriendModel model;

  const FriendWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          BoxShadowCustom(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.network(
                  '${ConfigGraphQl.baseUrl}${model.avatar}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GlobalStyles.sizedBoxWidth,
          Expanded(
            child: Text(
              model.email ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.black100,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RequestAddFrWidget extends StatefulWidget {
  final FriendModel model;
  final void Function()? onTapAccept;
  final void Function()? onTapClose;

  const RequestAddFrWidget({
    super.key,
    required this.model,
    this.onTapAccept,
    this.onTapClose,
  });

  @override
  State<RequestAddFrWidget> createState() => _RequestAddFrWidgetState();
}

class _RequestAddFrWidgetState extends State<RequestAddFrWidget> {
  double tapAccept = 0;
  double tapClose = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          BoxShadowCustom(
            child: SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  '${ConfigGraphQl.baseUrl}${widget.model.avatar}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GlobalStyles.sizedBoxWidth,
          Expanded(
            child: Text(
              widget.model.email ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.black100,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          AnimatedContainer(
            duration: 300.ms,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (tapAccept == 0 && tapClose == 0) ..._options(),
                if (tapAccept == 1) ...buttonAccept(),
                if (tapClose == 1) ..._buttonReject(),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _options() {
    return [
      FadeMoveRightToLeft(
        child: GestureDetector(
          onTap: () {
            setState(() {
              tapAccept = 1;
            });
          },
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: AppColors.primary600.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.person_add,
                color: AppColors.primary600,
                size: 15,
              ),
            ),
          ),
        ),
      ),
      FadeMoveRightToLeft(
        child: GestureDetector(
          onTap: () {
            setState(() {
              tapClose = 1;
            });
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.red500.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.close,
                color: AppColors.red500,
                size: 15,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> buttonAccept() {
    return [
      FadeMoveRightToLeft(
        child: GestureDetector(
          onTap: widget.onTapAccept,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary600,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                'Accept',
                style: TextStyle(
                  color: AppColors.whitish100,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      ),
      FadeMoveRightToLeft(
        child: GestureDetector(
          onTap: () {
            setState(() {
              tapAccept = 0;
            });
          },
          child: Icon(
            Icons.close,
            color: AppColors.red500,
            size: 15,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buttonReject() {
    return [
      FadeMoveRightToLeft(
        child: GestureDetector(
          onTap: widget.onTapClose,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.red500,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                'Reject',
                style: TextStyle(
                  color: AppColors.whitish100,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      ),
      FadeMoveRightToLeft(
        child: GestureDetector(
          onTap: () {
            setState(() {
              tapClose = 0;
            });
          },
          child: Icon(
            Icons.close,
            color: AppColors.primary600,
            size: 15,
          ),
        ),
      )
    ];
  }
}

// class RequestAddFrWidget extends StatelessWidget {
//   final FriendModel model;

//   const RequestAddFrWidget({super.key, required this.model});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       padding: EdgeInsets.symmetric(horizontal: 30),
//       child: Row(
//         children: [
//           BoxShadowCustom(
//             child: SizedBox(
//               width: 40,
//               height: 40,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(50),
//                 child: Image.network(
//                   '${ConfigGraphQl.baseUrl}${model.avatar}',
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//           ),
//           GlobalStyles.sizedBoxWidth,
//           Expanded(
//             child: Text(
//               model.email ?? '',
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 color: AppColors.black100,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: AppColors.primary600,
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: Center(
//                     child: Icon(
//                       Icons.person_add,
//                       size: 15,
//                       color: AppColors.whitish100,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
