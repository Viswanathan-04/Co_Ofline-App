import 'dart:typed_data';

class Product {
  String productName;
  String productImageLink;
  Map<String, dynamic> sizeVariant;
  String subCategory;
  bool inStock;
  bool isVeg;
  int max_qty;
  int min_price;

  Product({
    required this.productName,
    required this.sizeVariant,
    required this.productImageLink,
    required this.subCategory,
    required this.inStock,
    required this.isVeg,
    required this.max_qty,
    required this.min_price,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_name': productName,
      'sizeVariant': sizeVariant,
      'sub_category': subCategory,
      'inStock': inStock,
      'isVeg' : isVeg,
      'productImageLink': productImageLink,
      'min_price': min_price,
      'max_qty' : max_qty
    };
  }
}
class FetchProductParams {
  final String shopId;
  final String productId;
  FetchProductParams(this.shopId, this.productId);
}
class UpdateProductParams {
  final String shopId;
  final String productId;
  final Product product;
  UpdateProductParams(this.shopId, this.productId, this.product);
}