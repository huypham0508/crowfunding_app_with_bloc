part of '../index.dart';

class DirectMessageView extends StatelessWidget {
  const DirectMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DirectMessageBloc(
        directMessageRepository: DirectMessageRepository(
          context.read<RestAPIClient>(),
        ),
      )..add(InitDirectMessageEvent()),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 54,
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(CupertinoIcons.back),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          title: const Text("Huy Pam"),
        ),
        body: Center(
          child: Text("Direct Message page"),
        ),
      ),
    );
  }
}
