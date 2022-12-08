import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

final imageList = [
    'assets/images/result.png',
  ];

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static String routeName = 'ResultScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result', style: TextStyle(color: kTextWhiteColor),),
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
                        imageProvider: AssetImage(imageList[index]),
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
