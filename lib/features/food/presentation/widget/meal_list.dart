// import 'package:flutter/material.dart';
// import 'package:food_app/data/models/meal_model.dart';
// import 'package:food_app/domain/entities/meal.dart';
// import 'package:go_router/go_router.dart';
//
// class MealList extends StatelessWidget {
//   final List<MealModel> meals;
//
//   const MealList({Key? key, required this.meals}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: meals.length,
//       itemBuilder: (context, index) {
//         final meal = meals[index].meals![index];
//         return ListTile(
//           title: Text(meal.strMeal!),
//           leading: Image.network(meal.strImageSource!),
//           onTap: () {
//             context.push('/detail', extra: meal);
//           },
//         );
//       },
//     );
//   }
// }
