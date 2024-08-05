import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/di/di.dart' as di;
import 'package:food_app/features/food/presentation/bloc/food_bloc.dart';
import 'package:food_app/features/food/presentation/pages/favorites_food_page.dart';
import 'package:food_app/features/food/presentation/pages/food_detail_page.dart';
import 'package:food_app/features/food/presentation/pages/food_list_page.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoodBloc>(
          create: (context) => di.sl<FoodBloc>()..add(GetFoodListEvent()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(child: child, state: state);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => FoodListPage(),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => FavoriteFoodPage(),
        ),
        GoRoute(
          path: '/detail/:id',
          builder: (context, state) => FoodDetailPage(id: state.params['id']!),
        ),
      ],
    ),
  ],
);

class MainPage extends StatefulWidget {
  final Widget child;
  final GoRouterState state;
  MainPage({required this.child, required this.state});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          context.go('/');
          break;
        case 1:
          context.go('/favorites');
          break;
      }
    });
  }

  bool _isBottomNavBarVisible(GoRouterState state) {
    final path = state.location;
    if (path.startsWith('/detail/')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _isBottomNavBarVisible(widget.state)
          ? BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Food List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      )
          : null,
    );
  }
}
