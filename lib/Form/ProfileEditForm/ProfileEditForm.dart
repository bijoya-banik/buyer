import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ChangePassword/ChangePassword.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProfilePage/ProfileView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

enum PhotoCrop {
  free,
  picked,
  cropped,
}

class ProfileEditForm extends StatefulWidget {
  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  String result = '', date = 'Select Birth Date';
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController houseController = new TextEditingController();
  TextEditingController streetController = new TextEditingController();
  TextEditingController roadController = new TextEditingController();
  TextEditingController blockController = new TextEditingController();
  TextEditingController areaController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();

  var dd, finalDate;
  DateTime _date = DateTime.now();
  int gen = 1, gen1 = 0;
  Future<File> fileImage;

  ////////// Image Picker//////
  PhotoCrop state;
  File imageFile;
  String image, countryName = "", realImage = "";
  var imagePath;
  bool _isImage = false;
  bool _isLoading = false;
  List contList = [];

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
    state = PhotoCrop.free;

    super.initState();
  }

  var userData, usertoken;

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('loggedin-user');
    if (userJson != null) {
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
      print(userData);
      var token = localStorage.getString('token');
      setState(() {
        usertoken = token;
      });
      firstNameController.text =
          userData != null && userData['firstName'] != null
              ? '${userData['firstName']}'
              : '';
      lastNameController.text = userData != null && userData['lastName'] != null
          ? '${userData['lastName']}'
          : '';
      emailController.text = userData != null && userData['email'] != null
          ? '${userData['email']}'
          : '';
      mobileController.text = userData != null && userData['mobile'] != null
          ? '${userData['mobile']}'
          : '';
      houseController.text = userData != null && userData['house'] != null
          ? '${userData['house']}'
          : '';
      streetController.text = userData != null && userData['street'] != null
          ? '${userData['street']}'
          : '';
      roadController.text = userData != null && userData['road'] != null
          ? '${userData['road']}'
          : '';
      blockController.text = userData != null && userData['block'] != null
          ? '${userData['block']}'
          : '';
      areaController.text = userData != null && userData['area'] != null
          ? '${userData['area']}'
          : '';
      cityController.text = userData != null && userData['city'] != null
          ? '${userData['city']}'
          : '';
      stateController.text = userData != null && userData['state'] != null
          ? '${userData['state']}'
          : '';
    }

    print('${userData['country']}');

    String counName = "";
    for (int i = 0; i < country.length; i++) {
      contList.add("${country[i]['name']}");

      setState(() {
        if (userData == null) {
          counName = "Bahrain";
        } else {
          if (country[i]['name'] == "${userData['country']}") {
            counName = "${country[i]['name']}";
          } else {
            counName = "Bahrain";
          }
        }
      });
      // if (country[i]['name'] == "Bahrain") {
      //   counName = "${country[i]['name']}";
      // }
    }

    print(contList);

    print("counName");
    print(counName);

    _dropDownCountryItems = getDropDownCountryItems();
    setState(() {
      countryName = counName;
      realImage = "${userData['profilepic']}";
    });

    print(countryName);
  }

  pickImagefromGallery(ImageSource src) {
    setState(() {
      fileImage = ImagePicker.pickImage(source: src);
      //uploadImage(fileImage);
    });
  }

  void uploadImage(filePath) async {
    // Get base file name
    //var postUri = Uri.parse("https://mobile.bahrainunique.com/app/upload");
    List<int> imageBytes = filePath.readAsBytesSync();
    image = base64.encode(imageBytes);
    image = 'data:image/png;base64,' + image;

    var data = {'img': image};
    print(data);

    var res1 = await CallApi().postData(data, '/app/upload');
    var body1 = json.decode(res1.body);
    print(body1['imageUrl']);

    setState(() {
      realImage = body1['imageUrl'];
    });

    if (body1['success'] == true) {
      _showMsg("Profile_picture_uploaded_successfully");
    }
  }

  Container editinfo(String label, String hint, TextEditingController control,
      TextInputType type) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        child: Container(
            margin: EdgeInsets.only(left: 8, top: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.grey[100],
            ),
            child: TextField(
              cursorColor: Colors.grey,
              controller: control,
              keyboardType: type,
              autofocus: false,
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
          //////////////// Picture Button Start/////////////////

          Container(
              margin: EdgeInsets.only(top: 25),
              //color: Colors.red,
              child: _profilePictureButton()),
          //////////////// Picture Button End/////////////////

          /////////////////   profile first name start ///////////////
          Container(
              margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          editinfo('First_Name', '', firstNameController, TextInputType.text),

          /////////////////   profile last name start ///////////////
          Container(
              margin: EdgeInsets.only(top: 0), height: 2, child: Divider()),

          editinfo('Last_Name', '', lastNameController, TextInputType.text),

          /////////////////   profile email start ///////////////

          Container(
              margin: EdgeInsets.only(top: 0), height: 2, child: Divider()),

          editinfo('Email', '', emailController, TextInputType.text),

          /////////////////   profile address start ///////////////

          // Container(
          //     margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          // editinfo('Mobile', '', mobileController, TextInputType.number),

          // Container(
          //     margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          // editinfo('Area', '', areaController, TextInputType.text),

          // Container(
          //     margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          // editinfo('House', '', houseController, TextInputType.text),

          // Container(
          //     margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          // editinfo('Street', '', streetController, TextInputType.text),

          // Container(
          //     margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          // editinfo('Road', '', roadController, TextInputType.text),

          // Container(
          //     margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          // editinfo('Block', '', blockController, TextInputType.text),

          // Container(
          //     margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          // editinfo('City', '', cityController, TextInputType.text),

          // Container(
          //     margin: EdgeInsets.only(top: 20), height: 2, child: Divider()),

          // editinfo('State', '', stateController, TextInputType.text),


 ////// country //////////
          // Container(
          //   padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          //   child: Container(
          //     margin: EdgeInsets.only(left: 8, top: 0),
          //     padding: EdgeInsets.only(left: 15, top: 10),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //       color: Colors.grey[100],
          //       //border: Border.all(width: 0.2, color: Colors.grey)
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Text(
          //           "Country",
          //           style: TextStyle(color: appTealColor, fontSize: 12),
          //         ),
          //         Container(
          //           child: DropdownButtonHideUnderline(
          //             child: Container(
          //               width: MediaQuery.of(context).size.width,
          //               child: DropdownButton(
          //                 isExpanded: true,
          //                 style: TextStyle(
          //                   fontSize: 15,
          //                   color: Colors.black,
          //                 ),
          //                 value: countryName,
          //                 items: _dropDownCountryItems,
          //                 onChanged: (String value) {
          //                   setState(() {
          //                     countryName = value;
          //                   });
          //                 },
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),


          ////// country //////////
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
                      child: Text(_isLoading ? FlutterI18n.translate(context, "Saving")+("...") : FlutterI18n.translate(context, "Save"),
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

  /////////////Croping Image method start///////////
  Widget _profilePictureButton() {
    if (state == PhotoCrop.free) {
      return Column(
        // alignment: Alignment. center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50)),
            child: ClipOval(
              child: userData == null
                  ? Image.asset(
                      'assets/images/camera.png',
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    )
                  : userData['profilepic'] == null ||
                          userData['profilepic'] == ''
                      ? Image.asset(
                          'assets/images/camera.png',
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          '${userData['profilepic']}',
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _pickImage();
            },
            child: Container(
              width: 160,
              margin: EdgeInsets.only(left: 0, right: 0, top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.grey[200],
                  border: Border.all(width: 0.2, color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.image,
                    size: 16,
                    color: appTealColor,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(FlutterI18n.translate(context, "Select_photo"),
                          style: TextStyle(color: appTealColor, fontSize: 13)))
                ],
              ),
            ),
          ),

          // Positioned(
          //   bottom: 5,
          //   right: 50,
          //   child: Icon(Icons.camera_alt, color: Colors.grey,),
          // )
        ],
      );
    } else if (state == PhotoCrop.picked)
      return Column(
        children: <Widget>[
          imageFile == null
              ? Container(
                  padding: EdgeInsets.only(top: 100, bottom: 100),
                  child: Center(
                    child: Text(
                      FlutterI18n.translate(context, "No_Image_Selected"),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                )
              : Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Image.file(
                        imageFile,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 2,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: appTealColor.withOpacity(0.9),
                ),
                margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),

                child: IconButton(
                  icon: Icon(
                    Icons.crop,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _cropImage();
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: appTealColor.withOpacity(0.9),
                ),
                //  padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),

                child: IconButton(
                  icon: Icon(Icons.done, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      state = PhotoCrop.cropped;
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ); //Icon(Icons.crop);
    else if (state == PhotoCrop.cropped) {
      return GestureDetector(
          onTap: () {
            _pickImage();
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                child: ClipOval(
                  child: Image.file(
                    imageFile,
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 2,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black54,
                ),
              )
            ],
          ));
    } // imageFile != null ? Image.file(imageFile) : Container(); //Icon(Icons.clear);
    else
      return Container();
  }

  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (imageFile != null) {
      setState(() {
        state = PhotoCrop.picked;
      });
      uploadImage(imageFile);
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      // toolbarTitle: 'Cropper',
      // toolbarColor: Colors.blue,
      // toolbarWidgetColor: Colors.white,
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        // state = PhotoCrop.free;
        state = PhotoCrop.cropped;
      });
      uploadImage(imageFile);
    }
  }
  /////////////Croping Image method end///////////\

  void _updateProfile() async {
    if (!emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      return _showMsg("Email_is_invalid");
    }

    var data = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "mobile": mobileController.text,
      "house": houseController.text,
      "street": '',
      "road": roadController.text,
      "block": blockController.text,
      "area": areaController.text,
      "city": cityController.text,
      "state": stateController.text,
      "country": countryName,
      "profilepic": realImage,
    };

    print(data);

    setState(() {
      _isLoading = true;
    });
    var res =
        await CallApi().postData(data, '/app/updateUser?token=$usertoken');

    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', usertoken);
      localStorage.setString('loggedin-user', json.encode(data));
      _showMsg("Profile_information_saved_successfully");
      Navigator.pop(context);
      Navigator.push(context, new SlideLeftRoute(page: ProfileViewPage()));
    } else if (body['message'].contains('SQLSTATE[23000]')) {
      setState(() {
        print('object');
        _showMsg("Email_already_exists");
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
