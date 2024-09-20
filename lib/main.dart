import 'package:camera/camera.dart';
import 'package:crowfunding_app_with_bloc/app/constants/firebase_database.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/rest/rest.dart';
import 'package:crowfunding_app_with_bloc/app/data/repository/graphql/post_repository.dart';
import 'package:crowfunding_app_with_bloc/app/data/repository/rest/api_service_repository.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/camera/camera_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/bloc/lo_to_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/firebase/firebase_data.dart';
import 'package:crowfunding_app_with_bloc/app/routes/app_pages.dart';
import 'package:crowfunding_app_with_bloc/app/services/notifications_service.dart';
import 'package:crowfunding_app_with_bloc/app/services/chat_service.dart';
import 'package:crowfunding_app_with_bloc/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationsService.init();

  List<CameraDescription> _cameras = await availableCameras();

  /// Use preferences like expected.
  final sf = await SharedPreferences.getInstance();
  await ChatService(sharedPreferences: sf);

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: MainApp(
      sharedPreferences: sf,
      cameras: _cameras,
    ),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
    required this.sharedPreferences,
    required this.cameras,
  });
  final SharedPreferences sharedPreferences;
  final List<CameraDescription> cameras;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late GoRouter _appRoutes;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _appRoutes = AppRouter.returnRouter();
  }

  @override
  void dispose() {
    ChatService.instance.disconnect();
    super.dispose();
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
        //Create a GraphQlAPIClient
        RepositoryProvider(
          create: (context) => GraphQlAPIClient.getInstance(
            localDataSource: localDataSource,
          ),
        ),
        //Create a ApiServiceRepository
        RepositoryProvider(
          create: (context) => ApiServiceRepository(
            RestAPIClient(httpClient: Dio()),
          ),
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
              authRepository: AuthRepository(
                graphQLClient: context.read<GraphQlAPIClient>(),
                localDataSource: context.read<LocalDataSource>(),
              ),
            )..add(InitialAuthEvent()),
          ),
          BlocProvider(
            create: (context) => LoToBloc(
              localDataSource: context.read<LocalDataSource>(),
              firebaseDatabase: context.read<LotoFirebaseDatabase>(),
            ),
          ),
          BlocProvider(
            create: (context) => CameraBloc(
              cameras: widget.cameras,
              apiServiceRepository: context.read<ApiServiceRepository>(),
              postRepository: PostRepository(
                graphQLClient: context.read<GraphQlAPIClient>(),
              ),
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
