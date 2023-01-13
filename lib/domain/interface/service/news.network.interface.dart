import '../../service/news/dto/news.dto.dart';
import '../../service/news/model/news_response.dart';

abstract class INewsNetworkService {
  Future<NewsResponse> getNewsList(NewsDto dto);
}
