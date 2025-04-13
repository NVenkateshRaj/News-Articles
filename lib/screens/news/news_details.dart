import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsarticle/constants/strings.dart';
import 'package:newsarticle/constants/styles.dart';
import 'package:newsarticle/model/response/news_list_response.dart';
import 'package:newsarticle/screens/utils.dart';
import 'package:newsarticle/widgets/common_appbar.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Articles article;
  const NewsDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: article.source!.name!,
        isLeading: true,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
        child: Container(
          decoration: boxDecoration(),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            spacing: 5.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              richText(Strings.title, article.title!),
              richText(Strings.sourceName, article.source!.name!),
              richText(
                  Strings.publicationDate,
                  article.publishedAt!.isNotEmpty
                      ? serverToUiFormat(article.publishedAt!)
                      : ""),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${Strings.description} : ",style: AppTextStyle.headerMedium,),
                  Expanded(child: Text(article.description!, style: AppTextStyle.bodyRegular,),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
