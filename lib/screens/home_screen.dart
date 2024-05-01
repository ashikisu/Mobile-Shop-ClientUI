import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_shop_client/controller/home_controller.dart';
import 'package:mobile_shop_client/screens/login_screen.dart';
import 'package:mobile_shop_client/screens/product_desciption_screen.dart';
import 'package:mobile_shop_client/widgets/drop_down_button.dart';
import 'package:mobile_shop_client/widgets/multi_select_drop_down_button.dart';
import 'package:mobile_shop_client/widgets/product_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (control) {
      return RefreshIndicator(
        onRefresh: () async{
          control.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Mobile Shop', style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {
                GetStorage box = GetStorage();
                box.erase();
                Get.offAll(const LoginScreen());
              }, icon: const Icon(Icons.logout)),
            ],
          ),

          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: control.productCategories.length,

                    itemBuilder: (context, index) {
                      return   InkWell(
                        onTap: (){
                          control.filterByCategory(control.productCategories[index].name?? '');
                        },
                        child: Padding(
                            padding:  const EdgeInsets.all(8.0),
                            child: Chip(label: Text(control.productCategories[index].name?? 'Error')),
                        ),
                      );
                    }
                ),

              ),
              Row(
                children: [
                  Flexible(
                    child: DropDownBtn(
                      items: const ['Low to High', 'High to Low'],
                      selectedItemText: 'Sort',
                      onSelected: (selected) {
                       control.sortByPrice(selected=='Low to High'? true:false);
                      },

                    ),
                  ),
                  Flexible(
                      child: MultiSelectDropDownBtn(items: const ['Oppo', 'vivo','Apple'],
                        onSelectChanged: (selectedItems) {},)


                  ),

                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8

                    ),
                    itemCount: control.productShowUi.length,
                    itemBuilder: (context, index) {
                      return ProductCurd(
                        name:control.productShowUi[index].name?? 'No Name',
                        price: control.productShowUi[index].price?? 00,
                        imageUrl: control.productShowUi[index].image?? 'url',
                        offertag: '20% off',
                        onTap: () {
                          // Navigate from current page (context) to a new page (NewPage)
                          Get.to(const ProductDescription(),arguments: {'data':control.productShowUi[index]});
                        },);
                    }
                ),
              ),

            ],
          ),

        ),
      );
    });
  }
}
