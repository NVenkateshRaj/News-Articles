
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newsarticle/constants/colors.dart';
import 'package:newsarticle/constants/styles.dart';

boxDecoration(
    {Color? backgroundColor,
      BorderRadius? borderRadius,
      BoxShape? boxShape,
      double? radius}) {
  return BoxDecoration(
    color: backgroundColor ?? AppColor.white,
    shape: boxShape ?? BoxShape.rectangle,
    borderRadius: boxShape == BoxShape.circle
        ? null
        : borderRadius ?? BorderRadius.circular(radius ?? 8.sp),
  );
}

serverToUiFormat(String date) {
  if (date.isNotEmpty) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat outputFormat = DateFormat("dd/MM/yyyy");
    String formattedDate = outputFormat.format(dateTime);
    return formattedDate;
  } else {
    return "";
  }
}

richText(String title, String value) {
  return RichText(
    text: TextSpan(
      text: "$title : ",
      style: AppTextStyle.headerMedium,
      children: <TextSpan>[
        TextSpan(text: value, style: AppTextStyle.bodyRegular,),
      ],
    ),
  );
}