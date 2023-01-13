import '../repository/book_mark/book_mark.repository.dart';
import '../service/bookmark/book_mark_services.dart';

class BookMarkRepositoryBindings {
  late BookMarkRepository _bookMarkRepository;

  BookMarkRepository get repository => _bookMarkRepository;

  BookMarkRepositoryBindings() {
    _bookMarkRepository = BookMarkRepository(service: BookMarkServices());
  }
}