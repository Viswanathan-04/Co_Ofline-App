import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_ofline/screens/editShopScreen/Model/editShopModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';

final firestoreServiceProvider = Provider((ref) => FirestoreService());
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    try {
      Reference ref = _storage.ref(childName);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      //handle error
      print('Error uploading image:$e');
      throw Exception('Error uploading image');
    }
  }

  Future<void> updateShop(String shopId, ShopData shop) async
  {
    try {
      await FirebaseFirestore.instance
          .collection('Shop')
          .doc(shopId)
          .update(shop.toMap());
      print('Product updated successfully');
    } catch (e) {
      print('Error updating product: $e');
      throw e;
    }
  }

  Future<ShopData?> fetchShop(String shopId) async {
    print(shopId);
    final docSnapshot = await _db
        .collection('Shop')
        .doc(shopId)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null) {
        GeoPoint location = data["location"];
        return ShopData(
            shop_name: data['shop_name'],
            address: data['address'],
            shopImageLink: data['shopImageLink'],
            latitude: location.latitude,
            longitude: location.longitude,
            startingYear: data['startingYear'],
            shop_upi: data['shop_upi'],
            sub_category: List<String>.from(data['sub_category'])
        );
      }
    }
  }
}

final updateShopDetails = FutureProvider.family<void,UpdateShopParams>((ref, params) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.updateShop(params.shopId, params.shopData);
});

final fetchShopProvider = FutureProvider.family<ShopData?, String>((ref, shopId) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.fetchShop(shopId);
});