import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio);

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

