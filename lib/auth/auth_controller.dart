import 'package:EduInfo/model/users_model/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  
  String userUid = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic cradentials;

  var isProfileUploading = false.obs;

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

}