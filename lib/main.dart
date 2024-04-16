import 'dart:ui';

import 'package:crowfunding_app_with_bloc/app/constants/firebase_database.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/bloc/lo_to_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/firebase/firebase_data.dart';
import 'package:crowfunding_app_with_bloc/app/routes/app_pages.dart';
import 'package:crowfunding_app_with_bloc/app/services/notifications_service.dart';
import 'package:crowfunding_app_with_bloc/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void connectToSocketInIsolate(_) async {
  IO.Socket socket = IO.io(
    'http://localhost:4000/',
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );
  socket.onConnect((data) => print('Connection established'));
  socket.onConnectError((data) => print('Connect Error: $data'));
  socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  socket.on('connected', (data) async {
    IsolateNameServer.lookupPortByName('mainIsolateMessage')?.send(
      'Socket connection established', // Include message data
    );
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationsService.init();

  /// Use preferences like expected.
  final sf = await SharedPreferences.getInstance();

  // final receivePort = ReceivePort();
  // IsolateNameServer.registerPortWithName(
  //   receivePort.sendPort,
  //   'mainIsolateMessage',
  // );
  // receivePort.listen((message) {
  //   NotificationsService.showSimpleNotification(
  //     body: "123123",
  //     payload: "123123",
  //     title: "123123123",
  //   );
  // });

  // Isolate.spawn(connectToSocketInIsolate, null);

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: MainApp(sharedPreferences: sf),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late GoRouter _appRoutes;

  @override
  void initState() {
    _appRoutes = AppRouter.returnRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    LocalDataSource localDataSource = LocalDataSource(widget.sharedPreferences);
    return MultiRepositoryProvider(
      providers: [
        //Create a LocalDataSource
        RepositoryProvider(
          create: (context) => localDataSource,
        ),
        //Create a graphQLService
        RepositoryProvider(
          create: (context) => GraphQLService(localDataSource: localDataSource),
        ),
        //Create a firebaseDatabase
        RepositoryProvider(
          create: (context) => LotoFirebaseDatabase(
            refData: FirebaseDatabase.instance.ref(
              FirebaseDatabaseString.count,
            ),
            refUsers: FirebaseDatabase.instance.ref(
              FirebaseDatabaseString.users,
            ),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              localDataSource: context.read<LocalDataSource>(),
            )..add(InitialAuthEvent()),
          ),
          BlocProvider(
            create: (context) => LoToBloc(
              localDataSource: context.read<LocalDataSource>(),
              firebaseDatabase: context.read<LotoFirebaseDatabase>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FlutterI18nDelegate(
              translationLoader: FileTranslationLoader(
                basePath: "assets/translations",
                forcedLocale: const Locale("en"),
              ),
            ),
          ],
          title: 'Crown Funding App',
          theme: ThemeData(
            textTheme: GoogleFonts.epilogueTextTheme(textTheme).copyWith(
              bodyMedium: GoogleFonts.rubik(textStyle: textTheme.bodyMedium),
            ),
          ),
          debugShowCheckedModeBanner: false,
          routeInformationParser: _appRoutes.routeInformationParser,
          routeInformationProvider: _appRoutes.routeInformationProvider,
          routerDelegate: _appRoutes.routerDelegate,
        ),
      ),
    );
  }
}
