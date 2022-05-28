import 'package:ecommerce_admin/screens/screen.dart';
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
      title: 'My ecommerce admin',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const HomeScreen(),
      getPages :[
        GetPage(name: '/products', page: ()=>  ProductScreen()),
        GetPage(name: '/orders', page: ()=>  OrderScreen()),
        GetPage(name: '/categories', page: ()=>  CategoryScreen()),
        GetPage(name: '/products/new', page: ()=>  NewProductScreen()),
        GetPage(name: '/categories/new', page: ()=>  NewCategoryScreen())
      ]
    );
  }
}
