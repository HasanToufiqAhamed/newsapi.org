import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/model/news/news_ui.model.dart';

abstract class IBookMarkNetworkService {
  Stream<QuerySnapshot> listenBookMarkList({required String userId});

  Future<QuerySnapshot> getBookMarkList({required String userId});

  void addBookMark({required String userId, required NewsUIModel news});

  void removeBookMark({required String userId, required String newsId});
}
