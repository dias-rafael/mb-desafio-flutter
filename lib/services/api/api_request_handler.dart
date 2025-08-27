import 'dart:convert';
import 'dart:io';

import 'package:coinmarketcap/bootstraps/environment_config.dart';
import 'package:coinmarketcap/core/utils/text_utils.dart';
import 'package:coinmarketcap/services/api/api_method.dart';
import 'package:coinmarketcap/services/api/api_request_model.dart';
import 'package:coinmarketcap/services/api/api_response_handler.dart';
import 'package:coinmarketcap/services/api/api_response_model.dart';
import 'package:coinmarketcap/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiRequestHandler {
  final http.Client client;

  ApiRequestHandler({http.Client? client}) : client = client ?? http.Client();

  final _appConfiguration = DependencyService.resolve<EnvironmentConfig>();
  final _apiResponseHandler = DependencyService.resolve<ApiResponseHandler>();

  Future<ApiResponseModel> request(ApiRequestModel apiRequestData) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-CMC_PRO_API_KEY': _appConfiguration.apiKey,
    };

    if (apiRequestData.headers != null) {
      headers.addAll(apiRequestData.headers!);
    }

    String endpoint = apiRequestData.endpoint;
    if (apiRequestData.queryParameters != null) {
      endpoint += '?';
      apiRequestData.queryParameters!.forEach((key, value) {
        endpoint += '$key=$value&';
      });
      endpoint = endpoint.substring(0, endpoint.length - 1);
    }

    if (_appConfiguration.isDebug) {
      debugPrint(
        '\n*** REQUEST ***\nURL: $endpoint\nMETHOD: ${apiRequestData.apiMethod.name}\nHEADER: $headers\nBODY: ${formatJsonToString(jsonEncode(apiRequestData.body))}\n',
      );
    }

    switch (apiRequestData.apiMethod) {
      case ApiMethod.GET:
        return await _get(endpoint, headers: headers);
      case ApiMethod.POST:
        return await _post(
          endpoint,
          headers: headers,
          body: apiRequestData.body,
        );
      case ApiMethod.PUT:
        return await _put(
          endpoint,
          headers: headers,
          body: apiRequestData.body,
        );
      case ApiMethod.DELETE:
        return await _delete(
          endpoint,
          headers: headers,
          body: apiRequestData.body,
        );
    }
  }

  Future<ApiResponseModel> _get(
    String url, {
    Map<String, String>? headers,
  }) async {
    final response = await _makeRequest(
      client.get(_getUri(url), headers: headers),
    );
    return _apiResponseHandler.handleResponse(response);
  }

  Future<ApiResponseModel> _post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final response = await _makeRequest(
      client.post(_getUri(url), headers: headers, body: jsonEncode(body)),
    );
    return _apiResponseHandler.handleResponse(response);
  }

  Future<ApiResponseModel> _put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final response = await _makeRequest(
      client.put(_getUri(url), headers: headers, body: jsonEncode(body)),
    );
    return _apiResponseHandler.handleResponse(response);
  }

  Future<ApiResponseModel> _delete(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final response = await _makeRequest(
      client.delete(_getUri(url), headers: headers, body: jsonEncode(body)),
    );
    return _apiResponseHandler.handleResponse(response);
  }

  Uri _getUri(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.host.isEmpty || uri.path.isEmpty) {
      throw Exception(
        'API request error - Could not parse url provided to Uri',
      );
    }

    return uri;
  }

  Future<Response> _makeRequest(Future<Response> requestCallback) async {
    try {
      return await requestCallback.timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw Exception('API request error - Timeout');
        },
      );
    } on SocketException catch (e) {
      throw Exception('API request error - No connection: $e');
    } catch (e) {
      rethrow;
    }
  }
}
