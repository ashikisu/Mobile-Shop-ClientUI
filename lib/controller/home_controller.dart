import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_client/model/product_category/product_category.dart';

import '../model/product/product.dart';

class HomeController extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productiveCollection;
  late CollectionReference categoryCollection;
  List<Product> products = [];
  List<Product> productShowUi = [];

  List<ProductCategory>productCategories = [];

  @override
  Future<void> onInit() async {
    productiveCollection = firestore.collection('Mobile Phone');
    categoryCollection = firestore.collection('category');
    await fetchCategory();
    await fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productiveCollection.get();
      final List<Product> retrievedProduct = productSnapshot.docs.map((doc) =>
          Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
      products.clear();
      products.assignAll(retrievedProduct);
      productShowUi.assignAll(products);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<ProductCategory> retrievedCategories = categorySnapshot.docs
          .map((doc) =>
          ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      productCategories.clear();
      productCategories.assignAll(retrievedCategories);
      Get.snackbar('Success', 'Fetched Successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    productShowUi.clear();
    productShowUi =
        products.where((product) => product.category == category).toList();
    update();
  }

  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      productShowUi = products;
    } else {
      List<String> loweCaseBrands = brands.map((brand) => brand.toLowerCase())
          .toList();
    }
    update();
  }

  sortByPrice(bool ascending) {
    List<Product> sortedProducts = List<Product>.from(productShowUi);
    sortedProducts.sort((a, b) =>
    ascending ? a.price!.compareTo(b.price!) : b.price!.compareTo(a.price!));
    productShowUi = sortedProducts;
    update();
  }
}