import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsarticle/model/response/news_list_response.dart';
import 'package:newsarticle/routes/routes.dart';
import 'package:newsarticle/screens/home/dashboard_screen.dart';
import 'package:newsarticle/screens/home/splash_screen.dart';
import 'package:newsarticle/screens/news/news_details.dart';

class AppNavigation {
  AppNavigation._();

  static final mainRootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
      initialLocation: Routes.initialPath,
      navigatorKey: mainRootNavigatorKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          path: Routes.initialPath,
          name: Routes.splash,
          parentNavigatorKey: mainRootNavigatorKey,
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
        GoRoute(
          path: Routes.dashboardPath,
          name: Routes.dashboard,
          parentNavigatorKey: mainRootNavigatorKey,
          builder: (context, state) {
            return const DashboardScreen();
          },
        ),
        GoRoute(
          path: Routes.newsDetailsPath,
          name: Routes.newsDetails,
          parentNavigatorKey: mainRootNavigatorKey,
          builder: (context, state) {
            final article = state.extra as Articles;
            return NewsDetailsScreen(article: article);
          },
        ),
      ],
      redirect: (context, state) async {
        return null;
      });
}
