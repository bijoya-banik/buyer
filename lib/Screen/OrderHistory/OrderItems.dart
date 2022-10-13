import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ReviewPage/SendReview.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class OrderItem extends StatefulWidget {
  final orderdetails;
  final isReviewd;
  OrderItem(this.orderdetails, this.isReviewd);
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isLoading = true;
  var itemReview;

  @override
  void initState() {
    //_checkItemReview();
    // print(widget.isReviewd);
    // print(widget.orderdetails.isReviewed);
    super.initState();
  }

//   void _checkItemReview() async{

//    var res = await CallApi().getData('/app/order/getItemReview/${widget.orderedItem.id}?itemId=${widget.d.itemId}');
//     var collection = json.decode(res.body);
//     // print("driver");
//     // print(collection);
//     var orderItems = GetItemReview.fromJson(collection);

//  if (!mounted) return;
//     setState(() {
//        itemReview  = orderItems.isItemReviewGiven;
//       _isLoading = false;
//     });

//    // print(orderItems.isReviewCreated);
// }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.only(
        left: 5,
        top: 6,
      ),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5, left: 60),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 10.0),
                  child: ClipOval(
                      child: Image.network(
                    '${widget.orderdetails.product.image}',
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  )),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: Text(
                            "${widget.orderdetails.totalPrice} BHD",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: "DINPro",
                                fontSize: 13,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${widget.orderdetails.product.name}",
                            textDirection: TextDirection.ltr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "DINPro",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                                FlutterI18n.translate(context,"Quantity")+": ${widget.orderdetails.quantity}x",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: appColor,
                                    fontFamily: "DINPro",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal))),
                      ],
                    ),
                  ),
                ),
                widget.isReviewd != "Delivered"
                    ? Container()
                    : widget.orderdetails.isReviewed == 1
                        ? Container()
                        : Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: FlatButton(
                                      disabledColor: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: appTealColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          FlutterI18n.translate(context,"Submit_Review"),
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'MyriadPro',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(5.0)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            SlideLeftRoute(
                                                page: SendReviewPage(
                                                    widget.orderdetails.product
                                                        .id,
                                                    widget.orderdetails.orderId,
                                                    widget.orderdetails.product
                                                        .image)));
                                      }),
                                ),
                              ],
                            ),
                          )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
