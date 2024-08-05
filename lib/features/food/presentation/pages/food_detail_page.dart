import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/food_bloc.dart';
import '../../domain/entities/food.dart';

class FoodDetailPage extends StatelessWidget {
  final String id;

  FoodDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    final foodBloc = BlocProvider.of<FoodBloc>(context);

    return BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              if (state is FoodLoaded) {
                final food = state.foods.firstWhere((food) => food.idMeal == id);
                return food != null ? _buildFoodDetail(food, foodBloc) : Center(child: Text('Food not found'));
              } else if (state is FavoriteFoodLoaded) {
                final food = state.foods.firstWhere((food) => food.idMeal == id);
                return food != null ? _buildFoodDetail(food, foodBloc) : Center(child: Text('Food not found'));
              } else if (state is FoodError) {
                return Center(child: Text(state.message));
              }
              return Center(child: CircularProgressIndicator());
            });
  }

  Widget _buildFoodDetail(Food food, FoodBloc foodBloc) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Food Detail'),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                foodBloc.add(AddFavoriteFoodEvent(food));
              })],
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(food.strMealThumb),
            Text(food.strMeal, style: TextStyle(fontSize: 24)),
            Text('Category: ${food.strCategory}'),
            Text('Area: ${food.strArea}'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(food.strInstructions),
            ),
            ElevatedButton(
              onPressed: () {
                foodBloc.add(AddFavoriteFoodEvent(food));
              },
              child: Text('Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
