import 'dart:convert';

import 'package:untitled/config.dart';

class NewsDto {
  String country;
  String category;
  String searchKey;
  int page;

  NewsDto({
    this.country = '',
    this.category = '',
    this.searchKey = '',
    this.page = 0,
  });

  Map<String, String> toStringJson() {
    final Map<String, String> data = <String, String>{};
    data['apiKey'] = ConfigEnvironments.apiKey;
    data['pageSize'] = ConfigEnvironments.perPage.toString();
    if (country.isNotEmpty) data['country'] = country;
    if (category.isNotEmpty) data['category'] = category;
    if (searchKey.isNotEmpty) data['q'] = searchKey;
    data['page'] = page.toString();

    return data;
  }
}
