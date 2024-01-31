import 'package:crowfunding_app_with_bloc/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await FirebaseApi().initNotification();

  /// Use preferences like expected.
  await SharedPreferences.getInstance();
  // final sf = await SharedPreferences.getInstance();
  runApp(const MainApp(
      // sharedPreferences: sf,
      ));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });
  // final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.returnRouter(navigatorKey),
    );
  }
}
