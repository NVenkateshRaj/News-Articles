import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsarticle/constants/colors.dart';
import 'package:newsarticle/constants/styles.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearch;
  final Function(String)? onChanged;
  final bool isLeading;
  final String? title;
  final bool centerTitle;

  const CommonAppbar(
      {super.key,
      this.isSearch = false,
      this.onChanged,
      this.isLeading = true,
      this.title,
      this.centerTitle = false
     });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.appBarColor,
      elevation: 0,
      leadingWidth: !isLeading ? 0 : 25.w,
      leading: !isLeading ? Container() : null,
      centerTitle: centerTitle,
      titleSpacing: 20.w,
      title: Text(
        title!,
        style: AppTextStyle.breadCrumbSelect.copyWith(
            fontSize: 18, fontWeight: FontWeight.normal),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
