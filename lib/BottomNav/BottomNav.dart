import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/CartPage/CartPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/HomePage/HomePage.dart';
import 'package:ecommerce_bokkor_dev/Screen/NotificationPage/NotificationPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProfilePage/ProfilePage.dart';
import 'package:ecommerce_bokkor_dev/Screen/WishList/WishList.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/redux/action.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

               
class Navigation extends StatefulWidget { 
  final page;
  Navigation(this.page);
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging(); 
  var userJson;
  int _currentIndex = bottomNavIndex;
  var body1, userToken;                              
  bool _fromTop = true;
  var body, count;
  bool _notificLoading = true;
  int notificCount = 0;

  int showNumber=0; 

  final children = [
    HomePage(),
    // CategoryPage(),
    WishList(),
    // EmptyCart(),
    CartPage(),
    ProfilePage(),
    NotificationPage(),
  ];
        
  @override
  void initState() {
    setState(() {
      bottomNavIndex = widget.page;
    });
    // print("bottomNavIndex");
    // print(bottomNavIndex);
    // print(notificCount);
    
    _getUserInfo();
    _addFirebase();
    
    super.initState();
  }

  void _addFirebase(){

/////// add firebase notification/////

   _firebaseMessaging.getToken().then((token) async {
      print("Notification token");
      print(token);
      
   });

 _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {

        print("onMessage: $message");
        
     setState(() {
   //   store.dispatch(UnseenNotificationAction(store.state.unseenState+1));
     //  showNumber = showNumber+1;
     notifyCount();
     _showNotificationPop(message['notification']['title'], message['notification']['body']);
     
     });
      }, 
      onLaunch: (Map<String, dynamic> message) async {
         //print("onLaunch: $message");
        pageLaunch(message);          
      },          
      onResume: (Map<String, dynamic> message) async {
         // print("onResume: $message");
       pageDirect(message);
      },
    );            
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

/////// end firebase notification/////



  }

  
