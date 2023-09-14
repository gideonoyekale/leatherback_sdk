import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leatherback_sdk/core/cores.dart';
import 'package:leatherback_sdk/models/leatherback_exception.dart';

class NetworkService {
  final String _apiKey;
  NetworkService(this._apiKey);

  Map<String, String> _buildHeaders() {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json; charset=utf-8",
      "X-API": _apiKey,
    };
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      uri.replace(queryParameters: queryParameters);
      Console.log('[LeatherbackSDK][PATH]', uri.toString());
      final http.Response res = await http.get(
        uri,
        headers: _buildHeaders(),
      );
      return handleResponse(res);
    } on HttpException catch (e) {
      handleError(e.message);
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Console.log('[LeatherbackSDK][PATH]', uri.toString());
      Console.log('[LeatherbackSDK][DATA]', body.toString());
      final http.Response res = await http.post(
        uri,
        headers: _buildHeaders(),
        body: jsonEncode(body),
      );
      return handleResponse(res);
    } on HttpException catch (e) {
      handleError(e.message);
    }
  }

  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(body.toString());
      final http.Response res = await http.put(
        uri,
        headers: _buildHeaders(),
        body: jsonEncode(body),
      );
      return handleResponse(res);
    } on HttpException catch (e) {
      handleError(e.message);
    }
  }

  Future<dynamic> patch(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(body.toString());
      final http.Response res = await http.patch(
        uri,
        headers: _buildHeaders(),
        body: jsonEncode(body),
      );
      return handleResponse(res);
    } on HttpException catch (e) {
      handleError(e.message);
    }
  }

  Future<dynamic> delete(
    String url, {
    dynamic body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(body.toString());
      final http.Response res = await http.delete(
        uri,
        headers: _buildHeaders(),
        body: jsonEncode(body),
      );
      return handleResponse(res);
    } on HttpException catch (e) {
      handleError(e.message);
    }
  }

  dynamic handleResponse(http.Response res) {
    final resBody = json.decode(utf8.decode(res.bodyBytes));
    Console.log('[LeatherbackSDK][RESPONSE]', resBody);
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (resBody['isSuccess'] ?? true) {
        return resBody;
      } else {
        throw LeatherbackException.fromHttp(resBody);
      }
    } else {
      throw LeatherbackException.fromHttp(resBody);
    }
  }

  void handleError(String message) {
    Console.log('[LeatherbackSDK][ERROR]', message);
    throw message;
  }

  logoutUser() async {}
}
