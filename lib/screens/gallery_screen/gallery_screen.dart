import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

final imageList = [
    'http://gmit.edu.in/assets/img/pressnotes/110.JPG',
    'http://gmit.edu.in/assets/img/pressnotes/91.jpeg',
    'http://gmit.edu.in/assets/img/pressnotes/86.jpeg',
    'http://gmit.edu.in/assets/img/pressnotes/76.jpg',
  ];

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);
  static String routeName = 'GalleryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery', style: TextStyle(color: kTextWhiteColor),),
      ),
      body: Column(
        children: [
          Expanded(
             child: Container(
               decoration: BoxDecoration(
                 color: kOtherColor,
                 borderRadius: kTopBorderRadius,
               ),
               child:
                   PhotoViewGallery.builder(
                    itemCount: imageList.length,
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        basePosition: Alignment.center,
                        imageProvider: NetworkImage(imageList[index]),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      );
                    },
                    scrollPhysics: BouncingScrollPhysics(),
                    backgroundDecoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                ),  
          ),
        ], 
      ),
    );
  }
}
