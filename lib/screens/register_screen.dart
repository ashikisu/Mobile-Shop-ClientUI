
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_client/controller/login_controller.dart';
import 'package:mobile_shop_client/screens/login_screen.dart';
import 'package:mobile_shop_client/widgets/otp_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
            const Text("Create an Account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.purple,
              ),

            ),
            const SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.text,
              controller: control.registerNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.man),
                  labelText: "Your Name",
                  hintText: 'Enter Your Name'
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.phone,
              controller: control.registerNumberController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                  labelText: "Phone Number",
                  hintText: 'Enter Your Phone Number'
              ),
            ),
            const SizedBox(height: 20,),
            OtpTextField(otpController: control.otpController,visible: control.otpFieldShown, onComplete: (otp ) {
              control.otpEnter= int.tryParse(otp?? '0000');
            },),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              if(control.otpFieldShown){
                control.addUser();

              }else{
                control.senOtp();
              }
            },
              child:  Text(control.otpFieldShown?  'Register':'Send OTP',

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple,
              ),
            ),
            TextButton(onPressed: () {
              Get.to(const LoginScreen());
            },
                child: const Text('Already Have account? Login Now',
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
