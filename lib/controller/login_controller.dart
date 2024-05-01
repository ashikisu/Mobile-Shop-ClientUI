import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_shop_client/model/user.dart';
import 'package:mobile_shop_client/screens/home_screen.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:get_storage/get_storage.dart';


class LoginController extends GetxController{
  GetStorage box= GetStorage();
  FirebaseFirestore firestore= FirebaseFirestore.instance;
  late CollectionReference userCollection;
  TextEditingController registerNameController= TextEditingController();
  TextEditingController registerNumberController= TextEditingController();
  TextEditingController loginNumberController=TextEditingController();
  OtpFieldControllerV2 otpController= OtpFieldControllerV2();
  bool otpFieldShown= false;
  int? otpSend;
  int? otpEnter;
  User? loginUser;
  @override
  void onReady(){
    Map<String, dynamic>? user = box.read('loginUser');
    if(user!=null){
      loginUser=User.fromJson(user);
      Get.to(const HomeScreen());
    }
  }
   onInit()  {
    userCollection= firestore.collection('user');
    super.onInit();
  }

  addUser(){
    try {
      if (otpSend == otpEnter) {
        DocumentReference doc = userCollection.doc();
        User user = User(
          id: doc.id,
          name: registerNameController.text,
          number: int.parse(registerNumberController.text),

        );
        final userJson = user.toJson();
        doc.set(userJson);
        Get.snackbar(
            'Success', 'User Added Successfully', colorText: Colors.purple);
        registerNumberController.clear();
        otpController.clear();
      }

      else {
        Get.snackbar(
            'Error', 'Otp is incorrect', colorText: Colors.purple);
      }
    }






    catch (e) {
      Get.snackbar('Error',e.toString(), colorText:Colors.purple);
      print(e);
    }


  }
  senOtp(){



    try {
      if(registerNameController.text.isEmpty || registerNumberController.text.isEmpty){
        Get.snackbar('Error', 'Fill the form', colorText: Colors.red);
        return;
      }
      final random= Random();
      int otp= 1000+ random.nextInt(9000);
      print(otp);
      if(otp!=null){
            otpFieldShown=true;
            otpSend=otp;
            Get.snackbar('Success', 'Otp Send Successfully', colorText: Colors.green);
          }
          else{
            Get.snackbar('Error', 'Otp Not Send', colorText: Colors.green);


          }
    } catch (e) {
      print(e);
    }finally{
      update();
    }

  }
   Future<void> loginWithPhone() async{
    try {
      String phoneNumber= loginNumberController.text;
      if(phoneNumber.isNotEmpty){
        var querySnapShot= await userCollection.where('number',isEqualTo: int.tryParse(phoneNumber)).limit(1).get();
        if(querySnapShot.docs.isNotEmpty){
          var userDoc=querySnapShot.docs.first;
          var userData= userDoc.data() as Map<String,dynamic>;
          box.write('loginUser', userData);
          loginNumberController.clear();
          Get.to(const HomeScreen());
          Get.snackbar('Error','User Not Found,Please Register',colorText: Colors.red);
        }
      }
    } catch (e) {
      print('Failed to login');
      Get.snackbar('Error','Failed to login',colorText: Colors.red);


    }
   }

  }

