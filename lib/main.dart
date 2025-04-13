import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsarticle/locator.dart';
import 'package:newsarticle/screens/home/app_root.dart';
import 'package:newsarticle/service/api_service/hive_service.dart';
import 'package:newsarticle/service/common_service/network_service.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    setupLocator();
    await HiveService.init();
    locator<ConnectivityService>().init();
    runApp(const MyApp());
  }, (error, stackTrace) async {
    debugPrint("Error in main method is $error");
  });
}
