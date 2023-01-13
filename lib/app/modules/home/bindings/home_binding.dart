import 'package:get/get.dart';
import 'package:untitled/domain/repositiry_bindings/news.repository.bindings.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        newsRepository: NewsRepositoryBindings().repository,
        bookMarkController: Get.find(),
      ),
    );
  }
}
