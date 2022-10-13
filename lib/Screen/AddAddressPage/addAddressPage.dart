
import 'package:ecommerce_bokkor_dev/Form/AddAddressForm/addAddressForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import '../../main.dart';


class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => new _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  Widget build(BuildContext context) {       
    return new Scaffold(   
      //backgroundColor: Colors.black,
      appBar: new AppBar(     
        backgroundColor: appTealColor,     
        title:  Text(FlutterI18n.translate(context, "Add_New_Address")),
      ),
      //body: new Text("It's a Dialog!"),
      body: SafeArea(               
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), 
          child: new Container(
              //padding: EdgeInsets.all(0.0),
              //color: Colors.white,
              child: AddAddressForm()),
        ),
      ),
    );
  }        
}                
