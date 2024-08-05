import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_app/features/food/presentation/pages/favorites_food_page.dart';
import 'package:food_app/features/food/presentation/pages/food_detail_page.dart';
import 'package:food_app/features/food/presentation/pages/food_list_page.dart';
import 'package:food_app/features/food/presentation/bloc/food_bloc.dart';
import 'package:food_app/core/di/di.dart' as di;
import 'package:food_app/main_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => di.sl<FoodBloc>()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => MainPage()),
    ChildRoute('/favorites', child: (_, __) => FavoriteFoodPage()),
    ChildRoute('/detail/:id', child: (_, args) => FoodDetailPage(id: args.params['id'])),
  ];
}
