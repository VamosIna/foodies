import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_app/core/usecase/usecase.dart';
import 'package:food_app/features/food/domain/usecase/add_favorite_food.dart';
import 'package:food_app/features/food/domain/usecase/get_favorite_foods.dart';
import 'package:food_app/features/food/domain/usecase/get_food_list.dart';
import 'package:food_app/features/food/domain/usecase/remove_favorite_food.dart';
import '../../domain/entities/food.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetFoodList getFoodList;
  final GetFavoriteFoods getFavoriteFoods;
  final AddFavoriteFood addFavoriteFood;
  final RemoveFavoriteFood removeFavoriteFood;

  FoodBloc({
    required this.getFoodList,
    required this.getFavoriteFoods,
    required this.addFavoriteFood,
    required this.removeFavoriteFood,
  }) : super(FoodInitial()) {
    on<GetFoodListEvent>(_onGetFoodListEvent);
    on<GetFavoriteFoodsEvent>(_onGetFavoriteFoodsEvent);
    on<AddFavoriteFoodEvent>(_onAddFavoriteFoodEvent);
    on<RemoveFavoriteFoodEvent>(_onRemoveFavoriteFoodEvent);
  }

  Future<void> _onGetFoodListEvent(
      GetFoodListEvent event,
      Emitter<FoodState> emit,
      ) async {
    emit(FoodLoading());
    final failureOrFoods = await getFoodList(NoParams());
    failureOrFoods.fold(
          (failure) => emit(FoodError(message: 'Failed to load foods')),
          (foods) => emit(FoodLoaded(foods: foods)),
    );
  }

  Future<void> _onGetFavoriteFoodsEvent(
      GetFavoriteFoodsEvent event,
      Emitter<FoodState> emit,
      ) async {
    emit(FoodLoading());
    final failureOrFoods = await getFavoriteFoods(NoParams());
    failureOrFoods.fold(
          (failure) => emit(FoodError(message: 'Failed to load favorite foods')),
          (foods) => emit(FavoriteFoodLoaded(foods: foods)),
    );
  }

  Future<void> _onAddFavoriteFoodEvent(
      AddFavoriteFoodEvent event,
      Emitter<FoodState> emit,
      ) async {
    final failureOrSuccess = await addFavoriteFood(event.food);
    failureOrSuccess.fold(
          (failure) => emit(FoodError(message: 'Failed to add favorite food')),
          (_) => add(GetFavoriteFoodsEvent()),
    );
  }

  Future<void> _onRemoveFavoriteFoodEvent(
      RemoveFavoriteFoodEvent event,
      Emitter<FoodState> emit,
      ) async {
    final failureOrSuccess = await removeFavoriteFood(Params(id: event.id));
    failureOrSuccess.fold(
          (failure) => emit(FoodError(message: 'Failed to remove favorite food')),
          (_) => add(GetFavoriteFoodsEvent()),
    );
  }
}
