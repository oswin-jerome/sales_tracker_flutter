import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:sales_track/pages/brand_details_page.dart';
import 'package:sales_track/pages/brand_page.dart';
import 'package:sales_track/pages/category_page.dart';
import 'package:sales_track/pages/home_page.dart';
import 'package:sales_track/pages/login_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('data_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/': (BuildContext context) => const HomePage(),
        '/login': (BuildContext context) => LoginPage(),
        '/brands': (BuildContext context) => BrandPage(),
        '/brands/details': (BuildContext context) => const BrandDetailsPage(),
        '/categories': (BuildContext context) => CategoryPage(),
      },
    );
  }
}
