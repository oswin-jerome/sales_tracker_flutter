import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_track/controllers/brand_controller.dart';
import 'package:sales_track/models/brand.dart';

class BrandPage extends StatelessWidget {
  late BrandController controller;
  BrandPage({Key? key}) {
    controller = Get.put(BrandController());
    controller.brandList.value = [];
    controller.currentPage.value = 1;
    controller.getAllBrands();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        controller.currentPage++;
        controller.getAllBrands();
      }
    });
  }
  static const String routeName = '/brands';
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brands'),
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
                          'New Brand',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Brand Name',
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
                        Brand brand = Brand(name: name);

                        controller.createABrand(brand);
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
                  itemCount: controller.brandList.length,
                  itemBuilder: (bc, i) {
                    Brand brand = controller.brandList[i];
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
                                      controller.deleteBrand(brand);
                                      Get.back();
                                    },
                                  ),
                                ),
                              );
                            });
                      },
                      onTap: () {
                        Get.toNamed('/brands/details');
                      },
                      title: Text(brand.name),
                      // trailing: Text('$i'),
                      subtitle: Text(brand.createdAt.toString()),
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
