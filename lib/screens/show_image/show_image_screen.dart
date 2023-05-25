import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/constants.dart';
import 'package:EduInfo/screens/upload%20image/upload_image_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class showImageScreen extends StatefulWidget {
  final String screenName;
  const showImageScreen({required this.screenName, Key? key}) : super(key: key);

  @override
  State<showImageScreen> createState() => _showImageScreenState();
}

class _showImageScreenState extends State<showImageScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalize(widget.screenName),
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
                padding: EdgeInsets.fromLTRB(0, 18, 0, 10),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(authController.myUser.value.tuid ?? authController.myUser.value.uid)
                        .collection("images").where("postType", isEqualTo: widget.screenName)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("something is wrong");
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text("No Images"),
                        );
                      }
                      return PhotoViewGallery.builder(
                        itemCount: snapshot.data!.docs.length,
                        builder: (context, index) {
                          return PhotoViewGalleryPageOptions(
                            basePosition: Alignment.center,
                            imageProvider: NetworkImage(
                                snapshot.data!.docs[index]['postURL']),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 2,
                          );
                        },
                        scrollPhysics: const BouncingScrollPhysics(),
                        backgroundDecoration: BoxDecoration(
                          color: kOtherColor,
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:  Visibility(visible:authController.myUser.value.wrole == 'teacher',
        child:
        FloatingActionButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UploadImageScreen(
                        screenName: widget.screenName,
                      ),
                    ),
                  ),
                child: Icon(Icons.add),
              )),
    );
  }
}
