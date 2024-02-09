import 'package:crowfunding_app_with_bloc/app/constants/firebase_database.dart';
import 'package:crowfunding_app_with_bloc/app/data/firebase/firebase_api.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/bloc/lo_to_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/firebase/firebase_data.dart';
import 'package:crowfunding_app_with_bloc/app/routes/app_pages.dart';
import 'package:crowfunding_app_with_bloc/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();

  /// Use preferences like expected.
  final sf = await SharedPreferences.getInstance();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: MainApp(
      sharedPreferences: sf,
    ),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    LocalDataSource localDataSource = LocalDataSource(sharedPreferences);
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
          title: 'Crow Funding App',
          theme: ThemeData(
            textTheme: GoogleFonts.epilogueTextTheme(textTheme).copyWith(
              bodyMedium: GoogleFonts.rubik(textStyle: textTheme.bodyMedium),
            ),
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.returnRouter(navigatorKey),
        ),
      ),
    );
  }
}
