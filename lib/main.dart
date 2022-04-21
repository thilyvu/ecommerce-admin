import 'package:ecommerce_admin/screens/home_screen.dart';
import 'package:ecommerce_admin/screens/new_product_screen.dart';
import 'package:ecommerce_admin/screens/orders_screen.dart';
import 'package:ecommerce_admin/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My ecommerce Backend',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const HomeScreen(),
      getPages :[
        GetPage(name: '/products', page: ()=>  ProductScreen()),
        GetPage(name: '/orders', page: ()=>  OrderScreen()),
        GetPage(name: '/products/new', page: ()=>  NewProductScreen())
      ]
    );
  }
}
