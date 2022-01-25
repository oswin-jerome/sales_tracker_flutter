import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_track/controllers/brand_controller.dart';
import 'package:sales_track/controllers/category_controller.dart';
import 'package:sales_track/models/brand.dart';
import 'package:sales_track/models/category.dart';

class CategoryPage extends StatelessWidget {
  late CategoryController controller;
  CategoryPage({Key? key}) {
    controller = Get.put(CategoryController());
    controller.categoryList.value = [];
    controller.currentPage.value = 1;
    controller.getAllCategories();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        controller.currentPage++;
        controller.getAllCategories();
      }
    });
  }
  static const String routeName = '/categories';
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String name = "";

          Get.bottomSheet(Container(
              height: 300,
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'New Category',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Category Name',
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 26)),
                      onPressed: () {
                        print(name);
                        Category category = Category(name: name);

                        controller.createACategory(category);
                        Get.back();
                      },
                      child: const Text("Add")),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              )));
        },
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                  controller: _controller,
                  itemCount: controller.categoryList.length,
                  itemBuilder: (bc, i) {
                    Category category = controller.categoryList[i];
                    return ListTile(
                      onLongPress: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (bc) {
                              return Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(15),
                                height: 200,
                                child: Center(
                                  child: ElevatedButton(
                                    child: Text("Delete"),
                                    onPressed: () {
                                      controller.deleteCategory(category);
                                      Get.back();
                                    },
                                  ),
                                ),
                              );
                            });
                      },
                      onTap: () {
                        Get.toNamed('/categories/details');
                      },
                      title: Text(category.name),
                      // trailing: Text('$i'),
                      subtitle: Text(category.createdAt.toString()),
                    );
                  });
            }),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const SizedBox(
                height: 80,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
            return Container();
          })
        ],
      ),
    );
  }
}
