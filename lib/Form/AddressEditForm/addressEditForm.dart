import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/AddAddressPage/addAddressPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/AddressPage/addressPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/ChangePassword/ChangePassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class AddressEditForm extends StatefulWidget {
  final addressList;
  AddressEditForm(this.addressList);
  @override
  _AddressEditFormState createState() => _AddressEditFormState();
}

class _AddressEditFormState extends State<AddressEditForm> {
  String result = '';
  TextEditingController countryController = new TextEditingController();
  TextEditingController houseController = new TextEditingController();
  TextEditingController roadController = new TextEditingController();
  TextEditingController blockController = new TextEditingController();
  TextEditingController areaController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  String countryName = "";
    String phoneCodeNum="";
  bool _isLoading = false;
  List contList = [];
   List phnList = [];

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(FlutterI18n.translate(context, msg),),
      action: SnackBarAction(
        label: FlutterI18n.translate(context, 'Close'),
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

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

  @override
  void initState() {
    _getUserInfo();

    super.initState();
  }

  var userData, usertoken;

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
    var token = localStorage.getString('token');
    setState(() {
      usertoken = token;
    });

    String counName = "";
    String phone = "";
    for (int i = 0; i < country.length; i++) {
     // contList.add("${country[i]['name']}");
 contList.add("${country[i]['name']}");
      phnList.add("${country[i]['phoneCode']}");
      setState(() {
        if (country[i]['name'] == "${widget.addressList.country}") {
          counName = "${country[i]['name']}";
             phone = "${country[i]['phoneCode']}";
        }
      });
    }

    _dropDownCountryItems = getDropDownCountryItems();
    setState(() {
      countryName = counName;
      //  countryName = counName;
      phoneCodeNum  = phone;
      addressController.text =
          widget.addressList.name == null ? "" : "${widget.addressList.name}";
      mobileController.text = widget.addressList.mobile == null
          ? ""
          : "${widget.addressList.mobile}";
      areaController.text =
          widget.addressList.area == null ? "" : "${widget.addressList.area}";
      houseController.text =
          houseController.text == null ? "" : "${widget.addressList.house}";
      roadController.text =
          widget.addressList.house == null ? "" : "${widget.addressList.road}";
      blockController.text =
          widget.addressList.block == null ? "" : "${widget.addressList.block}";
      cityController.text =
          widget.addressList.city == null || widget.addressList.city == "null" ? "" : "${widget.addressList.city}";
      stateController.text =
          widget.addressList.state == null || widget.addressList.state == "null" ? "" : "${widget.addressList.state}";
      countryController.text = countryName;
    });

    // //print(user);
    // print(cityController.text);
    // print(stateController.text);
  }

