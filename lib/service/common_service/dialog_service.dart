import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newsarticle/constants/colors.dart';
import 'package:newsarticle/constants/strings.dart';
import 'package:newsarticle/constants/styles.dart';
import 'package:newsarticle/routes/app_navigation.dart';

class DialogService {
  Future<void> showDialogAlert(
      {required String title,
      required String content,
      String cancelBtnText = Strings.close,
      String? primaryBtnText,
      Function()? onTap}) {
    return showDialog(
      context: AppNavigation.mainRootNavigatorKey.currentState!.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LayoutBuilder(builder: (context, constraints) {
          return AlertDialog(
            backgroundColor: AppColor.background,
            actionsAlignment: primaryBtnText == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.end,
            title: Text(
              title,
              style: AppTextStyle.regular,
            ),
            content: Text(
              content,
              style: AppTextStyle.bodyRegular,
            ),
            actions: <Widget>[
              primaryBtnText != null
                  ? TextButton(
                      onPressed: () {
                        onTap!.call();
                        closeDialog();
                      },
                      child: Text(
                        primaryBtnText,
                        style: AppTextStyle.bodyRegular.copyWith(
                          color: AppColor.appBarColor,
                        ),
                      ),
                    )
                  : Container(),
              TextButton(
                onPressed: () {
                  closeDialog();
                },
                child: Text(
                  cancelBtnText,
                  style: AppTextStyle.bodyRegular,
                ),
              ),
            ],
          );
        });
      },
    );
  }

  void closeDialog() {
    AppNavigation.mainRootNavigatorKey.currentState!.pop();
  }
}
