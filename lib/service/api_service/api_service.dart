import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsarticle/constants/strings.dart';
import 'package:newsarticle/locator.dart';

class ApiService {
  static const String _baseUrl = "https://newsapi.org/";
  static const String _apiKey = "a5cc5825a5d948dabbd1108bde300142";

  static const _connectionTimeout = 130000;
  static const _receiveTimeout = 130000;
  String secretKey = "";

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(milliseconds: _connectionTimeout),
      receiveTimeout: const Duration(milliseconds: _receiveTimeout),
    ),
  );

  Future<Map<String, dynamic>> get(
    String path,
    dynamic body, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Options options = Options(
        headers: {"content-type": "application/json"},
        responseType: ResponseType.plain,
        contentType: 'application/json',
      );
      queryParams?["apiKey"] = _apiKey;
      Response response = await _dio.get(_baseUrl + path,
          data: body, options: options, queryParameters: queryParams);

      Map<String, dynamic> valueMap = {};
      valueMap = jsonDecode(response.data);
      return valueMap;
    } on DioException catch (e) {
      handleError(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> post(
    String path,
    dynamic body, {
    Map<String, dynamic>? queryParams,
    BuildContext? context,
  }) async {
    try {
      Options options = Options(
        headers: {"content-type": "application/json"},
        responseType: ResponseType.plain,
        contentType: 'application/json',
      );

      Response response = await _dio.post(_baseUrl + path,
          data: body, options: options, queryParameters: queryParams);

      Map<String, dynamic> valueMap = {};

      valueMap = response.data;
      kDebugMode && !kIsWeb
          ? debugPrint("value is : ${valueMap.toString()}")
          : null;
      return valueMap;
    } on DioException catch (e) {
      handleError(e);
      return {};
    }
  }

  handleError(DioException error) async {
    if (kDebugMode && !kIsWeb) {
      debugPrint("Response is ${(error.response ?? "")}");
      debugPrint("Error is $error");
    }
    if (error.response != null &&
        error.response!.statusCode != null &&
        error.response!.statusCode! >= 500) {
      dialogService.showDialogAlert(
          title: Strings.alert,
          content: Strings.internalServerError,
          cancelBtnText: Strings.close);
    } else if (error.message != null &&
        error.message!.isNotEmpty &&
        error.response != null &&
        error.response!.statusCode != 415) {
      dialogService.showDialogAlert(
          title: Strings.alert,
          content: error.message!,
          cancelBtnText: Strings.close);
    }
  }
}
