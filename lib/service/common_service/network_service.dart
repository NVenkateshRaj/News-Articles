import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:newsarticle/routes/app_navigation.dart';
import 'package:newsarticle/screens/home/network_error_screen.dart';


class ConnectivityService {
  bool isConnected = false;

  init() async {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        Navigator.of(AppNavigation.mainRootNavigatorKey.currentState!.context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) {
              return const NoNetWorkScreen();
            },
          ),
        );
        isConnected = true;
      } else if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)) {
        if (isConnected) {
          isConnected = false;
          if (AppNavigation.router.canPop()) {
            AppNavigation.router.pop();
          }
        }
      }
    });
  }
}
