// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecomapp/Controller/AuthController.dart';
import 'package:ecomapp/View/Auth/Signup.dart';
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
  bool passwordHidden = true;

  void login() {
    if (_formKey.currentState!.validate()) {
      authController.loginUser(emailcontroller.text, passwordcontroller.text);
    }
  }

  String? emailValidator(String? value) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return GetBuilder<AuthController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    'https://img.freepik.com/premium-psd/close-up-italian-food-ingredients-with-logo_23-2148283461.jpg?ga=GA1.1.881659082.1730823737',
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  TextWidget(
                    text: "Login",
                    fontsize: 40.0,
                    color: Colors.blue,
                    fontFamily: "font1",
                  ),
                  SizedBox(height: 20),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          controller: emailcontroller,
                          hintText: "Enter the email",
                          validator: emailValidator,
                          prefixIcon: Icons.email,
                          width: screenWidth * 0.9,
                          obscureText: false,
                        ),
                        TextFieldWidget(
                          // enableInteractiveSelective = false used to prevent copy password
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
                          obscureText: passwordHidden,
                          width: screenWidth * 0.9,
                        ),
                        controller.isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButtonWidget(
                                buttonText: "Login",
                                buttonwidth: screenWidth * 0.9,
                                onPress: login,
                              ),
                  SizedBox(height: 10),

                        GestureDetector(
                          onTap: () {
                            Get.to(Signup());
                          },
                          child: Text(
                            "Don't have an account? Sign up",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
