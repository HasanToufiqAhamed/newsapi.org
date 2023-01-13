import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/database/book_mark_database.dart';
import 'config.dart';

class Initializer {
  static Future<void> init() async {
    try {
      await _initStorage();
      await _initGetConnect();
     await bookMarkDatabase();
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _initGetConnect() async {
    final connect = GetConnect();

    final url = ConfigEnvironments.getEnvironments()['url'];
    connect.baseUrl = url;
    connect.timeout = const Duration(seconds: 30);
    connect.httpClient.maxAuthRetries = 0;
    connect.httpClient.addRequestModifier<dynamic>(
      (request) {
        return request;
      },
    );

    connect.httpClient.addResponseModifier(
      (request, response) async {
        debugPrint('request to:=> ${request.url}');
        return response;
      },
    );
    Get.put(connect);
  }

  static Future<void> _initStorage() async {
    await GetStorage.init();
    Get.put(GetStorage());
  }

  static Future<void> bookMarkDatabase() async {
    await GetStorage.init(BookMarkDBKeys.dbName);
  }
}
