import 'dart:async';
import 'dart:ui';

import 'package:crowfunding_app_with_bloc/app/services/notifications_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
    ),
  );

  await service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  // if (service is AndroidServiceInstance) {
  //   service.on('setAsForeground').listen((event) {
  //     service.setAsForegroundService();
  //   });
  //   service.on('setAsBackground').listen((event) {
  //     service.setAsBackgroundService();
  //   });
  //   service.on('stopService').listen((event) {
  //     service.stopSelf();
  //   });
  // }

  Timer.periodic(1.seconds, (timer) async {
    // if (service is AndroidServiceInstance) {
    //   if (await service.isForegroundService()) {
    //     service.setForegroundNotificationInfo(
    //       title: "Script Academy",
    //       content: "sub my channel",
    //     );
    //   }
    // }
    NotificationsService.showSimpleNotification(
      body: "123123",
      payload: "123123",
      title: "123123123",
    );
    //perform some operation on background which in not noticeable to the used every time
    print('background service running');
    service.invoke('update');
  });
}
