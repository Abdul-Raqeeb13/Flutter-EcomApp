// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecomapp/Controller/AuthController.dart';
import 'package:ecomapp/Wdigets/Button.dart';
import 'package:ecomapp/Wdigets/Text.dart';
import 'package:ecomapp/Wdigets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var authController = Get.put(AuthController());
  bool passwordHidden = true; // State to manage password visibility

  void login() {
    if (_formKey.currentState!.validate()) {
      authController.loginUser(emailcontroller.text, passwordcontroller.text);
    }
  }

  // Email Validator
  String? emailValidator(String? value) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  // Password Validator

  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<AuthController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
              body: Column(
            children: [
              TextWidget(
                text: "Login",
                fontsize: 40.0,
                color: Colors.blue,
                fontFamily: "font1",
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                          controller: emailcontroller,
                          hintText: "Enter the email",
                          validator: emailValidator,
                          prefixIcon: Icons.email,
                          width: ScreenWidth * 10,
                          obscureText: false), // Email should not be obscured
                      TextFieldWidget(
                        controller: passwordcontroller,
                        hintText: "Enter the password",
                        prefixIcon: Icons.lock,
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordHidden = !passwordHidden;
                            });
                          },
                        ),
                        obscureText:
                            passwordHidden, // Dynamically toggle password visibility
                        width: ScreenWidth * 10,
                      )
                    ],
                  )),
              controller.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButtonWidget(
                      buttonText: "Login",
                      buttonwidth: ScreenWidth,
                      onPress: () {
                        login();
                      },
                    )
            ],
          )),
        );
      },
    );
  }
}
