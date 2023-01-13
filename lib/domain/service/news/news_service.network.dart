import 'dart:convert';

import 'package:untitled/domain/core/exceptions/invalid_token.exception.dart';
import 'package:untitled/domain/core/exceptions/time_out.exception.dart';

import '../../core/abstractions/http_connect.interface.dart';
import '../../core/exceptions/default.exception.dart';
import '../../interface/service/news.network.interface.dart';
import 'dto/news.dto.dart';
import 'model/news_response.dart';

class NewsNetworkService extends INewsNetworkService {
  final IHttpConnect _connect;

  String get _prefix => 'v2';

  NewsNetworkService(IHttpConnect connect) : _connect = connect;

  @override
  Future<NewsResponse> getNewsList(NewsDto dto) async {
    try {
      final response = await _connect.get<NewsResponse>(
        '$_prefix/top-headlines',
        query: dto.toStringJson(),
        headers: {
          'Accept': 'application/json',
        },
        decoder: (value) {
          return NewsResponse.fromJson(
            value is String
                ? json.decode(value)
                : value as Map<String, dynamic>,
          );
        },
      );

      if (response.success) {
        return response.payload!;
      } else {
        switch (response.statusCode) {
          case 401:
            throw InvalidTokenException(
                message: response.payload?.message ?? 'Invalid api!');
          case 408:
            throw TimeOutException(
                message: response.payload?.message ?? 'Time out!');
          default:
            throw DefaultException(
              message: response.payload?.message ?? 'Error loading data!',
            );
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
