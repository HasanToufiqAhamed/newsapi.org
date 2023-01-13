import 'package:get/get.dart';

import '../interface/repository/news.repository.interface.dart';
import '../repository/news/news.repository.dart';
import '../service/connect.dart';
import '../service/news/news_service.network.dart';

class NewsRepositoryBindings {
  late final INewsRepository _repository;

  INewsRepository get repository => _repository;

  NewsRepositoryBindings() {
    final GetConnect getConnect = Get.find<GetConnect>();
    final Connect connect = Connect(connect: getConnect);
    final service = NewsNetworkService(connect);
    _repository = NewsRepository(service: service);
  }
}
