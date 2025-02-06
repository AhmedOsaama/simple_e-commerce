import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dio_headers.dart';

class NetworkServices {
  static String fakeStoreUrl = dotenv.env['FAKE_STORE_BASEURL']!;

  final String _baseUrl = fakeStoreUrl;

  final Dio _dio;
  NetworkServices(this._dio);

  ///Products
  Future<Response> getProducts(int pageNumber) async {
    var response =  await _dio.get("$_baseUrl/products", options: Options(headers: DioHeaders.getHeaders()),
        queryParameters: {
      "limit": 10,
      "offset": (pageNumber - 1) * 10
        }
    );
    // log(response.toString());
    return response;
  }

  Future<Response> editProduct({required int id, required String name, required double price}) async {
    var response = await _dio.put("$_baseUrl/products/$id",
        options: Options(headers: DioHeaders.getHeaders()),
        data: {
      "title": name,
      "price": price
    });
    log(response.toString());
    return response;
  }

  ///Categories
  Future<Response> getCategories() async {
    var response = await _dio.get("$_baseUrl/categories", options: Options(headers: DioHeaders.getHeaders()),);
    return response;
  }

}
