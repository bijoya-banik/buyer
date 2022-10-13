import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/NotificationOrderDetails/NotificationOrderDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderHistoryCardDetails.dart';
import 'package:ecommerce_bokkor_dev/model/NotificationModel/NotificationModel.dart';
import 'package:ecommerce_bokkor_dev/model/NotificationOrderModel/NotificationOrderModel.dart';
import 'package:ecommerce_bokkor_dev/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var body, body1, notificData, userToken;
  bool _notificLoading = true;
  bool _userLoading = true;
  bool _user = false;
  var orderData;

  @override
  void initState() {

    bottomNavIndex = 0;
    _getUserInfo();

    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
       
       // _notificLoading=true;
        _user = true;
         userToken = token;
      });
      _showAllNotifications();
    }
    else{
      
    }
    setState(() {
      _userLoading = false;
    });
    
  }

    Future _getLocalNotiData(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localOrderData = localStorage.getString(key);
    if (localOrderData != null) {
  
      body = json.decode(localOrderData);
        //  print(body);
      _orderState();
    }
  }

  Future<void> _showAllNotifications() async {
      var key = 'all-notifications-list';
    await _getLocalNotiData(key);

    var res = await CallApi().getData('/app/allNotification?token=$userToken');
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      _orderState();

       SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(key, json.encode(body));
    }
  }

  void _orderState() { 
    var notifis = NotificationModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      notificData = notifis.notification;
      _notificLoading = false;
    });
  }

    //////////////// get orders start ///////////////

  void _bestProductsState() {
    var orders = NotificationOrderModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      orderData = orders.order;
     // _isLoading = false;
    });



    // print("orders");
    // print(orderData);

   
       
     
  }

  Future<void> _goToOrder(int id) async {
    
    var key = 'notification-order';
   

    var res = await CallApi().getData('/app/showSingleOrder/$id?token=$userToken');
    body = json.decode(res.body);
   // print(body);
    if (res.statusCode == 200) {
    
      _bestProductsState();

      //  Navigator.push(context,
      //       SlideLeftRoute(page: OrderHistoryCardDetails(orderData)));

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(key, json.encode(body));
    }
  
  }

  //////////////// get orders end ///////////////

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: appTealColor,
        automaticallyImplyLeading: false,
        title:Text(FlutterI18n.translate(context, "Notification")),
      ),
      body:_userLoading?Center(
              child: CircularProgressIndicator(),
            ):
       !_user? Center(
                  child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(FlutterI18n.translate(context, "Login_to_your_account")),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, SlideLeftRoute(page: LogInPage(3)));
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: appTealColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(FlutterI18n.translate(context, "Login"),
                                style: TextStyle(color: Colors.white))),
                      )
                    ],
                  ),
                )):
      
     
          _notificLoading
          ? Center(
              child: CircularProgressIndicator(),
            ):  RefreshIndicator(
             onRefresh: _showAllNotifications,
            child: SafeArea(
                child: notificData.length == 0
                    ? Center(
                        child: Container(
                        child: Text(FlutterI18n.translate(context, "No_notifications_yet"),),
                      ))
                    : SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: List.generate(notificData.length, (index) {
                              return Container(
                                margin:
                                    EdgeInsets.only(bottom: 5, top: 0, left: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    

                                 //   print(notificData[index].id);
                               if( notificData[index].seen == 0) {
                                    updateNotify(notificData[index].id);
                               }
                                  
    if(notificData[index].type=="Order"){

            print("orderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");

                                      Navigator.push(context,
            SlideLeftRoute(page: NotificationOrderDetails(notificData[index].orderId, userToken)));
                                    
                                  }
                                  else{

                                 ///    print("discountttttttttttttttttttt");
                  
                                     Navigator.push(context,
                SlideLeftRoute(page: Navigation(0)));
                                    
                                  }

                                 

           
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 17,
                                          )
                                        ],
                                        color: notificData[index].seen == 1
                                            ? Colors.white:Color(0xFFEAF5FF)
                                             ),
                                    child: Column(
                                      children: <Widget>[ 
                                        Container(
                                          padding: EdgeInsets.only(bottom: 7),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(100),
                                                          border: Border.all(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey)),
                                                      alignment: Alignment.center,
                                                      margin: EdgeInsets.only(
                                                          right: 10.0, left: 10),
                                                      child: Icon(
                                                        Icons.notifications,
                                                        color: Colors.grey,
                                                        size: 17,
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.9,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "${notificData[index].title}",
                                                            // "${d.quantity}x ${d.item.name}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                color:
                                                                    appTealColor,
                                                                fontFamily:
                                                                    "sourcesanspro",
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.5,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5,
                                                                  bottom: 0),
                                                          child: Text(
                                                            "${notificData[index].msg}",
                                                            maxLines: 1,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            //  "\$${(d.item.price * d.quantity).toStringAsFixed(2)}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontFamily:
                                                                    "sourcesanspro",
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: 18,
                                                          color: appTealColor,
                                                        ),
                                                        onPressed: () {
                                                          _showDeleteAlert(index);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
              ),
          ),
    );
  }

  updateNotify(id) async {
    var data = {
      'id': id,
    };

    var res = await CallApi()
        .postData(data, '/app/notificationUpdate?token=$userToken');

    body1 = json.decode(res.body);

   // print(data);

   if (res.statusCode == 200) {
        store.dispatch(SeenNotificationAction(store.state.unseenState-1));
          
    // setState(() {
    //   _showAllNotifications();
    //    // _showToast();
    //  });

    // print(notificData[index].type);
    // print(notificData[index].id);

      
  }
  }

  deleteNotifyList(id) async {
    var data = {
      'id': id,
    };

    var res = await CallApi()
        .postData(data, '/app/deleteNotification?token=$userToken');

    body1 = json.decode(res.body);

    //print(data);

    if (res.statusCode == 200) {
      setState(() {
        _showAllNotifications();
        _showToast();
      });
    }
  }

  _showToast() {
    Fluttertoast.showToast(
        msg: FlutterI18n.translate(context, "Deleted_successfully"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: appTealColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }

  void _showDeleteAlert(int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            //    width: double.maxFinite,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //  color: Colors.red,
                  // width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 30),
                  // height: 40,
                  alignment: Alignment.center,

                  child: Text(
                    FlutterI18n.translate(context, "Are_you_sure_you_want_to_remove_this_item_from_notification"),
                    
                    textAlign: TextAlign.center,
                    //maxLines: 3,
                    style: TextStyle(
                        color: Color(0XFF414042),
                        fontFamily: "SourceSansPro",
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        deleteNotifyList(notificData[index].id);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: appTealColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child:
                            Text(FlutterI18n.translate(context, "Yes"), style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        width: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: appTealColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child:
                            Text(FlutterI18n.translate(context, "No"), style: TextStyle(color: appTealColor)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
