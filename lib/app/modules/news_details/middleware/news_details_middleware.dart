import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/news_details/controllers/news_details_controller.dart';

import '../../../../domain/core/model/news/news_ui.model.dart';

class NewsDetailsMiddleware extends GetMiddleware {
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    return page;
  }

  @override
  Widget onPageBuilt(Widget page) {
    try {
      String data = Get.parameters['data'] ?? '';

      // if (kDebugMode) {
      //   print('hello middleware::: ${data.toString()}');
      // }

      if (data.isNotEmpty) {
        Map<String, dynamic> mapData = jsonDecode(data);
        NewsUIModel news = NewsUIModel(
          sourceName: mapData['sourceName'] ?? '',
          title: mapData['title'] ?? '',
          description: mapData['description'] ?? '',
          url: mapData['url'] ?? '',
          urlToImage: mapData['urlToImage'] ?? '',
          publishedAt: DateTime.parse(mapData['publishedAt']),
          content: mapData['content'] ?? '',
        );

        NewsDetailsController newsDetailsController = Get.find();
        newsDetailsController.initFromMiddleware(
          news: news,
        );
      }
    } catch (e, t) {
      debugPrint('[pet details MiddleWare]  error ---<>');
      debugPrint(e.toString());
      debugPrint(t.toString());
    }
    return page;
  }
}