  Container editinfo(String label, String hint, TextEditingController control,
      TextInputType type, bool enable) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child: Container(
            margin: EdgeInsets.only(left: 8, top: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.grey[100],
                border: Border.all(width: 0.2, color: Colors.grey)),
            child: TextField(
              cursorColor: Colors.grey,
              controller: control,
              keyboardType: type,
              autofocus: true,
              enabled: enable,
              style: TextStyle(color: Colors.black54),
              decoration: InputDecoration(
                hintText: FlutterI18n.translate(context, hint),
                labelText: FlutterI18n.translate(context, label),
                labelStyle: TextStyle(color: appTealColor),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 15.0),
                border: InputBorder.none,
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          editinfo('Address', '', addressController, TextInputType.text, true),
          Container(
              margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),
Container(
  width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 25, right: 15, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
              Container(
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.grey[100],
                    border: Border.all(width: 0.2, color: Colors.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                            FlutterI18n.translate(context, "Country_Code"),
                            style: TextStyle(color: appTealColor, fontSize: 14),
                          ),
                    ),
                        Padding(
                          padding: const EdgeInsets.only(left:8, right:8, top: 0,bottom:16 ),
                          child: Text(
                      phoneCodeNum, 
                      style: TextStyle(color: appTealColor, fontSize: 12),
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
                      color: Colors.grey[100],
                      border: Border.all(width: 0.2, color: Colors.grey)),
                  child: TextField(
                    cursorColor: Colors.grey,
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    enabled: true,
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      hintText: "",
                      labelText: FlutterI18n.translate(context, "Mobile_Number"),
                      labelStyle: TextStyle(color: appTealColor),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 15.0),
                      border: InputBorder.none,
                    ),
                  )),
            ),
          ],
        )),
       //   editinfo("Mobile_Number", '', mobileController, TextInputType.text, true),
          Container(
              margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          editinfo('Area', '', areaController, TextInputType.text, true),

          Container(
              margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          editinfo('House_Building_Flat', '', houseController, TextInputType.text, true),

          Container(
              margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          editinfo('Road', '', roadController, TextInputType.text, true),

          Container(
              margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          editinfo('Block', '', blockController, TextInputType.text, true),

          Container(
              margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          editinfo('City', '', cityController, TextInputType.text, true),

          Container(
              margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          editinfo('State', '', stateController, TextInputType.text, true),

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
            child: Container(
              margin: EdgeInsets.only(left: 8, top: 0),
              padding: EdgeInsets.only(left: 15, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.grey[100],
                //border: Border.all(width: 0.2, color: Colors.grey)
              ),
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
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /////////////////   profile editing save start ///////////////

          GestureDetector(
            onTap: () {
              _isLoading ? null : _updateProfile();
            },
            child: Container(
              margin: EdgeInsets.only(left: 25, right: 15, bottom: 20, top: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color:
                      _isLoading ? Colors.grey : appTealColor.withOpacity(0.9),
                  border: Border.all(width: 0.2, color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.save,
                    size: 20,
                    color: Colors.white,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(_isLoading ? FlutterI18n.translate(context, "Please_wait")+("...")  : FlutterI18n.translate(context, "Save"),
                          style: TextStyle(color: Colors.white, fontSize: 17)))
                ],
              ),
            ),
          ),

          /////////////////   profile editing save end ///////////////
        ],
      ),
    );
  }

  /////////////Croping Image method end///////////\

  void _updateProfile() async {
    if (addressController.text == "") {
      return _showMsg("Address_name_field_is_empty");
    } else if (mobileController.text == "") {
      return _showMsg("Mobile_field_is_empty");
    } else if (areaController.text == "") {
      return _showMsg("Area_field_is_empty");
    } else if (houseController.text == "") {
      return _showMsg("House_field_is_empty");
    } else if (roadController.text == "") {
      return _showMsg("Road_field_is_empty");
    } else if (blockController.text == "") {
      return _showMsg("Block_field_is_empty");
    }
    //  else if (cityController.text == "") {
    //   return _showMsg("City field is empty!");
    // }
    //  else if (stateController.text == "") {
    //   return _showMsg("State field is empty!");
    // }
    else if (countryController.text == "") {
      return _showMsg("Country_field_is_empty");
    }

    var data = {
      "name": addressController.text,
      "country_code":phoneCodeNum,
      "mobile": mobileController.text,
      "area": areaController.text,
      "house": houseController.text,
      "road": roadController.text,
      "block": blockController.text,
      "city": cityController.text,
      "state": stateController.text,
      "country": countryName,
    };
    setState(() {
      _isLoading = true;
    });
    var res = await CallApi().postData(data,
        '/app/updateDeliveryAddress/${widget.addressList.id}?token=$usertoken');

    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', usertoken);
      //localStorage.setString('user', json.encode(data));

      setState(() {
        userData['area'] = areaController.text;
        userData['country_code'] = phoneCodeNum;
        userData['mobile'] = mobileController.text;
        userData['house'] = houseController.text;
        userData['road'] = roadController.text;
        userData['block'] = blockController.text;
        userData['city'] = cityController.text;
        userData['state'] = stateController.text;
        userData['country'] = countryController.text;
      });

      Navigator.pop(context);

      Navigator.push(context, new SlideLeftRoute(page: AddressPage()));
    } else if (body['message'].contains('SQLSTATE[23000]')) {
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _showMsg("Something_went_wrong");
        _isLoading = false;
      });
    }

    setState(() {
      print('false');
      _isLoading = false;
    });
  }
}
