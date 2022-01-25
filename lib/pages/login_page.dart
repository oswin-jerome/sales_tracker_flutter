import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_track/controllers/login_controller.dart';
import 'package:sales_track/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const String routeName = '/login';
  String _email = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const SizedBox(height: 26),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              onChanged: (value) {
                _email = value;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              onChanged: (value) {
                _password = value;
              },
              decoration: const InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 26),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushReplacementNamed(context, "/");
                loginController.login(
                  email: _email,
                  password: _password,
                );
              },
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
