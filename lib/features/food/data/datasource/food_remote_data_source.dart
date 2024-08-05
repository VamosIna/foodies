import 'package:dio/dio.dart';
import '../models/food_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class FoodRemoteDataSource {
  Future<List<FoodModel>> getFoodList();
}

class FoodRemoteDataSourceImpl implements FoodRemoteDataSource {
  final Dio client;

  FoodRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FoodModel>> getFoodList() async {
    try {
      final response = await client.get('search.php?s=');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['meals'];
        return data.map((item) => FoodModel.fromJson(item)).toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        print('403 Forbidden: Check API key or endpoint');
        throw ServerException();
      } else {
        rethrow;
      }
    }
  }
}
