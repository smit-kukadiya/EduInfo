

import 'package:EduInfo/constants.dart';
import 'package:flutter/material.dart';

Container rowFirstLastName(
    TextEditingController firstControllerName, 
    String firstLabelTxt, 
    TextEditingController lastControllerName, 
    String lastLabelTxt,
  ) {
  return Container(
    alignment: Alignment.center,
    height: 70,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: name(firstControllerName, firstLabelTxt),
          ),
        ),
        const SizedBox(width: 10.0),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: name(lastControllerName, lastLabelTxt),
          ),
        ),
      ],
    )
  );
}

TextFormField name(TextEditingController controllerName, String labelTxt) {
  return TextFormField(
    controller: controllerName,
    textAlign: TextAlign.start,
    keyboardType: TextInputType.name,
    style: kInputTextStyle,
    decoration: InputDecoration(
      labelText: labelTxt,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    //border: OutlineInputBorder(),
    //labelText: 'First Name',
    // contentPadding:
    //     EdgeInsets.only(left: 0.0, top: 8.0, right: 0.0, bottom: 8.0)
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
          return 'Please enter some text';
          //if it does not matches the pattern, like
          //it not contains @
        }
      return null;
    },
    // onSaved: (val) {
    //   controllerName = val;
    // },
  );
}

TextFormField buildEmailField(TextEditingController controllerName, String labletxt) {
    return TextFormField(
      controller: controllerName,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      style: kInputTextStyle,
      
      decoration: InputDecoration(
        labelText: labletxt,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //print(value);
        //for validation
        RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
          //if it does not matches the pattern, like
          //it not contains @
        } else if (!regExp.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
      },
    );
}

TextFormField buildMobileField(TextEditingController controllerName, String labletxt) {
    return TextFormField(
      controller: controllerName,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.number,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: labletxt,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //print(value);
        //for validation
        RegExp regExp = new RegExp(mobilePattern);
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
          //if it does not matches the pattern, like
          //it not contains @
        } else if (!regExp.hasMatch(value)) {
          return 'Please enter a valid mobile';
        }
      },
    );
}

TextFormField buildPasswordField(name, passController, obscure) {
    return TextFormField(
      controller: passController,
      obscureText: obscure,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: name,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: IconButton(
        //   onPressed: () {
        //     setState(() {
        //       obscure = !obscure;
        //     });
        //   },
        //   icon: Icon(
        //     obscure
        //         ? Icons.visibility_off_outlined
        //         : Icons.visibility_off_outlined,
        //   ),
        //   iconSize: kDefaultPadding,
        // ),
      ),
      validator: (value) {
        if (value!.length < 5) {
          return 'Must be more than 5 characters';
        }
      },
    );
}