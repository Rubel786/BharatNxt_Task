import 'package:bharat_nxt_task/utils/wishlist_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'configure/routes.dart';
import 'configure/theme.dart';
import 'home/viewmodel/product_card_view_model.dart';
import 'login/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductCardViewModel()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bharat Next Task',
        theme: AppTheme.lightTheme(context),
        initialRoute: LoginScreen.routeName,
        routes: routes,
      ),
    );
  }
}
