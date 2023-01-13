import 'package:untitled/domain/service/news/dto/news.dto.dart';

import '../../core/model/news/news_ui.model.dart';

abstract class INewsRepository {
  Future<List<NewsUIModel>> getAllNews(NewsDto dto);
}
