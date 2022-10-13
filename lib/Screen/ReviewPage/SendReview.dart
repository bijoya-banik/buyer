import 'package:ecommerce_bokkor_dev/Form/ReviewForm/ReviewForm.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SendReviewPage extends StatefulWidget {
  final productId;
  final orderId;
  final image;
  SendReviewPage(this.productId, this.orderId, this.image);
  @override
  _SendReviewPageState createState() => _SendReviewPageState();
}

class _SendReviewPageState extends State<SendReviewPage> {
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: appTealColor,
            //   elevation: 0,
            leading: GestureDetector(
              onTap: () {
                //   print("object");
                Navigator.of(context).pop();
              },
              child: Container(
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ),
            title: Text(
               FlutterI18n.translate(context,  "Review"),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: ReviewForm(widget.productId, widget.orderId, widget.image)),
    );
  }
}
