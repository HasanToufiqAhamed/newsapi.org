import 'package:get/get.dart';

import '../modules/book_mark/bindings/book_mark_binding.dart';
import '../modules/book_mark/views/book_mark_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/news_details/bindings/news_details_binding.dart';
import '../modules/news_details/middleware/news_details_middleware.dart';
import '../modules/news_details/views/news_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      bindings: [BookMarkBinding(), HomeBinding()],
    ),
    GetPage(
        name: _Paths.NEWS_DETAILS,
        page: () => const NewsDetailsView(),
        binding: NewsDetailsBinding(),
        middlewares: [
          NewsDetailsMiddleware(),
        ]),
    GetPage(
      name: _Paths.BOOK_MARK,
      page: () => const BookMarkView(),
      binding: BookMarkBinding(),
    ),
  ];
}
