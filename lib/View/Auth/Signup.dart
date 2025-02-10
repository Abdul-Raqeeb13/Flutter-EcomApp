// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:ecomapp/Controller/AuthController.dart';
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

  // controllers for different fields
  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  // for key for from vlaidation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // get the authcontroller cimplete class with its methods defin in Controller/Auth/ 
  var authController = Get.put(AuthController());

  // hanle the passowrd show or not
  bool passwordHidden = true;  // State to manage password visibility

  // signup function call authcontroller signup function for firebase
  void signUp() {
    if (_formKey.currentState!.validate()) {
      authController.signUpUser(nameController.text, emailcontroller.text, passwordcontroller.text);
    }
  }

  // snackbar message popup method
  

  // name Validator
  String? nameValidator(String? value) {
    if (value!.trim() == null || value.trim().isEmpty) {
      return "Name is required";
    } 
    return null;
  }

  // email validator
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
  String? passwordValidator(String? value) {
    RegExp passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else if (!passwordRegex.hasMatch(value)) {
      return "Password use A-Z, a-z, 0-9 & a special character.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    
    // get the width of the current opening screen
    final ScreenWidth = MediaQuery.of(context).size.width;

    // get the real time data of the authcontroller inside controller all the thins are store od authcontrooler
    return GetBuilder<AuthController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
              body: Column(
            children: [
              // textwidget
              TextWidget(
                text: "Signup",
                fontsize: 40.0,
                color: Colors.red,
                fontFamily: "font1",
              ),

              // singuo form 
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // form field widgets
                       TextFieldWidget(
                          controller: nameController,
                          hintText: "Enter the NAME",
                          validator: nameValidator,
                          prefixIcon: Icons.account_circle,
                          width: ScreenWidth * 10,
                          obscureText: false), 
                      TextFieldWidget(
                          controller: emailcontroller,
                          hintText: "Enter the email",
                          validator: emailValidator,
                          prefixIcon: Icons.email_rounded,
                          width: ScreenWidth * 10,
                          obscureText: false),  // Email should not be obscured
                      TextFieldWidget(
                        controller: passwordcontroller,
                        hintText: "Enter the password",
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
                        obscureText: passwordHidden,  // Dynamically toggle password visibility
                        width: ScreenWidth * 10,
                      )
                    ],
                  )),

              // acces the authcontroller class method .is loading custome method define in authcontrooler class
              controller.isLoading ? CircularProgressIndicator() : 
             // Button widget
              ElevatedButtonWidget(
                buttonText: "Signup",
                buttonwidth: ScreenWidth,
                onPress: () {
                  signUp();
                },
              )
            ],
          )),
        );
      },
    );
  }
}
