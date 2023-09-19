import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tech_task/features/recipe/data/api_service/recipes_service.dart';
Logger logger = Logger(printer: PrettyPrinter(lineLength: 100000));

class RecipesRepository {
  late RecipesService _client;
  final _dio = Dio();
  static const baseUrl = 'https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev';

  UbxRepository() {
    _dio.options = BaseOptions(validateStatus: (val) => true);
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        error: false,
      ));
    }
    _client = RecipesService(_dio, baseUrl: baseUrl);
  }

  Future<Map<String, dynamic>> getIngredients() async {
    return ErrorHandler.networkErrorHandler(() {
      return _client.getIngredients();
    });
  }
}

mixin ErrorHandler {
  static Future<Map<String, dynamic>> networkErrorHandler(
      Function functions) async {
    try {
      final res = await functions() as HttpResponse<dynamic>?;

      if (responseIsOk(res?.response.statusCode ?? 401)) {
        return res?.response.data as Map<String, dynamic>;
      } else if ((res?.response.statusCode ?? 401) == 401) {
        return {
          'status': 401,
          'message': 'Unauthorized',
          'errorData': res?.response.data
        };
      } else if ((res?.response.statusCode ?? 400) == 400) {
        return {
          'status': 400,
          'message': 'Bad request',
          'errorData': res?.response.data
        };
      } else {
        return {
          'status': 401,
          'message': 'Unauthorized',
          'errorData': res?.response.data
        };
      }
    } on SocketException catch (e) {
      logger.d(e.toString());
      rethrow;
    } on FormatException catch (e) {
      logger.d(e.toString());
      rethrow;
    } catch (e) {
      logger.d(e.toString());
      rethrow;
    }
  }

  static bool responseIsOk(int statusCode) {
    if (((statusCode) >= 200 && (statusCode) <= 300) || (statusCode) == 400) {
      return true;
    } else {
      return false;
    }
  }
}
