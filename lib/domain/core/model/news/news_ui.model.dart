import 'dart:convert';

class NewsUIModel {
  late String sourceName;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late DateTime publishedAt;
  late String content;
  late String firebaseId;

  NewsUIModel({
    required this.sourceName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    this.firebaseId = '',
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['sourceName'] = sourceName;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt.toString();
    data['content'] = content;

    return data;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['sourceName'] = sourceName;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['urlToImage'] = urlToImage;
    map['publishedAt'] = publishedAt.toString();
    map['content'] = content;

    return map;
  }

  NewsUIModel.fromJson(Map<String, dynamic> json) {
    sourceName = json['sourceName'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    url = json['url'] ?? '';
    urlToImage = json['urlToImage'] ?? '';
    publishedAt = DateTime.parse(json['publishedAt']);
    content = json['content'] ?? '';
  }

  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(toJson());
  }
}
