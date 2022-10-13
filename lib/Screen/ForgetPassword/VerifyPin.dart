import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ForgetPassword/ForgetPassword.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class VerifyPin extends StatefulWidget {
  @override
  _VerifyPinState createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //elevation: 0,
          automaticallyImplyLeading: true,
          //             leading: Builder(
          //   builder: (BuildContext context) {
          //     return IconButton(
          //       icon: const Icon(Icons.arrow_back_ios,color:Color(0xFF01d56a),),
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //       },

          //     );
          //   },
          // ),
          title: Text(
             FlutterI18n.translate(context, "Submit_Your_Code"),
            
            style: TextStyle(
              color: Colors.white,
              // fontSize: 21.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: appTealColor,
          // centerTitle: true,
        ),
        // resizeToAvoidBottomPadding: false,
        //backgroundColor: Colors.white,
        body: VerifyPinForm());
  }
}

class VerifyPinForm extends StatefulWidget {
  @override
  _VerifyPinFormState createState() => _VerifyPinFormState();
}

class _VerifyPinFormState extends State<VerifyPinForm> {
  TextEditingController tokenController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 70, 10, 50),
        child: Container(
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 40),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,

                // width: 300,
                // color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        FlutterI18n.translate(context, "We_send_verification_code_to_your_email_Please_check_your_Email_and_enter_the_verification_code_here"),
            
                        
                        //textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'sourcesanspro',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /////////// Form Start//////////

              Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.only(top: 20),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        ///////////////// Email Textfield  Start///////////////
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextField(
                            style: TextStyle(color: Color(0xFF000000)),
                            cursorColor: Color(0xFF9b9b9b),
                            controller: tokenController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5))),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color(0xFFFFFFFF))),
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Color(0xFFFFFFFF))),
                              hintStyle: TextStyle(
                                  color: Color(0xFF9b9b9b),
                                  fontSize: 15,
                                  fontFamily: "sourcesanspro",
                                  fontWeight: FontWeight.normal),
                              contentPadding: EdgeInsets.only(
                                  left: 20, bottom: 12, top: 12),
                              fillColor: Colors.grey[200].withOpacity(0.5),
                              filled: true,
                              hintText:  FlutterI18n.translate(context, "verification_code"),
                            ),
                          ),
                        ),

                        ///////////////// Email Textfield  End///////////////
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    //height: 90,
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.yellow,
                    child: Column(
                      children: <Widget>[
                        ///////////////// Submit Button  Start///////////////

                        Container(
                            decoration: BoxDecoration(
                              color: appTealColor.withOpacity(0.9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: FlatButton(
                              child: Text(
                                FlutterI18n.translate(context, "Submit"),
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'MyriadPro',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              color: Colors.transparent,
                              //elevation: 4.0,
                              //splashColor: Colors.blueGrey,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              onPressed: () {
                                // _getValidMail();
                                Navigator.push(context,
                                    SlideLeftRoute(page: ForgetPassword()));
                                //  Navigator.push(context, SlideLeftRoute(page: VerifyPin()));
                              },
                            )),

                        ///////////////// Submit Button  End///////////////
                      ],
                    ),
                  )
                ],
              ))
              ///////////Form end///////////
            ],
          ),
        ),
      ),
    );
  }
  //  void _getValidMail() async {

  //      if(tokenController.text.isEmpty){
  //       return showMsg(context,"Verification Code is empty");
  //     }

  //     var data = {
  //     'token': tokenController.text,
  //   };

  //   var res = await CallApi().postData(data, 'auth/checkPasswordResetCode');
  //   var body = json.decode(res.body);
  //   print(body);
  //   if(body['success']==true){
  //  Navigator.push(context, SlideLeftRoute(page: ForgetPassword(tokenController.text)));

  //   }
  //    else{

  //     showMsg(context,"Verification Code doesn't match");
  //   }

  // }

}
