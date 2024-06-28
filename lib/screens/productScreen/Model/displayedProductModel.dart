import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ProductModel {
  final String id;
  final String product_name;
  final String product_image;
  final Map<String, dynamic> sizeVariants;
  final bool inStock;
  final bool isVeg;
  final int min_price;
  final String sub_category;

  ProductModel({required this.id,
    required this.product_name,
    required this.product_image,
    required this.sizeVariants,
    required this.inStock,
    required this.isVeg,
    required this.min_price,
    required this.sub_category});

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
        id: doc.id,
        product_name: data['product_name'],
        product_image: data['productImageLink'],
        sizeVariants: data['sizeVariant'],
        inStock: data['inStock'],
        isVeg: data['isVeg'],
        min_price: data['min_price'],
        sub_category: data['sub_category']
    );
  }
  final searchTextProvider = StateProvider<String>((ref) => '');
}
class UpdateStockParams {
  final String shopId;
  final String productId;
  final bool status;
  UpdateStockParams(this.shopId, this.productId, this.status);
}