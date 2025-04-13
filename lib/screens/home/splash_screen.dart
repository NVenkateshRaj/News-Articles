import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newsarticle/constants/images.dart';
import 'package:newsarticle/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    navigationCall();
    super.initState();
  }

  navigationCall() {
    Future.delayed(const Duration(milliseconds: 500), () {
      context.go(Routes.dashboardPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 100.h,
            width: 100.w,
            child: Image.asset(Images.logo),
        ),
      ),
    );
  }
}
