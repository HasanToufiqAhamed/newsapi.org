import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/model/news/news_ui.model.dart';
import '../../interface/repository/book_mark.repository.interface.dart';
import '../../interface/service/book_mark_service_interface.dart';

class BookMarkRepository extends IBookMarkRepository {
  final IBookMarkNetworkService _service;

  BookMarkRepository({required IBookMarkNetworkService service})
      : _service = service;

  @override
  Future<List<NewsUIModel>> getBookMarkNews(String userId) async {
    try {
      List<NewsUIModel> list = [];

      QuerySnapshot res = await _service.getBookMarkList(userId: userId);

      for (var val in res.docs) {
        print('idddddd:${val.id}');
        NewsUIModel news =
            NewsUIModel.fromJson(val.data() as Map<String, dynamic>);
        news.firebaseId = val.id;

        list.add(news);
      }

      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NewsUIModel>> listenBookMarkNews(String userId) async {
    try {
      List<NewsUIModel> list = [];

      Stream<QuerySnapshot> res = _service.listenBookMarkList(userId: userId);

      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void addBookMark(String userId, NewsUIModel news) {
    try {
      _service.addBookMark(userId: userId, news: news);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void removeBookMark(String userId, String newsId) {
    try {
      _service.removeBookMark(userId: userId, newsId: newsId);
    } catch (e) {
      rethrow;
    }
  }
}
