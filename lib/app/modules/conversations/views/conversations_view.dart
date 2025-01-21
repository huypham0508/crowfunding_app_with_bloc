part of '../index.dart';

class ConversationsView extends StatefulWidget {
  const ConversationsView({super.key});

  @override
  State<ConversationsView> createState() => _ConversationsViewState();
}

class _ConversationsViewState extends State<ConversationsView> {
  late ServerEventsManager serverEventsManager;
  late ConversationsBloc roomsBloc;

  @override
  void initState() {
    roomsBloc = ConversationsBloc(
      conversationRepository: ConversationRepository(
        graphQLClient: context.read<GraphQlAPIClient>(),
      ),
    );
    serverEventsManager = context.read<ServerEventsManager>();
    serverEventsManager.typingEvents.listen(
      (event) async {
        roomsBloc.add(StartedTypingEvent(userTyping: event));
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      // actionButtons: false,
      body: BlocProvider(
        create: (context) {
          return roomsBloc..add(InitialConversationsEvent());
        },
        child: BlocListener<ConversationsBloc, ConversationsState>(
          listenWhen: (previous, current) {
            return previous.loading != current.loading;
          },
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
                    'Your Conversations',
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
                  child: BlocBuilder<ConversationsBloc, ConversationsState>(
                    builder: (context, state) {
                      return Column(
                        children: state.conversations.map(
                          (conversation) {
                            return ChatRoom(
                              isTyping: conversation.isTyping,
                              conversation: conversation,
                            );
                          },
                        ).toList(),
                      );
                    },
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

// GlobalStyles.sizedBoxHeight_24,
// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 24),
//   child: Align(
//     alignment: Alignment.centerLeft,
//     child: Text(
//       'Suggested for you',
//       style: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//         color: AppColors.black500,
//       ),
//     ),
//   ),
// ),
// GlobalStyles.sizedBoxHeight_24,
// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 24),
//   child: SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//       children: [
//         Container(
//           width: 200,
//           height: 150,
//           margin: EdgeInsets.only(right: 20),
//           decoration: BoxDecoration(
//             color: AppColors.secondary500,
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         Container(
//           width: 200,
//           height: 150,
//           margin: EdgeInsets.only(right: 20),
//           decoration: BoxDecoration(
//             color: AppColors.primary600,
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         Container(
//           width: 200,
//           height: 150,
//           margin: EdgeInsets.only(right: 20),
//           decoration: BoxDecoration(
//             color: AppColors.secondary500,
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         Container(
//           width: 200,
//           height: 150,
//           margin: EdgeInsets.only(right: 20),
//           decoration: BoxDecoration(
//             color: AppColors.primary600,
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// GlobalStyles.sizedBoxHeight_24,
class ChatRoom extends StatelessWidget {
  const ChatRoom({
    super.key,
    required this.isTyping,
    required this.conversation,
  });
  final bool isTyping;
  final Conversation conversation;

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
                    conversation.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 25,
                    child: Column(
                      children: [
                        if (isTyping)
                          FittedBox(
                            child: LoadingAnimationWidget.waveDots(
                              color: AppColors.black300,
                              size: 25,
                            ),
                          ),
                        if (!isTyping)
                          FittedBox(
                            child: Text(
                              conversation.maxMessage.content,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.neutral300,
                              ),
                            ),
                          ),
                      ],
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
