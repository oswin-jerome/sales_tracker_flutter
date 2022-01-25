import 'dart:convert';

import 'package:get/get.dart';
import 'package:sales_track/models/brand.dart';
import 'package:sales_track/utils/api_helper.dart';

class BrandController extends GetxController {
  // var brand = Brand.obs;
  var brandList = [].obs;
  var lastPage = 1.obs;
  var currentPage = 1.obs;
  var isLoading = false.obs;
  void getAllBrands() {
    isLoading.value = true;
    ApiHelper().dio?.get("/v1/brands?page=${currentPage.value}").then((value) {
      currentPage.value = value.data["current_page"];
      lastPage.value = value.data["last_page"];
      if (currentPage.value == 1) {
        brandList.value = brandFromJson(jsonEncode(value.data["data"]));
      } else {
        brandList.addAll(brandFromJson(jsonEncode(value.data["data"])));
      }
      isLoading.value = false;
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void createABrand(Brand brand) {
    ApiHelper().dio?.post("/v1/brands", data: brand.toJson()).then((value) {
      getAllBrands();
    });
  }

  void deleteBrand(Brand brand) {
    ApiHelper().dio?.delete("/v1/brands/${brand.id}").then((value) {
      getAllBrands();
    });
  }
}
