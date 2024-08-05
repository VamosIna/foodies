part of 'food_bloc.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<Food> foods;

  FoodLoaded({required this.foods});

  @override
  List<Object> get props => [foods];
}

class FavoriteFoodLoaded extends FoodState {
  final List<Food> foods;

  FavoriteFoodLoaded({required this.foods});

  @override
  List<Object> get props => [foods];
}

class FoodError extends FoodState {
  final String message;

  FoodError({required this.message});

  @override
  List<Object> get props => [message];
}
