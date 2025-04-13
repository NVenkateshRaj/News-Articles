import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newsarticle/bloc/onboarding_bloc/news_article_bloc.dart';
import 'package:newsarticle/bloc/onboarding_bloc/news_article_events.dart';
import 'package:newsarticle/bloc/onboarding_bloc/news_article_state.dart';
import 'package:newsarticle/constants/colors.dart';
import 'package:newsarticle/constants/images.dart';
import 'package:newsarticle/constants/strings.dart';
import 'package:newsarticle/constants/styles.dart';
import 'package:newsarticle/locator.dart';
import 'package:newsarticle/model/response/news_list_response.dart';
import 'package:newsarticle/routes/routes.dart';
import 'package:newsarticle/screens/utils.dart';
import 'package:newsarticle/widgets/common_appbar.dart';
import 'package:newsarticle/widgets/common_loading.dart';
import 'package:newsarticle/widgets/common_text_field.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<DashboardScreen> {
  NewsArticleBloc? newsArticleBloc;
  List<Articles> totalArticleList = [];
  List<Articles> articleList = [];
  List<String> searchList = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode searchFocus = FocusNode();
  int totalRecords = 0;
  int currentMax = 0;
  int itemsPerPage = 20;
  bool isLoading = false;

  @override
  void initState() {
    newsArticleBloc = BlocProvider.of<NewsArticleBloc>(context);
    hiveService.deleteFiveDaysOnce();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !isLoading) {
        lazyLoading(true);
      }
    });
    super.initState();
  }

  searchArticles(String articleName) {
    if (articleName.length > 3) {
      newsArticleBloc!
        ..body = {"q": articleName}
        ..add(NewsArticleEvents.fetchArticle);
      currentMax = 0;
      totalRecords = 0;
      hiveService.storeSearchValues(articleName);
      searchFocus.unfocus();
      storeSearchValue();
    }
  }

  storeSearchValue() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsArticleBloc, NewsArticleState>(
        builder: (BuildContext context, NewsArticleState state) {
      if (state is NewsArticleListState) {
        articleList = [];
        totalArticleList = state.newsListResponse.articles!;
        totalRecords = totalArticleList.length;
        lazyLoading(false);
      }
      return Scaffold(
        backgroundColor: AppColor.dashboardBackgroundColor,
        appBar: CommonAppbar(
          title: Strings.newsArticle,
          isLeading: true,
          centerTitle: false,
        ),
        body: CommonLoadingScreen(
          absorbing: newsArticleBloc!.isLoading,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonTextField(
                  textFieldTitle: Strings.searchArticles,
                  isNumberPad: false,
                  maxLength: 6,
                  onTap: () {
                    searchList = hiveService.fetchStoredValues();
                    newsArticleBloc!.add(NewsArticleEvents.updateState);
                  },
                  controller: searchController,
                  hintText: Strings.hintSearchArticles,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      articleList.clear();
                      totalArticleList.clear();
                      searchList = hiveService.fetchStoredValues();
                      newsArticleBloc!.add(NewsArticleEvents.updateState);
                    }
                  },
                  onSubmitted: (value) {},
                  isSearchField: true,
                  isSearchingIcon: true,
                  suggestions: searchList,
                  suffixIcon: Icon(Icons.search),
                  suffixIconOnTap: () {
                    searchArticles(searchController.text);
                  },
                  onSuggestionTap: (val) {
                    searchArticles(searchController.text);
                  },
                  focusNode: searchFocus,
                  maxLine: 1,
                  bottomSpace: 16.h,
                  validator: (val) {
                    if (val.isEmpty) {
                      return Strings.hintSearchArticles;
                    }
                  },
                ),
                articleList.isNotEmpty
                    ? ListView.separated(
                        itemCount: articleList.length,
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Articles article = articleList[index];
                          return InkWell(
                            onTap: () {
                              context.push(Routes.newsDetailsPath,
                                  extra: article);
                            },
                            child: Container(
                              decoration: boxDecoration(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 16.w),
                              child: Column(
                                spacing: 5.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  richText(Strings.title, article.title!),
                                  richText(Strings.sourceName,
                                      article.source!.name!),
                                  richText(
                                      Strings.publicationDate,
                                      article.publishedAt!.isNotEmpty
                                          ? serverToUiFormat(
                                              article.publishedAt!)
                                          : ""),
                                  richText(Strings.description,
                                      article.description!),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          spacing: 10.h,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 70.h,
                            ),
                            Text(
                              Strings.noDataFound,
                              style: AppTextStyle.bodyRegular,
                            ),
                            SizedBox(
                              height: 200.h,
                              width: 200.w,
                              child: Image.asset(Images.noNews),
                            )
                          ],
                        ),
                      ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColor.primary,
                      ))
                    : Container()
              ],
            ),
          ),
        ),
        floatingActionButton: currentMax > 20
            ? FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                },
                backgroundColor: AppColor.appBarColor,
                child: Icon(
                  Icons.arrow_upward_outlined,
                  color: AppColor.white,
                ),
              )
            : null,
      );
    });
  }

  void lazyLoading(isLoading) {
    isLoading = isLoading;
    newsArticleBloc!.add(NewsArticleEvents.updateState);
    Future.delayed(Duration(milliseconds: 500), () {
      int nextMax = currentMax + itemsPerPage;
      if (nextMax > totalRecords) nextMax = totalRecords;
      articleList.addAll(totalArticleList.getRange(currentMax, nextMax));
      currentMax = nextMax;
      isLoading = false;
      newsArticleBloc!.add(NewsArticleEvents.updateState);
    });
  }
}
