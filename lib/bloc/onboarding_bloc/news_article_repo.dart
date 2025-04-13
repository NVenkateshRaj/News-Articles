import 'package:newsarticle/locator.dart';
import 'package:newsarticle/model/response/news_list_response.dart';
import 'package:newsarticle/service/api_service/api_service.dart';

abstract class NewsArticleRepository {
  Future<NewsListResponse> fetchNews(String path, dynamic body);
}

class NewsArticleRepoService extends NewsArticleRepository {
  @override
  Future<NewsListResponse> fetchNews(String path, body) async {
    var response = await ApiService().get(path, null, queryParams: body);
    NewsListResponse newsListResponse = NewsListResponse.fromJson(response);
    if (newsListResponse.message!.isEmpty) {
      return newsListResponse;
    } else {
      dialogService.showDialogAlert(
          title: newsListResponse.status!, content: newsListResponse.message!);
      return NewsListResponse();
    }
  }
}
