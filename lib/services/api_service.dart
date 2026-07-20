import 'package:dio/dio.dart';
import '../core/constants/app_constants.dart';
import '../core/constants/app_strings.dart';
import '../models/product_model.dart';

enum ApiFailureType { noInternet, timeout, server, unknown }

class ApiException implements Exception {
  const ApiException(this.message, this.type);

  final String message;
  final ApiFailureType type;

  @override
  String toString() => message;
}

class ApiService {
  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConstants.baseUrl,
                connectTimeout: AppConstants.connectTimeout,
                receiveTimeout: AppConstants.receiveTimeout,
              ),
            );

  final Dio _dio;

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await _dio.get(AppConstants.productsEndpoint);

      if (response.statusCode == null ||
          response.statusCode! < 200 ||
          response.statusCode! >= 300) {
        throw ApiException(
          AppStrings.serverErrorMessage,
          ApiFailureType.server,
        );
      }

      final data = response.data;
      if (data is! List) {
        throw ApiException(
          AppStrings.unknownErrorMessage,
          ApiFailureType.unknown,
        );
      }

      return List.generate(data.length, (index) {
        return ProductModel.fromJson(
          data[index] as Map<String, dynamic>,
          index,
        );
      });
    } on DioException catch (e) {
      throw _mapDioException(e);
    } on ApiException {
      rethrow;
    } catch (_) {
      throw ApiException(
        AppStrings.unknownErrorMessage,
        ApiFailureType.unknown,
      );
    }
  }

  ApiException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(AppStrings.timeoutMessage, ApiFailureType.timeout);
      case DioExceptionType.connectionError:
        return ApiException(
          AppStrings.noInternetMessage,
          ApiFailureType.noInternet,
        );
      case DioExceptionType.badResponse:
        return ApiException(
          AppStrings.serverErrorMessage,
          ApiFailureType.server,
        );
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return ApiException(
          AppStrings.unknownErrorMessage,
          ApiFailureType.unknown,
        );
      case DioExceptionType.transformTimeout:
        throw UnimplementedError();
    }
  }
}
