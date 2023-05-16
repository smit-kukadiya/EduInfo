import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/constants.dart';
import 'package:EduInfo/screens/fees_detail_screen/fees_detail_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class FeesDetailScreen extends StatelessWidget {
  FeesDetailScreen({Key? key}) : super(key: key);
  static String routeName = 'FeesDetailScreen';

  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    authController.getUserInfo();
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Detail', style: TextStyle(color: kTextWhiteColor),),
        actions: [
          InkWell(
            onTap: () {
              //send report to school management, in case if you want some changes to your profile
              Navigator.pushNamed(context, FeesDetailSetting.routeName);
            },
            child: Container(
              padding: EdgeInsets.only(right: kDefaultPadding / 2),
              child: Row(
                children: [
                  Icon(Icons.edit),
                  kHalfWidthSizedBox,
                  // Text(
                  //   'Report',
                  //   style: Theme.of(context).textTheme.subtitle2,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kTopBorderRadius,
                color: kOtherColor,
              ),
              child: Column(
                children: [
                  sizedBox,
                  sizedBox,
                  FeesDetailColumn(title: "Account number", value: authController.myUser.value.accountNo.toString()),
                  sizedBox,
                  sizedBox,
                  FeesDetailColumn(title: "IFSC code", value: authController.myUser.value.ifscCode.toString()),
                  sizedBox,
                  sizedBox,
                  FeesDetailColumn(title: "Recipient name", value: authController.myUser.value.recipientName.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
      
  }
}

class FeesDetailColumn extends StatelessWidget {
  const FeesDetailColumn(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: kTextBlackColor,
                      fontSize: SizerUtil.deviceType == DeviceType.tablet
                          ? 7.sp
                          : 11.sp,
                    ),
              ),
              kHalfSizedBox,
              Text(value, style: Theme.of(context).textTheme.caption),
              kHalfSizedBox,
              SizedBox(
                width: 92.w,
                child: Divider(
                  thickness: 1.0,
                ),
              )
            ],
          ),
          Icon(
            Icons.lock_outline,
            size: 10.sp,
          ),
        ],
      ),
    );
  }
}