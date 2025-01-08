import 'package:crowfunding_app_with_bloc/app/constants/constants.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/data/repository/graphql/post_repository.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/views/scaffold_custom_view.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/modules/rooms/bloc/rooms_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/services/chat_service.dart';
import 'package:crowfunding_app_with_bloc/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RoomsView extends StatefulWidget {
  const RoomsView({super.key});

  @override
  State<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  @override
  void initState() {
    ChatService.instance.listenRoom(
      (payload) {
        print("initState ${payload["_id"]}");
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      actionButtons: false,
      body: BlocProvider(
        create: (context) {
          return RoomsBloc(
            postRepository: PostRepository(
              graphQLClient: context.read<GraphQlAPIClient>(),
            ),
          )..add(InitialRoomsEvent());
        },
        child: BlocListener<RoomsBloc, RoomsState>(
          listener: (context, state) {
            switch (state.loading) {
              case true:
                Utils.showLoading(context);
                break;
              default:
                context.pop();
                break;
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GlobalStyles.sizedBoxHeight_24,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Suggested for you',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black500,
                    ),
                  ),
                ),
              ),
              GlobalStyles.sizedBoxHeight_24,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        height: 150,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: AppColors.secondary500,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 150,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: AppColors.primary600,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 150,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: AppColors.secondary500,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 150,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: AppColors.primary600,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GlobalStyles.sizedBoxHeight_24,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Rooms',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                      ChatRoom(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    super.key,
  });

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () async {},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1653914900849-beb53df7f5ea?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jayden lavoie',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Hey u, what r u doing? ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutral300,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '7:19 PM',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutral300,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondary500,
                  ),
                  // child: Center(
                  //   child: Text(
                  //     '9+',
                  //     style: TextStyle(
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.whitish100,
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
