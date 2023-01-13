import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/model/news/news_ui.model.dart';
import '../../interface/service/book_mark_service_interface.dart';

class BookMarkServices extends IBookMarkNetworkService {

  BookMarkServices._() {
    _i = this;
  }

  static BookMarkServices? _i;

  factory BookMarkServices() => _i ?? BookMarkServices._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<QuerySnapshot> getBookMarkList({required String userId}) {
    try {
      return _firestore.collection(userId).get();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot> listenBookMarkList({required String userId}) {
    try {
      return _firestore.collection(userId).snapshots();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void addBookMark({
    required String userId,
    required NewsUIModel news,
  }) {
    try {
      _firestore.collection(userId).add(news.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  void removeBookMark({
    required String userId,
    required String newsId,
  }) {
    try {
      _firestore.collection(userId).doc(newsId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
