import 'package:equatable/equatable.dart';
import 'package:newsarticle/model/response/news_list_response.dart';

abstract class NewsArticleState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsArticleInItState extends NewsArticleState {}

class NewsArticleLoading extends NewsArticleState {}

class NewsArticleUpdateState extends NewsArticleState {}

class NewsArticleErrorState extends NewsArticleState {}

class NewsArticleListState extends NewsArticleState {
  final NewsListResponse newsListResponse;

  NewsArticleListState({required this.newsListResponse});
}

class LoadMoreNewsState extends NewsArticleState {}
