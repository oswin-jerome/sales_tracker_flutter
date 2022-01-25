import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sales_track/utils/api_helper.dart';

class LoginController extends GetxController {
  LoginController() {
    if (isLoggedIn()) {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        Get.offAllNamed("/");
      });
    }
  }

  var dataBox = Hive.box("data_box");
  var userData = {}.obs;
  void login({String? email, String? password}) {
    ApiHelper().dio?.post("/v1/login",
        data: {"email": email, "password": password}, options: Options(
      validateStatus: (status) {
        return status! < 500;
      },
    )).then((value) {
      if (value.statusCode == 200) {
        Get.offAllNamed("/");
        dataBox.put("token", value.data["token"]);
        dataBox.put("user", value.data["user"]);
        userData.value = value.data['user'];
      } else if (value.statusCode == 401) {
        Get.snackbar("Error", "Invalid Credentials");
      }
    });
  }

  bool isLoggedIn() {
    return dataBox.get("token") != null;
  }
}
