import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_shop_client/controller/login_controller.dart';
import 'package:mobile_shop_client/screens/home_screen.dart';
import 'package:mobile_shop_client/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (control) {
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Welcome Back",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.purple,
                ),

              ),
              SizedBox(height: 20,),
              TextField(
                controller: control.loginNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: const Icon(Icons.phone),
                    labelText: "Phone Number",
                    hintText: 'Enter Your Phone Number'
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
              },
                child: const Text('Login'
                  ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                ),
              ),
              TextButton(onPressed: () {
                Get.to(const RegisterScreen());
              },
                  child: const Text('Not Have account? Register Now',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ))
            ],
          ),
        ),


      );
    });
  }
}
