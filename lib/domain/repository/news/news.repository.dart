import '../../core/model/news/news_ui.model.dart';
import '../../interface/repository/news.repository.interface.dart';
import '../../interface/service/news.network.interface.dart';
import '../../service/news/dto/news.dto.dart';
import '../../service/news/model/news_response.dart';

class NewsRepository extends INewsRepository {
  final INewsNetworkService _service;

  NewsRepository({required INewsNetworkService service}) : _service = service;

  @override
  Future<List<NewsUIModel>> getAllNews(NewsDto dto) async {
    try {
      List<NewsUIModel> list = [];

      NewsResponse res = await _service.getNewsList(dto);

      for (var value in res.articles!) {
        list.add(
          NewsUIModel(
            sourceName: value.source!.name!,
            title: value.title!,
            description: value.description ?? '',
            url: value.url!,
            urlToImage: value.urlToImage ?? '',
            publishedAt: value.publishedAt!,
            content: value.content ?? '',
          ),
        );
      }

      return list;
    } catch (e) {
      rethrow;
    }
  }
}
