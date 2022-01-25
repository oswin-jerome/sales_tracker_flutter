import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sales_track/pages/login_page.dart';

class ApiHelper {
  Dio? dio;
  ApiHelper() {
    var dataBox = Hive.box("data_box");
    String _token = dataBox.get("token") ?? "";
    BaseOptions options = BaseOptions(
      baseUrl: "http://192.168.1.170:8000/api",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);

    dio?.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (_token != null) {
        options.headers.addEntries([
          MapEntry("Authorization", "Bearer " + _token),
          const MapEntry("Accept", "application/json"),
          const MapEntry("Content-Type", "application/json"),
        ]);
      } else {
        options.headers.addEntries([
          // MapEntry("Authorization", "Bearer " + _token ?? ""),
          const MapEntry("Accept", "application/json"),
          const MapEntry("Content-Type", "application/json"),
        ]);
      }
      return handler.next(options);
    }, onError: (DioError err, handler) {
      if (err.response?.statusCode == 401) {
        dataBox.clear();
        // Get.off(LoginPage.routeName);
        return handler.next(err);
      }

      // if (err.response.statusCode >= 500) {
      //   print("Server errors");
      //   Get.snackbar("", "Something went wrong");
      //   print(err.response);
      //   return;
      // }

      return handler.next(err);
    }));
  }
}
