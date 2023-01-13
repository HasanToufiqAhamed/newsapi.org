import 'package:untitled/domain/service/news/dto/news.dto.dart';

import '../../core/model/news/news_ui.model.dart';

abstract class IBookMarkRepository {
  Future<List<NewsUIModel>> getBookMarkNews(String userId);

  Future<List<NewsUIModel>> listenBookMarkNews(String userId);

  void addBookMark(String userId, NewsUIModel news);

  void removeBookMark(String userId, String newsId);
}
