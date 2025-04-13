import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newsarticle/bloc/onboarding_bloc/news_article_bloc.dart';
import 'package:newsarticle/bloc/onboarding_bloc/news_article_repo.dart';
import 'package:newsarticle/constants/strings.dart';
import 'package:newsarticle/constants/styles.dart';
import 'package:newsarticle/routes/app_navigation.dart';


Timer? rootTimer;
bool isAuthorized = false;


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  NewsArticleBloc(newsArticleRepo: NewsArticleRepoService())),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: false,
          builder: (context, child) {
            if (ScreenUtil().screenWidth < 600) {
              ScreenUtil.init(context, designSize: const Size(375, 812));
            } else if (ScreenUtil().screenWidth < 1200) {
              ScreenUtil.init(context, designSize: const Size(768, 1024));
            } else {
              ScreenUtil.init(context, designSize: const Size(1440, 900));
            }
            return MaterialApp.router(
              title: Strings.newsArticle,
              theme: AppStyle.appTheme,
              debugShowCheckedModeBanner: false,
              routerConfig: AppNavigation.router,
            );
          },
        ));
  }
}
