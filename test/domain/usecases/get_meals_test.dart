// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:food_app/core/usecase/usecase.dart';
// import 'package:mockito/mockito.dart';
// import 'package:food_app/core/error/failures.dart';
//
// import '../../mocks.mocks.dart';
//
//
// void main() {
//   late GetMeals usecase;
//   late MockMealRepository mockMealRepository;
//
//   setUp(() {
//     mockMealRepository = MockMealRepository();
//     usecase = GetMeals(mockMealRepository);
//   });
//
//   final tMeals = [
//     Meal(
//       id: '52771',
//       name: 'Spicy Arrabiata Penne',
//       category: 'Vegetarian',
//       area: 'Italian',
//       instructions: 'Bring a large pot of water to a boil. ...',
//       imageUrl: 'https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg',
//       tags: 'Pasta,Curry',
//       youtube: 'https://www.youtube.com/watch?v=1IszT_guI08',
//       ingredients: ['penne rigate', 'olive oil', 'garlic', 'chopped tomatoes', 'red chilli flakes', 'italian seasoning', 'basil', 'Parmigiano-Reggiano'],
//       measures: ['1 pound', '1/4 cup', '3 cloves', '1 tin', '1/2 teaspoon', '1/2 teaspoon', '6 leaves', 'spinkling'],
//     ),
//   ];
//
//   test('should get list of meals from the repository', () async {
//     // arrange
//     when(mockMealRepository.getMeals())
//         .thenAnswer((_) async => Right(tMeals));
//
//     // act
//     final result = await usecase(NoParams());
//
//     // assert
//     expect(result, Right(tMeals));
//     verify(mockMealRepository.getMeals());
//     verifyNoMoreInteractions(mockMealRepository);
//   });
//
//   test('should return failure when repository fails', () async {
//     // arrange
//     when(mockMealRepository.getMeals())
//         .thenAnswer((_) async => Left(ServerFailure()));
//
//     // act
//     final result = await usecase(NoParams());
//
//     // assert
//     expect(result, Left(ServerFailure()));
//     verify(mockMealRepository.getMeals());
//     verifyNoMoreInteractions(mockMealRepository);
//   });
// }
