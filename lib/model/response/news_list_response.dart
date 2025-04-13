class NewsListResponse {
  String? status;
  int? totalResults;
  List<Articles>? articles;
  String? message;

  NewsListResponse({this.status, this.totalResults, this.articles});

  NewsListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    totalResults = json['totalResults'] ?? 0;
    message = json['message'] ?? "";
    articles = json['articles'] != null
        ? (json['articles'] as List)
        .map((element) => Articles.fromJson(element))
        .toList()
        : [];
  }

}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
    json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'] ?? "";
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    url = json['url'] ?? "";
    urlToImage = json['urlToImage'] ?? "";
    publishedAt = json['publishedAt'] ?? "";
    content = json['content'] ?? "";
  }

}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }
}
