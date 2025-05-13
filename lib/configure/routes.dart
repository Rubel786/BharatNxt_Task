import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../favourite/view/favourite_screen.dart';
import '../home/view/home_screen.dart';
import '../init_screen.dart';
import '../login/view/login_screen.dart';
import '../product_detail/view/product_detail_screen.dart';
import '../profile/view/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  FavouriteScreen.routeName: (context) => FavouriteScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ProductDetailScreen.routeName: (context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;
    return ProductDetailScreen(productId: args);
  },


};
