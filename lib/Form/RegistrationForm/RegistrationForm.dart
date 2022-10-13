import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/ConfirmRegistration/ConfirmRegistration.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ForgetPassword/VerifyEmail.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:json_serializable/builder.dart';
//import 'package:json_annotation/json_annotation.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String email = "", pass = "", name = "", adderss = "";
  String loginEmail = "", loginPass = "";


  TextEditingController registerFirstNameController = TextEditingController();
  TextEditingController registerLastNameController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController =
      TextEditingController();

  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  bool _isLoading = false;
    String countryName = "";
  String phoneCodeNum="";
  List contList = [];
  List phnList = [];

  List<DropdownMenuItem<String>> _dropDownCountryItems;

  List<DropdownMenuItem<String>> getDropDownCountryItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String countryList in contList) {
    
      items.add(new DropdownMenuItem(
          value: countryList,
          child: new Text(
            countryList,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 16, color: Colors.black),
          )));
    }
    return items;
  }


  /////////////////////////  Register Form Design Container start///////////////////

  Container registerField(Icon icon, String hint, TextInputType type,
      bool secure, TextEditingController control) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
      margin: EdgeInsets.only(top: 13),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
          border: Border.all(width: 0.2, color: Colors.grey)),
      child: TextFormField(
        cursorColor: Colors.grey,
        controller: control,
        obscureText: secure,
        autofocus: true,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          icon: Container(margin: EdgeInsets.only(left: 10), child: icon),
          hintText: FlutterI18n.translate(context, hint),
          hintStyle: TextStyle(fontSize: 14),
          //labelText: 'Enter E-mail',
          contentPadding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 5.0),
          border: InputBorder.none,
        ),
        validator: (val) => val.isEmpty ? 'Field is empty' : null,
        onSaved: (val) => name = val,
        //validator: _validateEmail,
      ),
    );
  }

  /////////////////////////  Register Form Design Container end///////////////////

  @override
  void initState() {
    bottomNavIndex = 0;
     String counName = "";
    String phone = "";
    for (int i = 0; i < country.length; i++) {
      contList.add("${country[i]['name']}");
      phnList.add("${country[i]['phoneCode']}");
      // contList.add({"country":"${country[i]['name']}",
      //                 "phoneCode":"${country[i]['phoneCode']}"
      //                 });

      setState(() {
        if (country[i]['name'] == "Bahrain") {
          counName = "${country[i]['name']}";
          phone = "${country[i]['phoneCode']}";
        }
      });
    }

   // print(phnList);

    // print("counName");
    // print(counName);

    _dropDownCountryItems = getDropDownCountryItems();
    setState(() {
      countryName = counName;
      phoneCodeNum  = phone;
    });

    super.initState();
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(FlutterI18n.translate(context, msg),),
      action: SnackBarAction(
         label: FlutterI18n.translate(context, "Close"),
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////   Sign Up Form Start ///////////////
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ////////////////////register First Name  ////////////////
            registerField(
                Icon(
                  Icons.account_circle,
                  color: Colors.black38,
                  size: 17,
                ),
                "First_Name",
                TextInputType.text,
                false,
                registerFirstNameController),

            ////////////////////register Last Name  ////////////////
            registerField(
                Icon(
                  Icons.account_circle,
                  color: Colors.black38,
                  size: 17,
                ),
                "Last_Name",
                TextInputType.text,
                false,
                registerLastNameController),

            // //////////////////// register Phone ////////////////
            // registerField(
            //     Icon(
            //       Icons.phone,
            //       color: Colors.black38,
            //       size: 17,
            //     ),
            //     "Phone",
            //     TextInputType.number,
            //     false,
            //     registerPhoneController),

            ////////////////////register  phone   ////////////////
            Container(
  width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 12),
        child: Row(
          children: <Widget>[
              Container(
                
                decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
          border: Border.all(width: 0.2, color: Colors.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                            FlutterI18n.translate(context, "Country_Code"),
                            style: TextStyle(color: Colors.grey[700], fontSize: 14),
                          ),
                    ),
                        Padding(
                          padding: const EdgeInsets.only(left:8, right:8, top: 0,bottom:16 ),
                          child: Text(
                      phoneCodeNum, 
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    ),
                        ),
                  ],
                ),
              ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                  margin: EdgeInsets.only(left: 8, top: 0),
                  decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
          border: Border.all(width: 0.2, color: Colors.grey)),
                  child: TextField(
                    cursorColor: Colors.grey,
                    controller: registerPhoneController,
                    keyboardType: TextInputType.number,
                    autofocus: true, 
                    enabled: true,
                    style: TextStyle(color: Colors.black,fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "",
                      labelText: FlutterI18n.translate(context, "Mobile_Number"),
                      labelStyle: TextStyle(color: Colors.grey[700],),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 15.0),
                      border: InputBorder.none,
                    ),
                  )),
            ),
          ],
        )),
            // registerField(
            //     Icon(
            //       Icons.phone,
            //       color: Colors.black38,
            //       size: 17,
            //     ),
            //     "Phone",
            //     TextInputType.number,
            //     false,
            //     registerPhoneController),

                   ////////////////////register  email   ////////////////

            registerField(
                Icon(
                  Icons.mail,
                  color: Colors.black38,
                  size: 17,
                ),
                "Email",
                TextInputType.text,
                false,
                registerEmailController),

            //////////////////// register Password  ////////////////

            registerField(
                Icon(
                  Icons.lock,
                  color: Colors.black38,
                  size: 17,
                ),
                "Password",
                TextInputType.text,
                true,
                registerPasswordController),

            ////////////////////register  Confirm  Password  ////////////////
            registerField(
                Icon(
                  Icons.lock,
                  color: Colors.black38,
                  size: 17,
                ),
                "Confirm_Password",
                TextInputType.text,
                true,
                registerConfirmPasswordController),


                ////////////////country ///////////

