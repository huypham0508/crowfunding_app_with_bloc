import 'package:crowfunding_app_with_bloc/app/constants/firebase_database.dart';
import 'package:crowfunding_app_with_bloc/app/constants/graph_ql_string.dart';
import 'package:crowfunding_app_with_bloc/app/data/firebase/firebase_api.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/rest.dart';
import 'package:crowfunding_app_with_bloc/app/data/repository/api_service_repository.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/bloc/lo_to_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/lo_to/firebase/firebase_data.dart';
import 'package:crowfunding_app_with_bloc/app/routes/app_pages.dart';
import 'package:crowfunding_app_with_bloc/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();

  /// Use preferences like expected.
  await SharedPreferences.getInstance();
  final sf = await SharedPreferences.getInstance();
  runApp(MainApp(
    sharedPreferences: sf,
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  final GraphQLService graphQLService = GraphQLService(GraphQLClient(
    link: ConfigGraphQl.httpLink,
    cache: GraphQLCache(),
  ));

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        //Create a LocalDataSource
        RepositoryProvider(
          create: (context) => LocalDataSource(sharedPreferences),
        ),
        //Create a RestAPIClientService
        RepositoryProvider(
          create: (context) => ApiServiceRepository(
            RestAPIClient(
              httpClient: Dio(),
            ),
          ),
        ),
        //Create a auth graphQLService
        RepositoryProvider(
          create: (context) => AuthRepository(
            graphQLClient: graphQLService,
            localDataSource: LocalDataSource(sharedPreferences),
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
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => LoToBloc(
              localDataSource: context.read<LocalDataSource>(),
              firebaseDatabase: context.read<LotoFirebaseDatabase>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.returnRouter(navigatorKey),
        ),
      ),
    );
  }
}
