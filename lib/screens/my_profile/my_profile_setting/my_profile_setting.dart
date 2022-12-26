import 'dart:io';
import 'package:EduInfo/auth/auth_controller.dart';
import 'package:EduInfo/components/custom_textfeild.dart';
import 'package:EduInfo/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class MyProfileSetting extends StatefulWidget {
  const MyProfileSetting({Key? key}) : super(key: key);
  static String routeName = 'MyProfileSetting';

  @override
  State<MyProfileSetting> createState() => _MyProfileSettingState();
}

class _MyProfileSettingState extends State<MyProfileSetting> {

  final TextEditingController _mFirstName = TextEditingController();
  final TextEditingController _mlastName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AuthController authController = Get.put(AuthController());

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  //bool isLoding = false;

  @override
  void initState() {
    //authController.getUserInfo();
    _mFirstName.text = authController.myUser.value.firstName??"";
    _mlastName.text = authController.myUser.value.lastName??"";
    _emailController.text = authController.myUser.value.email??"";
    _mobileController.text = authController.myUser.value.mobile.toString();
    _dateOfBirthController.text = authController.myUser.value.birthDate??"";
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar theme for tablet
      appBar: AppBar(
        title: Text('Editing Profile', style: TextStyle(color: kTextWhiteColor),),
        actions: [
          // isLoding ? 
          // Center(child: CircularProgressIndicator(),):
          Obx(() => authController.isProfileUploading.value
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                      :
                        InkWell(
            onTap: () {
              //send report to school management, in case if you want some changes to your profile
              if(!_formKey.currentState!.validate()) return;
              
              authController.isProfileUploading(true);

              authController.storeUserInfo(selectedImage, _mFirstName.text.trim(), _mlastName.text.trim(), _dateOfBirthController.text.trim(), url: authController.myUser.value.image??"");
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
                        Obx(() => authController.myUser.value.wrole == 'parent' ?
                          const Center(
                          child: Text('Hello'),
                        ) : 
                        GestureDetector(
                          onTap: (){
                            getImage(ImageSource.gallery);
                          },
                          child: selectedImage == null ? (authController.myUser.value.image!=null /*|| authController.myUser.value.image!=''*/)? CircleAvatar(
                            radius:
                                SizerUtil.deviceType == DeviceType.tablet ? 12.w : 13.w,
                            backgroundColor: kSecondaryColor,
                            backgroundImage:
                                NetworkImage(authController.myUser.value.image!),
                          ): Container(
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffD6D6D6)),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ): Container(
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(selectedImage!),
                                    fit: BoxFit.fill),
                                shape: BoxShape.circle,
                                color: Color(0xffD6D6D6)),
                          ),
                      ), ),
                      kWidthSizedBox,
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       authController.myUser.value.firstName.toString() + " " + authController.myUser.value.lastName.toString(),
                  //       style: Theme.of(context).textTheme.subtitle1,
                  //     ),
                  //     Text(authController.myUser.value.email.toString(),
                  //         style: Theme.of(context).textTheme.subtitle2),
                  //   ],
                  // )
                        sizedBox,
                        rowFirstLastName(_mFirstName, 'First Name', _mlastName, 'Last Name'),
                        sizedBox,
                        buildMobileField(_mobileController, 'Phone Number'),
                        sizedBox,
                        TextFormField(
                          controller: _dateOfBirthController,
                          readOnly: true,
                          style: kInputTextStyle,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            floatingLabelBehavior: FloatingLabelBehavior.always,),
                          //border: OutlineInputBorder(),
                          //labelText: 'FironSaved: (date) {
                          //    String? newDate = date;
                          //  },st Name',
                          // contentPadding:
                          //     EdgeInsets.only(left: 0.0, top: 8.0, right: 0.0, bottom: 8.0)
                          onTap: () async{await showDatePicker(
                              context: context, 
                              initialDate:DateTime.now(),
                              firstDate:DateTime(1900),
                              lastDate: DateTime.now()).then((selectedDate) {
                              if (selectedDate != null) {
                                _dateOfBirthController.text =
                                    DateFormat('yyyy-MM-dd').format(selectedDate);
                              }
                            });
                            // if(newDate == null) return;
                            // setState(() => date = newDate);
                            },
                          
                          //  
                        ),                     
                        sizedBox,
                      ],
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


class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
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
