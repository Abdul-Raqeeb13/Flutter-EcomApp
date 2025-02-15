// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecomapp/Controller/AuthController.dart';
import 'package:ecomapp/View/Auth/Login.dart';
import 'package:ecomapp/Wdigets/Button.dart';
import 'package:ecomapp/Wdigets/Text.dart';
import 'package:ecomapp/Wdigets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var authController = Get.put(AuthController());
  bool passwordHidden = true;

  void signUp() {
    if (_formKey.currentState!.validate()) {
      authController.signUpUser(nameController.text, emailcontroller.text, passwordcontroller.text);
    }
  }

  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    return null;
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

  String? passwordValidator(String? value) {
    RegExp passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else if (!passwordRegex.hasMatch(value)) {
      return "Password must contain A-Z, a-z, 0-9 & a special character.";
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
                    'https://img.freepik.com/premium-psd/top-view-italian-food-ingredients-with-logo_23-2148283460.jpg?ga=GA1.1.881659082.1730823737',
                    height: 230,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  TextWidget(
                    text: "Signup",
                    fontsize: 40.0,
                    color: Colors.blue,
                    fontFamily: "font1",
                  ),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          controller: nameController,
                          hintText: "Enter your name",
                          validator: nameValidator,
                          prefixIcon: Icons.person,
                          width: screenWidth * 0.9,
                          obscureText: false,
                        ),
                        TextFieldWidget(
                          controller: emailcontroller,
                          hintText: "Enter your email",
                          validator: emailValidator,
                          prefixIcon: Icons.email,
                          width: screenWidth * 0.9,
                          obscureText: false,
                        ),
                        TextFieldWidget(
                          controller: passwordcontroller,
                          hintText: "Enter your password",
                          prefixIcon: Icons.lock,
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordHidden ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordHidden = !passwordHidden;
                              });
                            },
                          ),
                          validator: passwordValidator,
                          obscureText: passwordHidden,
                          width: screenWidth * 0.9,
                        ),
                        controller.isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButtonWidget(
                                buttonText: "Signup",
                                buttonwidth: screenWidth * 0.9,
                                onPress: signUp,
                              ),
                        GestureDetector(
                          onTap: () {
                            Get.to(Login());
                          },
                          child: Text(
                            "Already have an account? Login",
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
