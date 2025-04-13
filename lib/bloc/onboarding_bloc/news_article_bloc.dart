import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsarticle/bloc/onboarding_bloc/news_article_events.dart';
import 'package:newsarticle/bloc/onboarding_bloc/news_article_repo.dart';
import 'package:newsarticle/bloc/onboarding_bloc/news_article_state.dart';
import 'package:newsarticle/model/response/news_list_response.dart';

class NewsArticleBloc extends Bloc<NewsArticleEvents, NewsArticleState> {
  final NewsArticleRepository newsArticleRepo;

  bool isLoading = false;
  List<Articles> articleList = [];
  dynamic body;
  NewsArticleBloc({required this.newsArticleRepo})
      : super(NewsArticleInItState()) {
    on<NewsArticleEvents>((events, emit) async {
      if (events == NewsArticleEvents.updateState) {
        emit(NewsArticleErrorState());
        emit(NewsArticleUpdateState());
      }
      if (events == NewsArticleEvents.fetchArticle) {
        await fetchArticle(emit);
      }
    });
  }

  fetchArticle(Emitter<NewsArticleState> emit) async {
    try {
      isLoading = true;
      emit(NewsArticleLoading());
      String path = "v2/everything";
      var newsListResponse = await newsArticleRepo.fetchNews(path, body);
      isLoading = false;
      if (newsListResponse.articles!.isNotEmpty) {
        articleList = newsListResponse.articles!;
        emit(NewsArticleListState(newsListResponse: newsListResponse));
      } else {
        articleList = [];
        emit(NewsArticleErrorState());
      }
    } catch (e) {
      errorHandle(e, emit, "fetchArticle");
    }
  }


  errorHandle(dynamic e, Emitter<NewsArticleState> emit, String errorMethod) {
    isLoading = false;
    if (kDebugMode) {
      debugPrint("Error is $e $errorMethod NewsArticleBloc Bloc");
    }
    emit(NewsArticleErrorState());
  }
}
