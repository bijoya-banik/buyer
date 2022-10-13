
import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/GenerateCode/GenerateCode.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';


class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(FlutterI18n.translate(context, msg),),
      action: SnackBarAction(
        label: FlutterI18n.translate(context, "Close"),
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState..showSnackBar(snackBar);
  }
bool _isLoading = false;

    TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
       appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  // bottomNavIndex = 2;
                  // Navigator.push(context, SlideLeftRoute(page: Navigation()));
                  Navigator.of(context).pop();
                },
              );
            },
          ),
          title: Text(
             FlutterI18n.translate(context, "Forget_Password"),
           
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          backgroundColor: appTealColor,
          elevation: 0,
        ),

        body: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: 8,left: 20,right: 20,top: 50),
                  child: Text(
                      FlutterI18n.translate(context, "Phone"),
                   
                    style: TextStyle(
                        color: appTealColor,
                        fontFamily: "Helvetica-Normal",
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Card(
                  elevation: 0,
                   margin: EdgeInsets.only(left: 20,right: 20,top:7),
                  color: Colors.grey[200],
                  child: Container(
                     
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        //color: Colors.red.withOpacity(0.8),
                        // border: Border.all(width: 0.2, color: Colors.grey)
                      ),
                      child: TextField(
                        cursorColor: Colors.grey,
                        controller: emailController,
                        keyboardType: TextInputType.number,
                        // autofocus: true,
                        style: TextStyle(
                            fontFamily: "Helvetica",
                            fontSize: 16,
                            color: appTealColor,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: Colors.grey),
                          hintText:FlutterI18n.translate(context, "Phone_Number"),
                          hintStyle: TextStyle(
                              fontFamily: "Helvetica",
                              color: appTealColor.withOpacity(0.7),
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                          // labelText: label,
                          // labelStyle: TextStyle(color: appTealColor),
                          contentPadding:
                              EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
                          border: InputBorder.none,
                        ),
                      )),
                ),
              ],
            ),
               Card(
          color:  _isLoading?Colors.grey:appTealColor,
          elevation: 2,
          margin: EdgeInsets.only(top: 35,left: 20, right: 20),
          child: Container(
              padding: EdgeInsets.only(top: 3, bottom:3),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color:  _isLoading?Colors.grey:appTealColor,
                
                ),
            child: FlatButton(
              onPressed: () {
                _isLoading?null: _submitButton();
              },
              child: Text(
                _isLoading?FlutterI18n.translate(context, "Submitting")+"...":FlutterI18n.translate(context, "Submit"),
                style: TextStyle(
                    color:Colors.white,
                    fontFamily: "Helvetica",
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
          ],
        )

      
    );
  }

  void _submitButton() async{

       if (emailController.text.isEmpty) {
      return _showMsg("Phone_is_empty");
    } 
    setState(() {
      _isLoading = true;
    });

    var data = {

      'mobile': emailController.text,
     
    };

    var res = await CallApi().postData(data, '/app/resetPasswordGetPhoneNumber');
    print(data);
    var body = json.decode(res.body);
     print(body);
    if (res.statusCode == 200) {
       
    Navigator.push(context, SlideLeftRoute(page: GenerateCode("mobile")));

     }
     else if(res.statusCode == 422){
        _showMsg("Number_not_found");
     }
       else {
         _showMsg("Something_went_wrong");
      }

    setState(() {
      _isLoading = false;
    });
  
    
   }
}