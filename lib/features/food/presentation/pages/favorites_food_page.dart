import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/food_bloc.dart';
import 'package:go_router/go_router.dart';
import 'food_detail_page.dart';

class FavoriteFoodPage extends StatefulWidget {
  @override
  State<FavoriteFoodPage> createState() => _FavoriteFoodPageState();
}

class _FavoriteFoodPageState extends State<FavoriteFoodPage> {
  @override
  Widget build(BuildContext context) {
    final foodBloc = BlocProvider.of<FoodBloc>(context);
    foodBloc.add(GetFavoriteFoodsEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Foods'),
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FavoriteFoodLoaded) {
            return ListView.builder(
              itemCount: state.foods.length,
              itemBuilder: (context, index) {
                final food = state.foods[index];
                return ListTile(
                  title: Text(food.strMeal),
                  leading: Image.network(food.strMealThumb),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      foodBloc.add(RemoveFavoriteFoodEvent(food.idMeal));
                    },
                  ),
                  onTap: () {
                    context.push('/detail/${food.idMeal}');

                  },
                );
              },
            );
          } else if (state is FoodError) {
            return Center(child: Text(state.message));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
