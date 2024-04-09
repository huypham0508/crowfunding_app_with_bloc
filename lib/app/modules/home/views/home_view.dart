import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/views/scaffold_custom_view.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/result_item.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/widgets/search_result.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_move.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late IO.Socket socket;
  int count = 0;

  @override
  void initState() {
    // socket = IO.io(
    //   'http://localhost:4000/',
    //   IO.OptionBuilder().setTransports(['websocket']).build(),
    // );
    // socket.connect();
    // _connectSocket();
    super.initState();
  }

  // _connectSocket() {
  //   socket.onConnect((data) => print('Connection established'));
  //   socket.onConnectError((data) => print('Connect Error: $data'));
  //   socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  //   socket.on('connected', (data) {
  //     setState(() {
  //       count += 1;
  //     });
  //     NotificationsService.showSimpleNotification(
  //       body: "123123",
  //       payload: "123123",
  //       title: "123123123",
  //     );
  //   });
  // socket.emit("login", "username");
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double ratio = 6.767;
    return ScaffoldCustom(
      body: Padding(
        padding: GlobalStyles.paddingPageLeftRight_24,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GlobalStyles.sizedBoxHeight_10,
              GlobalStyles.sizedBoxHeight_10,
              FadeMoveTopToBottom(
                child: Container(
                  height: height / ratio,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(
                        AppImages.fakeImageNetwork,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Education $count',
                      style: const TextStyle(
                        color: AppColors.whitish100,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
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
              const ReletedSearchs(),
              GlobalStyles.sizedBoxHeight_24,
              const ReletedSearchs(),
              GlobalStyles.sizedBoxHeight_24,
              const ReletedSearchs()
            ],
          ),
        ),
      ),
    );
  }
}
