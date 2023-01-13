import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:untitled/app/database/book_mark_database.dart';
import 'package:untitled/domain/core/model/news/news_ui.model.dart';

import '../../../../domain/repository/book_mark/book_mark.repository.dart';
import '../../../utilities/custom_widgets/message/snack_bars.dart';

class BookMarkController extends GetxController {
  final BookMarkRepository _bookMarkRepository;

  BookMarkController({
    required BookMarkRepository bookMarkRepository,
  }) : _bookMarkRepository = bookMarkRepository;

  final _database = BookMarkDatabase.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    getBookMarkList();
    if (_auth.currentUser?.uid.isNotEmpty ?? false) await getOnlineBookMarkList();
  }

  RxList<NewsUIModel> bookMarkList = <NewsUIModel>[].obs;

  void addToBookMark({NewsUIModel? news}) {
    if (_auth.currentUser?.uid.isEmpty ?? true) {
      showBasicSnackBar(message: 'Please login first', success: false);
      return;
    }
    addRemoveBookMarkList(news: news!);
  }

  void addRemoveBookMarkList({
    required NewsUIModel news,
  }) async {
    int index = bookMarkList.indexWhere((element) {
      return (element.title == news.title &&
          element.content == news.content &&
          element.urlToImage == news.urlToImage &&
          element.description == news.description);
    });
    if (index == -1) {
      bookMarkList.add(news);
      _database.saveBookMarkList(newBookMarkList: bookMarkList);

      _bookMarkRepository.addBookMark(_auth.currentUser?.uid ?? '', news);
    } else {
      bookMarkList.removeWhere(
        (element) {
          return element.title == news.title &&
              element.content == news.content &&
              element.urlToImage == news.urlToImage &&
              element.description == news.description;
        },
      );
      _database.saveBookMarkList(newBookMarkList: bookMarkList);

      if (_auth.currentUser?.uid.isNotEmpty ?? false) {
        String fireId = await getNewsId(news);

        _bookMarkRepository.removeBookMark(
            _auth.currentUser?.uid ?? '', fireId);
      }
    }
  }

  void getBookMarkList() {
    bookMarkList.clear();
    bookMarkList.value = _database.getBookMarkList();
  }

  Future<void> getOnlineBookMarkList() async {
    List<NewsUIModel> list =
        await _bookMarkRepository.getBookMarkNews(_auth.currentUser?.uid ?? '');

    if (list.isNotEmpty) {
      List<NewsUIModel> l = [];
      for (NewsUIModel val in list) {
        l.add(val);
      }

      _database.saveBookMarkList(newBookMarkList: l);
    }

    getBookMarkList();
  }

  Future<String> getNewsId(NewsUIModel news) async {
    List<NewsUIModel> onlineBookMarkList =
        await _bookMarkRepository.getBookMarkNews(_auth.currentUser?.uid ?? '');
    int index = onlineBookMarkList.indexWhere((element) {
      return (element.title == news.title &&
          element.content == news.content &&
          element.urlToImage == news.urlToImage &&
          element.description == news.description);
    });
    if (index != -1) {
      return onlineBookMarkList[index].firebaseId;
    }
    return '';
  }
}
