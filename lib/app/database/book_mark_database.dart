import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import '../../domain/core/model/news/news_ui.model.dart';

class BookMarkDatabase {
  static BookMarkDatabase? _instance;

  BookMarkDatabase._() {
    _instance = this;
  }

  static BookMarkDatabase get instance => _instance ?? BookMarkDatabase._();

  void init() async {
    await GetStorage.init(BookMarkDBKeys.dbName);
  }

  bool saveBookMarkList({
    required List<NewsUIModel> newBookMarkList,
  }) {
    final storage = GetStorage(BookMarkDBKeys.dbName);
    storage.write(BookMarkDBKeys.list, jsonEncode(newBookMarkList));
    storage.save();
    return true;
  }

  List<NewsUIModel> getBookMarkList() {
    try {
      final storage = GetStorage(BookMarkDBKeys.dbName);
      String? data = storage.read(BookMarkDBKeys.list);

      List<NewsUIModel> list = [];
      if (data != null && data.isNotEmpty) {
        var map = jsonDecode(data);
        for (var json in map) {
          NewsUIModel p = NewsUIModel(
            sourceName: json['sourceName'],
            title: json['title'],
            description: json['description'],
            url: json['url'],
            urlToImage: json['urlToImage'],
            publishedAt: DateTime.parse(json['publishedAt']),
            content: json['content'],
          );
          list.add(p);
        }

        return list;
      } else {
        return [];
      }
    } catch (e, t) {
      debugPrint('local book mark database error ---<>');
      debugPrint(e.toString());
      debugPrint(t.toString());
      return [];
    }
  }
}

class BookMarkDBKeys {
  static const dbName = 'bookMarkListDb';
  static const list = 'bookMarkList';
}
