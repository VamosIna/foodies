import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/core/usecase/usecase.dart';
import 'package:food_app/features/food/domain/entities/food.dart';
import 'package:food_app/features/food/domain/repositories/food_repository.dart';
import 'package:food_app/features/food/domain/usecase/get_food_list.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockFoodRepository extends Mock implements FoodRepository {}

void main() {
  late GetFoodList usecase;
  late MockFoodRepository mockFoodRepository;

  setUp(() {
    mockFoodRepository = MockFoodRepository();
    usecase = GetFoodList(mockFoodRepository);
  });

  final List<Food> foodList = [];

  test('should get list of food from the repository', () async {
    when(mockFoodRepository.getFoodList())
        .thenAnswer((_) async => Right(foodList));

    final result = await usecase(NoParams());

    expect(result, Right(foodList));
    verify(mockFoodRepository.getFoodList());
    verifyNoMoreInteractions(mockFoodRepository);
  });
}