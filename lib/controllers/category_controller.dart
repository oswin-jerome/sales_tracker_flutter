import 'dart:convert';

import 'package:get/get.dart';
import 'package:sales_track/models/category.dart';
import 'package:sales_track/utils/api_helper.dart';

class CategoryController extends GetxController {
  // var brand = Brand.obs;
  var categoryList = [].obs;
  var lastPage = 1.obs;
  var currentPage = 1.obs;
  var isLoading = false.obs;
  void getAllCategories() {
    isLoading.value = true;
    ApiHelper()
        .dio
        ?.get("/v1/categories?page=${currentPage.value}")
        .then((value) {
      currentPage.value = value.data["current_page"];
      lastPage.value = value.data["last_page"];
      if (currentPage.value == 1) {
        categoryList.value = categoryFromJson(jsonEncode(value.data["data"]));
      } else {
        categoryList.addAll(categoryFromJson(jsonEncode(value.data["data"])));
      }
      isLoading.value = false;
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void createACategory(Category brand) {
    ApiHelper().dio?.post("/v1/categories", data: brand.toJson()).then((value) {
      getAllCategories();
    });
  }

  void deleteCategory(Category brand) {
    ApiHelper().dio?.delete("/v1/categories/${brand.id}").then((value) {
      getAllCategories();
    });
  }
}
