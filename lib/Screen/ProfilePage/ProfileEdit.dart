import 'dart:io';


import 'package:ecommerce_bokkor_dev/Form/ProfileEditForm/ProfileEditForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';


import '../../main.dart';

import 'package:image_picker/image_picker.dart';

class ProfileEditDialog extends StatefulWidget {
  @override
  _ProfileEditDialogState createState() => new _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: appTealColor,
        title: Text(FlutterI18n.translate(context, "Edit_Profile")),
      ),
      //body: new Text("It's a Dialog!"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: new Container(
              padding: EdgeInsets.all(0.0),
              //color: Colors.white,
              child: ProfileEditForm()),
        ),
      ),
    );
  }
}
