import 'package:flutter/material.dart';

class ProductCurd extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;
  final String offertag;
  final Function onTap;
  const ProductCurd({super.key, required this.name, required this.imageUrl, required this.price, required this.offertag, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Image.network(imageUrl,
               fit: BoxFit.cover,
               width: double.maxFinite,
               height: 100,
             ),


             const SizedBox(height: 5,),
              Text  (name, style: TextStyle(
               fontSize: 16,
               overflow: TextOverflow.ellipsis,

             ),),

             const SizedBox(height: 9,),
              Text  ('Bdt:$price', style: TextStyle(
               fontSize: 16,
               overflow: TextOverflow.ellipsis,
             ),),
             const SizedBox(height: 5,),
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 8.0),
               decoration: BoxDecoration(
                 color: Colors.green,
                 borderRadius: BorderRadius.circular(4)
               ),
               child:  Text(
                 offertag,style: TextStyle(
                 color: Colors.white
               ),
               ),
             )
           ],
            ),
        ),
      ),
    );
  }
}
