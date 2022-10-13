import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/Registration/Registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../main.dart';
import 'LogInForm.dart';

class LogInPage extends StatefulWidget {
  final page;
  LogInPage(this.page);
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTealColor,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
              //  if(widget.page==10) {

              //       Navigator.push(context, SlideLeftRoute(page: Navigation(0)));
                
              // }else{
                 Navigator.pop(context);
             // }
              }
            );
          }
        ),
        title: Text(FlutterI18n.translate(context, "Login"),
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      body: LogInForm(widget.page),
    );
  }
}
