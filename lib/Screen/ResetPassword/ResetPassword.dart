
import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/GenerateCode/GenerateCode.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';


class ResetPassword extends StatefulWidget {
  final phone;
  final type;
  final code;
  ResetPassword(this.phone,this.type,this.code);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
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
                 Navigator.of(context).pop();
                },
              );
            },
          ),
          title: Text(
           FlutterI18n.translate(context, "Reset_Password"),
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          backgroundColor: appTealColor,
          elevation: 0,
        ),

        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(bottom: 8,left: 20,right: 20,top: 50),
                    child: Text(
                      FlutterI18n.translate(context, "New_Password"),
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
                          controller: newPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          // autofocus: true,
                          style: TextStyle(
                              fontFamily: "Helvetica",
                              fontSize: 16,
                              color: appTealColor,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key,color: Colors.grey,),
                            hintText:  FlutterI18n.translate(context, "New_Password"),
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



              //////////////   confirm password ///////////
             
                    Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(bottom: 8,left: 20,right: 20,top: 20),
                    child: Text(
                       FlutterI18n.translate(context, "Confirm_Password"),
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
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          // autofocus: true,
                          style: TextStyle(
                              fontFamily: "Helvetica",
                              fontSize: 16,
                              color: appTealColor,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key,color: Colors.grey,),
                            hintText:  FlutterI18n.translate(context, "Confirm_Password"),
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
                  _isLoading?FlutterI18n.translate(context, "Submitting")+"....":FlutterI18n.translate(context, "Reset"),
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Helvetica",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
            ],
          ),
        )

      
    );
  }

    void _submitButton() async{

       if (newPasswordController.text.isEmpty) {
      return _showMsg("Password_is_empty");
      
    }  else if (newPasswordController.text.length<6) {
      return _showMsg("Password_length_should_be_6_or_more");
    } else if(confirmPasswordController.text.isEmpty){
       return _showMsg("Confirm_Password_is_empty");
    }else if(newPasswordController.text!=confirmPasswordController.text){
 return _showMsg("Password_doesnt_match");
    }
    setState(() {
      _isLoading = true;
    });

    var data;//= {
      
      
      if(widget.type=="mobile"){

        data={
          'password': newPasswordController.text,
          'mobile':widget.phone,
        };
       
      }

    else if(widget.type=="email"){
          data={
          'password': newPasswordController.text,
          'email':widget.phone,
          'code':widget.code

        };
      }
     
      
     
   // };

   // var res = await CallApi().postData(data, '/app/resetPassword');
     var res;
    if(widget.type=="mobile"){

    res = await CallApi().postData(data, '/app/resetPassword');
    }
    else if(widget.type=="email"){
       res = await CallApi().postData(data, '/app/resetPasswordEmail');
    }
    print(data);
    var body = json.decode(res.body);
     print(body);

       if (body['success'] == true) {
       _changeNewPassMsg();

     }
       else {
         _showMsg("Something_went_wrong");
      }

    setState(() {
      _isLoading = false;
    });
  
    
  }

  
         void _changeNewPassMsg() {
    showDialog(
      context: context,
     //   barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          contentPadding: EdgeInsets.all(5),
          title: 
              Text(
                               FlutterI18n.translate(context,"Your_Password_has_been_changed_Now_you_can_login_with_your_new_password"),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                     color: appTealColor,
                                    fontFamily: "grapheinpro-black",
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
              actions: <Widget>[
                Container(
               alignment: Alignment.center,
                              decoration: BoxDecoration(
                                 color: appTealColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              // width: MediaQuery.of(context).size.width/3,
                              height: 30,
                              margin: EdgeInsets.only(bottom: 15, right: 10),
                              child: OutlineButton(
                                  //color: Colors.greenAccent[400],
                                  child: new Text(
                                  FlutterI18n.translate(context,"OK"),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                   // Navigator.of(context).pop();
                               Navigator.push(context, SlideLeftRoute(page: LogInPage(0)));
                                  },
                                  // borderSide: BorderSide(
                                  //     color: Colors.green, width: 0.5),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0))))]

     
        );
      },
    );
  }
}