import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: 'https://www.themealdb.com/api/json/v1/1/',
      // connectTimeout: 5000,
      // receiveTimeout: 3000,
      headers: {
        'Content-Type': 'application/json',
        // If there's an API key, include it here
        // 'Authorization': 'Bearer YOUR_API_KEY'
      },
    );
  }

  Future<Response> get(String endpoint) async {
    try {
      return await dio.get(endpoint);
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        // Handle 403 Forbidden error
        print('403 Forbidden: Check API key or endpoint');
      }
      rethrow;
    }
  }
}
