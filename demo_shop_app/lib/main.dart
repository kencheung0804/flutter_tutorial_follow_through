import 'package:demo_shop_app/providers/auth.dart';
import 'package:demo_shop_app/screens/auth_screen.dart';
import 'package:demo_shop_app/screens/edit_product_screen.dart';

import './screens/orders_screen.dart';

import './screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_detail_screen.dart';
import './providers/products.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'screens/user_products_screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProvider(create: (ctx) => Products()),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProvider(create: (ctx) => Orders()),
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                    title: 'MyShop',
                    theme: ThemeData(
                      primarySwatch: Colors.purple,
                      accentColor: Colors.deepOrange,
                      fontFamily: 'Lato',
                    ),
                    home: auth.isAuth ? ProductDetailScreen() : AuthScreen(),
                    routes: {
                      ProductDetailScreen.routeName: (ctx) =>
                          ProductDetailScreen(),
                      CartScreen.routeName: (ctx) => CartScreen(),
                      OrdersScreen.routeName: (ctx) => OrdersScreen(),
                      UserProductsScreen.routeName: (ctx) =>
                          UserProductsScreen(),
                      EditProductScreen.routeName: (ctx) => EditProductScreen()
                    })));
  }
}