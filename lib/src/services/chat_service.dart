import 'package:crowfunding_app_with_bloc/src/data/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  static final ChatService instance = ChatService._internal();
  late IO.Socket socket;
  late SharedPreferences _sharedPreferences;

  factory ChatService({required SharedPreferences sharedPreferences}) {
    instance._sharedPreferences = sharedPreferences;
    return instance;
  }

  ChatService._internal() {
    // _initSocket();
  }

  // void _initSocket() async {
  //   socket = IO.io(
  //     ConfigApi.BASEURL,
  //     IO.OptionBuilder().setTransports(['websocket']).build(),
  //   );
  //   await socket.connect();
  //   socket.onConnect((data) async {
  //     LocalDataSource localDataSource = LocalDataSource(_sharedPreferences);
  //     final getUserId = await localDataSource.getUserId();
  //     if (getUserId != null) {
  //       socket.emit("login", getUserId);
  //       print("${getUserId} connected");
  //     }
  //   });
  //   socket.onConnectError((data) => print('Connect Error: $data'));
  //   socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  //   socket.on('notification', (data) {
  //     String payload = jsonEncode(data);
  //     NotificationsService.showSimpleNotification(
  //       body: data!['message'] ?? "Tin nhắn không xác định",
  //       payload: payload,
  //       title: "Bạn có tin nhắn mới",
  //     );
  //   });
  // }

  void listenRoom(Function(dynamic) onRun) {
    socket.on('roomUpdate', (data) {
      return onRun(data);
    });
  }

  void disconnect() async {
    LocalDataSource localDataSource = LocalDataSource(_sharedPreferences);
    final getUserId = await localDataSource.getUserId();
    if (getUserId != null) {
      socket.emit("logout", getUserId);
    }
    socket.disconnect();
  }
}
