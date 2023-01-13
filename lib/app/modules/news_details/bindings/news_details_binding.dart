import 'package:get/get.dart';

import '../controllers/news_details_controller.dart';

class NewsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewsDetailsController>(
      NewsDetailsController(bookMarkController: Get.find()),
    );
  }
}
