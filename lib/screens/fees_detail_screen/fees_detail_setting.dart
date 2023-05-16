import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/components/custom_textfeild.dart';
import 'package:EduInfo/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FeesDetailSetting extends StatefulWidget {
  const FeesDetailSetting({Key? key}) : super(key: key);
  static String routeName = 'FeesDetailSetting';

  @override
  State<FeesDetailSetting> createState() => _FeesDetailSettingState();
}

class _FeesDetailSettingState extends State<FeesDetailSetting> {
  final TextEditingController _mAccountNo = TextEditingController();
  final TextEditingController _mIfscCode = TextEditingController();
  final TextEditingController _mRecipientName = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    //authController.getUserInfo();
    _mAccountNo.text = authController.myUser.value.accountNo??"";
    _mIfscCode.text = authController.myUser.value.ifscCode??"";
    _mRecipientName.text = authController.myUser.value.recipientName??"";
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar theme for tablet
      appBar: AppBar(
        title: Text('Editing Payment Detail', style: TextStyle(color: kTextWhiteColor),),
        actions: [
          // isLoding ? 
          // Center(child: CircularProgressIndicator(),):
          Obx(() => authController.isPaymentUploading.value
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                      :
                        InkWell(
            onTap: () {
              //send report to school management, in case if you want some changes to your profile
              if(!_formKey.currentState!.validate()) return;
              
              authController.isPaymentUploading(true);

              authController.storePaymentInfo(_mAccountNo.text.trim(), _mIfscCode.text.trim(), _mRecipientName.text.trim());
            },
            child: Container(
              padding: EdgeInsets.only(right: kDefaultPadding / 2),
              child: Row(
                children: [
                  Icon(Icons.save),
                  kHalfWidthSizedBox,
                  // Text(
                  //   'Report',
                  //   style: Theme.of(context).textTheme.subtitle2,
                  // ),
                ],
              ),
            ),
          ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        sizedBox,
                        buildTextField(_mAccountNo, 'Account Number'),
                        sizedBox,
                        buildTextField(_mIfscCode, 'IFSC Code'),
                        sizedBox,
                        buildTextField(_mRecipientName, 'Recipient Name'),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}