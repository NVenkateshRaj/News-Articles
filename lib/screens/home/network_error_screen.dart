import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsarticle/constants/colors.dart';
import 'package:newsarticle/constants/styles.dart';
import 'package:newsarticle/widgets/common_button.dart';

class NoNetWorkScreen extends StatelessWidget{
  const NoNetWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Container(
        margin: EdgeInsets.all(16.0.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.network_check,size: 125.sp,color: AppColor.primary,),
               Text("Whoops",style: AppTextStyle.headerMedium.copyWith(color: AppColor.primary),),
              SizedBox(height: 10.h,),
              Text("No network connection found, Please check your internet settings",style: AppTextStyle.button.copyWith(color: AppColor.text),textAlign: TextAlign.center,),
              SizedBox(height: 10.h,),
              SizedBox(
                width: 200.w,
                child: CommonButton(
                    buttonText: "Try Again",
                    onPressed: (){
                      Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result){
                        if(result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile)){
                          Navigator.pop(context);
                        }
                      }
                      );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}