import 'dart:io';

import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  final String screenName;
  const UploadImageScreen({required this.screenName, Key? key})
      : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  AuthController authController = Get.put(AuthController());
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? downloadURL;

  Future imagePickerMethod() async {
    final pick = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        selectedImage = File(pick.path);
      } else {
        showSnackBar("No file selector", Duration(milliseconds: 400));
      }
    });
  }

  Future uploadImage() async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('teachers')
        .child(authController.myUser.value.uid ?? "")
        .child(widget.screenName)
        .child("post_$postID");
    await ref.putFile(selectedImage!);
    downloadURL = await ref.getDownloadURL();
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload image for ${widget.screenName}",
          style: const TextStyle(color: kTextWhiteColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kTopBorderRadius,
                color: kOtherColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                    height: 550,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Text('Upload'),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                              width: 350,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.blue)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: selectedImage == null
                                            ? const Center(
                                                child:
                                                    Text('No image selected'))
                                            : Image.file(selectedImage!)),
                                    ElevatedButton(
                                        onPressed: () {
                                          imagePickerMethod();
                                        },
                                        child: Text("Select Image")),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (selectedImage != null) {
                                            uploadImage().whenComplete(() =>
                                                showSnackBar(
                                                    "Image Uploaded Successfully",
                                                    Duration(seconds: 2)));
                                          } else {
                                            showSnackBar("No image selected",
                                                Duration(seconds: 2));
                                          }
                                        },
                                        child: Text("Upload Image")),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
