import 'dart:collection';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class ShopData
{
  String shop_name;
  String address;
  String shopImageLink;
  double latitude;
  double longitude;
  String startingYear;
  String shop_upi;
  List<String> sub_category;

  ShopData({
    required this.shop_name,
    required this.address,
    required this.shopImageLink,
    required this.latitude,
    required this.longitude,
    required this.startingYear,
    required this.shop_upi,
    required this.sub_category,
  });

  Map<String, dynamic> toMap() {
    return {
      'shop_name': shop_name,
      'address': address,
      'shopImageLink': shopImageLink,
      'location': GeoPoint(latitude, longitude),
      'startingYear': startingYear,
      'shop_upi': shop_upi,
      'sub_category' : sub_category
    };
  }
}

class UpdateShopParams
{
  String shopId;
  ShopData shopData;
  UpdateShopParams({required this.shopId, required this.shopData});
}