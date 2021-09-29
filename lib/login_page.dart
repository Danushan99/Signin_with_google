import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin/login_controler.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Obx(() {
          if (controller.googleAccount.value == null)
            return buildLoginButton();
          else
            return buildProfileView();
        }),
      ),
    );
  }

  Column buildProfileView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(controller.googleAccount.value?.photoUrl ?? '')
                  .image,
          radius: 70,
        ),
        Text(
          controller.googleAccount.value?.displayName ?? '',
          style: Get.textTheme.headline4,
        ),
        Text(
          controller.googleAccount.value?.email ?? '',
          style: Get.textTheme.headline5,
        ),
        SizedBox(
          height: 80,
        ),
        ActionChip(
            avatar: Icon(Icons.logout_rounded),
            label: Text('Logout'),
            onPressed: () {
              controller.logout();
            })
      ],
    );
  }

  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        controller.login();
      },
      label: Text('Sign in with Google'),
      icon: Image.asset(
        'asset/g-logo.png',
        height: 32,
        width: 32,
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }
}
