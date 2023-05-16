import 'dart:io';
import 'package:EduInfo/screens/home_screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;
import 'package:EduInfo/model/users_model/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  
  String userUid = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic cradentials;

  var isProfileUploading = false.obs;
  var isPaymentUploading = false.obs;

  // storeUserInfo(File selectedImage, String name, String home, String business, String shop) async {
  //   String url = await 
  // }

  bool isLoginAsTeacher = false;
  bool isLoginAsParent = false;
  
  var myUser = UsersModel().obs;

  getUserInfo() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).snapshots().listen((event) {
      myUser.value = UsersModel.fromJson(event.data()!);
    });
  }

  uploadImage(File image) async {
    String imageUrl = '';
    String fileName = Path.basename(image.path);
    var reference = FirebaseStorage.instance
        .ref()
        .child('users/$fileName'); // Modify this path/string as your need
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then(
      (value) {
        imageUrl = value;
        print("Download URL: $value");
      },
    );

    return imageUrl;
  }

  storeUserInfo(
    File? selectedImage,
    String firstName,
    String lastName,
    String birthDate,
    int number,
    // String home,
    // // String business,
    // String shop, 
    {
      String url = '',
      // LatLng? homeLatLng,
      // LatLng? businessLatLng,
      // LatLng? shoppingLatLng,
  }
  ) async {
    String url_new = url;
    if (selectedImage != null) {
      url_new = await uploadImage(selectedImage);
    }
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'image': url_new,
      'first name': firstName,
      'last name': lastName,
      'birth date': birthDate,
      'mobile': number,
      // 'home_address': home,
      // 'business_address': business,
      // 'shopping_address': shop,
      // 'home_latlng': GeoPoint(homeLatLng!.latitude, homeLatLng.longitude),
      // 'business_latlng':
      //     GeoPoint(businessLatLng!.latitude, businessLatLng.longitude),
      // 'shopping_latlng':
      //     GeoPoint(shoppingLatLng!.latitude, shoppingLatLng.longitude),
    },SetOptions(merge: true)).then((value) {
      isProfileUploading(false);
      //isLoading = false;

      Get.to(() => const HomeScreen());
    });
  }

  storePaymentInfo(
    String accountNo,
    String ifscCode,
    String recipientName,
    ) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'account no': accountNo,
      'ifsc code': ifscCode,
      'recipient name': recipientName,
    },SetOptions(merge: true)).then((value) {
      isPaymentUploading(false);

      Get.to(() => const HomeScreen());
    });
  }

}