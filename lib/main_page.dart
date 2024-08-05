import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_app/features/food/presentation/bloc/food_bloc.dart';
import 'package:food_app/features/food/presentation/pages/favorites_food_page.dart';
import 'package:food_app/features/food/presentation/pages/food_detail_page.dart';
import 'package:food_app/features/food/presentation/pages/food_list_page.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final GoRouter _router = GoRouter(
    initialLocation: '/',
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
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _router.go('/');
          break;
        case 1:
          _router.go('/favorites');
          break;
      }
    });
  }

  bool _isBottomNavBarVisible() {
    final location = _router.location;
    return !location.startsWith('/detail/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
      ),
      bottomNavigationBar: _isBottomNavBarVisible()
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
