import 'package:get/get.dart';
import 'package:untitled/domain/repositiry_bindings/book_mark.repository.bindings.dart';

import '../controllers/book_mark_controller.dart';

class BookMarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookMarkController>(
      BookMarkController(
        bookMarkRepository: BookMarkRepositoryBindings().repository,
      ),
    );
  }
}
