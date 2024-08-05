import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/food_bloc.dart';
import 'package:go_router/go_router.dart';

class FoodListPage extends StatefulWidget {
  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  @override
  void initState() {
    super.initState();
    // Initial load of food list
    context.read<FoodBloc>().add(GetFoodListEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodInitial) {
            // Meminta data detail
            context.read<FoodBloc>().add(GetFoodListEvent());
          }
          if (state is FoodLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FoodLoaded) {
            return ListView.builder(
              itemCount: state.foods.length,
              itemBuilder: (context, index) {
                final food = state.foods[index];
                return ListTile(
                  style: ListTileStyle.list,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text(food.strMeal),
                  leading: Image.network(food.strMealThumb),
                  onTap: () {
                    context.push('/detail/${food.idMeal}');
                  },
                );
              },
            );
          } else if (state is FoodError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
