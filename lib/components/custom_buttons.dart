import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final IconData iconData;

  const DefaultButton(
      {Key? key,
      required this.onPress,
      required this.title,
      required this.iconData
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.only(right: kDefaultPadding),
        width: 100.w,
        height: SizerUtil.deviceType == DeviceType.tablet ? 9.h : 7.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kSecondaryColor, kPrimaryColor],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(kDefaultPadding)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(title, style: Theme.of(context).textTheme.subtitle2),
            Spacer(),
            Icon(
              iconData,
              size: 26.sp,
              color: kOtherColor,
            )
          ],
        ),
      ),
    );
  }
}

class AnotherButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  //final IconData iconData;

  const AnotherButton(
      {Key? key,
        required this.onPress,
        required this.title,
        //required this.iconData
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.only(right: kDefaultPadding),
        width: 100.w,
        height: SizerUtil.deviceType == DeviceType.tablet ? 9.h : 7.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kSecondaryColor, kPrimaryColor],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(kDefaultPadding)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(title, style: Theme.of(context).textTheme.subtitle2),
            Spacer(),
            //Icon(
            //  iconData,
            //  size: 26.sp,
            //  color: kOtherColor,
            //)
          ],
        ),
      ),
    );
  }
}

Widget DecisionButton(String text, TextStyle? abc, Function onPressed,double width,{double height = 50}){
  return InkWell(
    onTap: ()=> onPressed(),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kSecondaryColor, kPrimaryColor],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(kDefaultPadding)),
      child: Row(
        children: [
          Container(
            width: 65,
            height: height,
            decoration: BoxDecoration(
              color: kContainerColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),

            ),
          ),

          Expanded(child: Text(text,style: abc, textAlign: TextAlign.center,)),





        ],
      ),
    ),
  );
}