
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout',
        style: TextStyle(),),
        centerTitle: true,
        backgroundColor:Colors.pink,
        foregroundColor: Colors.white,
      ),
    );
  }
}
