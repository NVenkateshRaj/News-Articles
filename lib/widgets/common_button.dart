import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsarticle/constants/colors.dart';
import 'package:newsarticle/constants/font_size.dart';
import 'package:newsarticle/constants/styles.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? borderColor;
  final bool isOutLine;
  final TextStyle? textStyle;
  final Function(bool value)? onHover;
  final VoidCallback? longPress;
  final List<BoxShadow>? boxShadow;
  final double? buttonWidth;
  final double? borderWidth;
  final bool isButtonDisabled;

  const CommonButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
    this.borderColor,
    this.isOutLine = false,
    this.textStyle,
    this.onHover,
    this.longPress,
    this.boxShadow,
    this.buttonWidth,
    this.borderWidth,
    this.isButtonDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
            width: buttonWidth ?? ( constraints.maxWidth > 600 ? 325.w : double.maxFinite),
            child: isOutLine
                ? Container(
                    width: buttonWidth ?? double.maxFinite,
                    decoration: BoxDecoration(
                      boxShadow: boxShadow ??
                          [
                            const BoxShadow(
                              color: AppColor.appBarColor,
                              offset: Offset(0, 2),
                              blurRadius: 8,
                            ),
                          ],
                    ),
                    child: OutlinedButton(
                      onPressed: onPressed,
                      onHover: onHover != null
                          ? (hover) => onHover!.call(hover)
                          : null,
                      onLongPress:
                          longPress != null ? () => longPress!() : null,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColor.white,
                        side: BorderSide(
                          color: borderColor ?? AppColor.primary,
                          width: borderWidth ?? 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      ),
                      child: Text(buttonText,
                          style: textStyle ??
                              AppTextStyle.button.copyWith(
                                  color: AppColor.dashboardIconColor,
                                  fontWeight: FontWeight.w500)),
                    ))
                : Container(
                    width: buttonWidth ?? double.maxFinite,
                    decoration: BoxDecoration(
                      boxShadow: boxShadow ??
                          [
                            const BoxShadow(
                              color: Color.fromRGBO(244, 158, 44, 0.1),
                              offset: Offset(0, 2),
                              blurRadius: 8,
                            ),
                          ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        isButtonDisabled ? null : onPressed();
                      },
                      onHover: onHover != null
                          ? (hover) => onHover!.call(hover)
                          : null,
                      onLongPress:
                          longPress != null ? () => longPress!() : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isButtonDisabled
                            ? AppColor.primary.withValues(alpha:0.75)
                            : buttonColor ?? AppColor.primary,
                        disabledForegroundColor: AppColor.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                          side: BorderSide(
                            color: isButtonDisabled
                                ? AppColor.primary.withValues(alpha:0.5)
                                : borderColor ?? AppColor.primary,
                            width: borderWidth ?? 1.0,
                          ),
                        ),
                      ),
                      child: Text(buttonText,
                          style: isButtonDisabled
                              ? AppTextStyle.button.copyWith(
                                  color: AppColor.white.withValues(alpha:0.75))
                              : textStyle ?? AppTextStyle.button),
                    ),
                  ));
      },
    );
  }
}

class CommonTextButton extends StatelessWidget {
  final String buttonText;
  final Function() onTap;
  final TextStyle? buttonTextStyle;
  final Widget? icon;
  final double? width;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const CommonTextButton(
      {super.key,
      required this.buttonText,
      required this.onTap,
      this.buttonTextStyle,
      this.icon,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.width = 6});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: [
              icon ?? Container(),
              SizedBox(
                width: width!.w,
              ),
              Text(
                buttonText,
                style: buttonTextStyle ??
                    AppTextStyle.button.copyWith(
                        color: AppColor.bottomBarIconColor,
                        fontSize: AppFontSize.dp14),
              ),
            ]));
  }
}