Container(
            padding: EdgeInsets.only( top: 20, bottom: 10),
            child: Container(
             // margin: EdgeInsets.only(left: 8, top: 0),
              padding: EdgeInsets.only(left: 15, top: 10),
              decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
          border: Border.all(width: 0.2, color: Colors.grey)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "Country"),
                    style: TextStyle(color: appTealColor, fontSize: 12),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton(
                          isExpanded: true,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          value: countryName,
                          items: _dropDownCountryItems,
                          onChanged: (String value) {
                            setState(() {
                              countryName = value;

                                });

                                for(int i=0;i<contList.length;i++){

                                   if (country[i]['name'] == countryName) {
                                     
                                     setState(() {
                                        phoneCodeNum = phnList[i];
                                     });
                                     break;
                                          
                                          }
                                }
                              //mobileController.text = phnList[index];
                             
                           
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


      
            //////////////////// Register Button Start  ////////////////
           

            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: _isLoading ? null : _handleRegister,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                              left: 0, right: 0, top: 20, bottom: 0),
                          decoration: BoxDecoration(
                              color: appTealColor.withOpacity(0.9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            _isLoading ? FlutterI18n.translate(context, "Creating")+"..." : FlutterI18n.translate(context, "Register"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'BebasNeue',
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ],
              ),
            ),

            //////////////////// Register Button End  ////////////////

            /////////////////////// Already Have Account Part Start  ////////////////

            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Text(
                    FlutterI18n.translate(context, "Already_have_an_account")+"?",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  )),

                  /////////////////////// Sign in call dialouge from register Start  ////////////////

                  GestureDetector(
                    onTap: () {
                      //showDialogBox();
                      Navigator.push(
                          context, SlideLeftRoute(page: LogInPage("2")));
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          FlutterI18n.translate(context, "Sign_in"),
                          style: TextStyle(
                              color: appTealColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        )),
                  ),

                  /////////////////////// Sign in call dialouge  from register End ////////////////
                ],
              ),
            ),

            /////////////////////// Already Have Account part end  ////////////////
          ],
        ),
      ),
    );

    //////////////////////////   Sign Up Form end ///////////////
  }

  void _handleRegister() async {
    if (registerFirstNameController.text.isEmpty) {
      return _showMsg("First_Name_is_empty");
    } else if (registerLastNameController.text.isEmpty) {
      return _showMsg("Last_Name_is_empty");
    } else if (registerPhoneController.text.isEmpty) {
      return _showMsg("Phone_number_is_empty");
    } 
    else if (registerEmailController.text.isEmpty) {
      return _showMsg("Email_is_empty");
    }
    else if (!registerEmailController.text.contains('@')) {
      return _showMsg("Email_is_invalid");
    }
     else if (registerPasswordController.text.isEmpty) {
      return _showMsg("Password_is_empty");
    } 
     else if (registerPasswordController.text.length<6) {
      return _showMsg("Password_must_be_6_or_more");
    } 
    else if (registerConfirmPasswordController.text.isEmpty) {
      return _showMsg("Confirm_Password_is_empty");
    } else if (registerPasswordController.text !=
        registerConfirmPasswordController.text) {
      return _showMsg("Password_is_not_same");
    }

    var data = {
      "firstName": registerFirstNameController.text,
      "lastName": registerLastNameController.text,
      'country_code':phoneCodeNum,
      "mobile": registerPhoneController.text,
      "email": registerEmailController.text,
      "password": registerPasswordController.text,
      "country": countryName,
      // "house": '',
      // "street": '',
      // "road": '',
      // "block": '',
      // "area": '',
      // "city": '',
      // "state": '',
      // "discount": '',
      // "discountValidity": '',
      // "country": '',
    };

    var data1 = {
      "firstName": registerFirstNameController.text,
      "lastName": registerLastNameController.text,
      "email": registerPhoneController.text,
      "mobile": '',
      "house": '',
      "street": '',
      "road": '',
      "block": '',
      "area": '',
      "city": '',
      "state": '',
      "country": '',
      "profilepic": '',
    };
    setState(() {
      _isLoading = true;
    });
    var res = await CallApi().postData(data, '/app/addUser');
  print(data);
    var body = json.decode(res.body);
    print(body);
    print("object");
    print(body['validation']);
    if (body['success'] == true) {
      //SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('token', body['token']);
      // localStorage.setString('user', json.encode(body['user']));
      // localStorage.setString('loggedin-user', json.encode(data1));


      // var userJson = localStorage.getString('user');
      // var user = jsonDecode(userJson);
      // print(user['id']);
      // print(body['token']);
      //_showRegisterAlert();
      //Navigator.push(context, SlideLeftRoute(page: Navigation(0)));
      Navigator.push(context, SlideLeftRoute(page: ConfirmRegistration(body['user']['email'])));
    } else if (body['validation']==1) {
      // return _showMsg("email already exists");
         _showMsg("Phone_number_or_email_is_already_registered");
      // setState(() {
     
      //   _isLoading = false;
      // });
    }
    //  else if (body['validation']==2) {
    //   // return _showMsg("email already exists");
    //      _showMsg("Phone number is invalid");
    //   // setState(() {
     
    //   //   _isLoading = false;
    //   // });
    // } 
    // else if (body['message'].contains('SQLSTATE[23000]')) {
    //   // return _showMsg("email already exists");
    //      _showMsg("Email already exists");
    //   // setState(() {
     
    //   //   _isLoading = false;
    //   // });
    // }
    else {
       _showMsg("Something_went_wrong");
      // setState(() {
     
      //   _isLoading = false;
      // });
    }

    setState(() {
      print('false');
      _isLoading = false;
    });
  }

  _showRegisterAlert() {
    Fluttertoast.showToast(
        msg: "Account created successfully!\nNow you are logged in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: appTealColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }
}
