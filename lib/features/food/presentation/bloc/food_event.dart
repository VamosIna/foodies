part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class GetFoodListEvent extends FoodEvent {}

class GetFavoriteFoodsEvent extends FoodEvent {}

class AddFavoriteFoodEvent extends FoodEvent {
  final Food food;

  AddFavoriteFoodEvent(this.food);

  @override
  List<Object> get props => [food];
}

class RemoveFavoriteFoodEvent extends FoodEvent {
  final String id;

  RemoveFavoriteFoodEvent(this.id);

  @override
  List<Object> get props => [id];
}
