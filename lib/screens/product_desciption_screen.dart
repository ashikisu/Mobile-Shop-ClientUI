import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_client/screens/payment_screen.dart';

import '../model/product/product.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    Product  product=Get.arguments['data'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product Details',style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(product.image?? '',
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200,

                  ),

            ),
            const SizedBox(height: 20,),
             Text(product.name??'',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 20,),
             Text(product.description??'',
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              
            ),),

            const SizedBox(height: 20,),

            Text('BDT:${product.price??""}',
              style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),),

            const SizedBox(height: 20,),
            TextField(
              maxLines: 3,
              decoration:InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Enter Shipping Address',
              ) ,

            ),
            const SizedBox(
              height: 20,
            ),

            Center(
              child: ElevatedButton(onPressed: (){
                Get.to(const PaymentScreen());
              },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 135),
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text('Buy Now',style: TextStyle(color: Colors.white),)
              ),
            )


          ],
        ),
      ),
    );
  }
}
