import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_track/pages/brand_page.dart';
import 'package:sales_track/pages/category_page.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(""),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.branding_watermark),
            title: Text('Brands'),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(BrandPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(CategoryPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.production_quantity_limits_sharp),
            title: Text('Products'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