///// handle looping onlaunch firebase //////
  void pageDirect(Map<String, dynamic> msg) {
    print("onResume: $msg");
    setState(() {
      index = 1;
    });
    Navigator.push(context, SlideLeftRoute(page: Navigation(4)));
  }

  void pageLaunch(Map<String, dynamic> msg) {
    print("onLaunch: $msg");  
    pageRedirect();
   
  }

  void pageRedirect() {
   

    if (index != 1 && index != 2) {
     
      Navigator.push(context, SlideLeftRoute(page: Navigation(4)));
      setState(() {
        index = 2;
      });
    }
  }

 ///// end handle looping onlaunch firebase //////

  Future<bool> _onWillPop() async {
    return (await showDialog(    
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(FlutterI18n.translate(context, "Exit")),
            content: new Text(FlutterI18n.translate(context, "Are_you_sure_you_want_to_exit_the_app")+'?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(FlutterI18n.translate(context, "No")),
              ),
              new FlatButton(
                onPressed: () {
                  if (Platform.isAndroid) {
                    exit(0); //SystemNavigator.pop();  
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                   // SystemChannels.platform.invokeMethod('SystemNavigator.pop'); 
                            
                },
                   
                child: new Text(FlutterI18n.translate(context, "Yes")),
              ),
            ],
          ),
        )) ??
        false;
  }
                  
  void _getUserInfo() async {
                                                           
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        userToken = token;
      });
    }
    //showNotifyListCount();
     notifyCount();
  }
                                                   
 showNotifyListCount() async {                               
    var res = await CallApi().getData1('/app/allnotificationUpdate?token=$userToken');

    body1 = json.decode(res.body);
    
   // print(body1);              
  
    if (res.statusCode == 200) {
      setState(() {
        print("done");
      });
    }
  }
 
 
   Future<void> notifyCount() async {
    var res = await CallApi().getData('/app/countUnseenNotification?token=$userToken');
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      _orderState();
    }
  }
  

    void _orderState() {
     
    if (!mounted) return;           
       
    setState(() { 
       notificCount = body["total"];
       store.dispatch(UnseenNotificationAction(notificCount));
        //  print("unseen");
        //  print(store.state.unseenState);
        //  print("seen");
        //  print(store.state.seenState);
         showNumber = store.state.unseenState - store.state.seenState;

       print("show numberrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
       print(showNumber);
       
         if(showNumber < 0){
           showNumber = 0;
         }            
      _notificLoading = false;
    });  
                  
      // print("count");   
      // print(notificCount);
  }             
                                    
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(    
        body: children[_currentIndex],        
        bottomNavigationBar: BottomNavigationBar(    
         type: BottomNavigationBarType.fixed,
          selectedItemColor: appTealColor,
          onTap: (int index) {
              
                       
            setState(() {       
              _currentIndex = index;
              bottomNavIndex = _currentIndex;
              if (_currentIndex == 4) {
                    store.dispatch(SeenNotificationAction(notificCount));
                    showNumber = 0;
                     // showNumber = store.state.unseenState - store.state.seenState;
                    //showNumber = 0;
                      print("show numberrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr 2");
                      print(showNumber);
              }  
            });
             print(showNumber);
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.home,
              ),
              title: Text(
                FlutterI18n.translate(context, "Home"),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.favorite,
              ),
              title: Text(
                FlutterI18n.translate(context, "WishList"),
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: new Icon(Icons.category),
            //   title: Text("Category",
            //   ),
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(
                FlutterI18n.translate(context, "Cart"),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text(
                FlutterI18n.translate(context, "Account"),
              ),
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: Stack(
                  children: <Widget>[
                    Center(child: Container(child: Icon(Icons.notifications))),
                    showNumber == 0
                        ? Center(child: Container())
                        :
                         Positioned(
                           bottom: 3,
                           left: 4,
                           right: 2,
                           child: Center(
                              child: Container(
                               // padding: EdgeInsets.all(2),
                                margin: EdgeInsets.only(left: 14, bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.circle,
                                   // borderRadius: BorderRadius.circular(5)
                                    ),
                                child: Padding(
                                  padding: showNumber<9? EdgeInsets.all(4.0):EdgeInsets.all(2.0) ,
                                  child: Text(
                                // "9",
                                  showNumber<9? '$showNumber':"9+",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(color: Colors.white, fontSize: 9),
                                  ),
                                ),
                              ),
                            ),
                         )
                  ],
                ),
              ),
              title: Text(
                FlutterI18n.translate(context, "Notification"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void onTabTapped(int bottomNavIndex) {
    
  //   setState(() {
  //     _currentIndex = bottomNavIndex;
  //   });

  //         if(bottomNavIndex==4){
  //   setState(() {
  //     // store.dispatch(UnseenNotificationAction(0));
  //    store.dispatch(SeenNotificationAction(notificCount));
  //    showNumber = 0;
    
  //  });

  //    }

  //     print(showNumber);

   
  // }

    void _showNotificationPop(String title, String msg){
 
     showGeneralDialog(
       
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 700),
          context: context,
          pageBuilder: (BuildContext context, anim1, anim2) {
          return GestureDetector(
               onTap: (){
                 Navigator.of(context).pop();
              Navigator.push(context, SlideLeftRoute(page: Navigation(4)));

          },
              child: Material(
                  type: MaterialType.transparency,
                child: Align(
                  alignment: _fromTop ? Alignment.topCenter : Alignment.bottomCenter,
                  child: GestureDetector(
                      onTap: (){
           
              Navigator.push(context, SlideLeftRoute(page: Navigation(4)));

          },
                    child:  ListView.builder(
                        itemCount: 1,
          itemBuilder: (context, index) {
          //  final item = items[index];

            return Dismissible(
              key: Key("item"),
              onDismissed: (direction){
                Navigator.of(context).pop();
                
              },
                      child: Container(
                       
                        height: 100,
                        child: SizedBox.expand(child:Container(
                            padding: EdgeInsets.only(left:15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ////////////   Address  start ///////////

                                ///////////// Address   ////////////

                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left:5, top: 2, bottom: 0),
                                    child: Text(title,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(color: appColor, fontSize: 16, fontWeight: FontWeight.bold))),
                                 Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 5, top: 2, bottom: 8),
                                    child: Text(msg,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(color: appColor, fontSize: 14,fontWeight: FontWeight.normal))),
                              ],
                            ),
                        )),
                        margin: EdgeInsets.only(top: 50, left: 12, right: 12, bottom: 50),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                     );
          },
                      ),
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position: Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0)).animate(anim1),
              child: child,
            );
          },
        );
}
}
