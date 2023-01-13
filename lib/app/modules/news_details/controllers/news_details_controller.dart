import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:untitled/app/modules/book_mark/controllers/book_mark_controller.dart';

import '../../../../domain/core/model/news/news_ui.model.dart';
import '../../../utilities/custom_widgets/message/snack_bars.dart';

class NewsDetailsController extends GetxController {
  final BookMarkController _bookMarkController;

  NewsDetailsController({
    required BookMarkController bookMarkController,
  }) : _bookMarkController = bookMarkController;

  @override
  void onInit() {
    super.onInit();
  }

  NewsUIModel? news;

  void initFromMiddleware({required NewsUIModel news}) {
    this.news = news;
    bookMarkInfo();
  }

  List<NewsUIModel> localBookMarkList = [];
  RxBool isBookMarked = false.obs;

  void bookMarkInfo() {
    int index = _bookMarkController.bookMarkList.indexWhere((element) {
      return element.title == news?.title &&
          element.content == news?.content &&
          element.urlToImage == news?.urlToImage &&
          element.description == news?.description;
    });

    if (index != -1) {
      isBookMarked.value = true;
    } else {
      isBookMarked.value = false;
    }
  }

  void makeBookmark() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      showBasicSnackBar(
        message: 'Please check your internet connection',
        success: false,
      );
      return;
    }
    _bookMarkController.addToBookMark(news: news);
    bookMarkInfo();
  }
}
