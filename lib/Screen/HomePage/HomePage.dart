import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/AllSearchPage/allSearchPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/BestSeller/PortraitBestSellerCard.dart';
import 'package:ecommerce_bokkor_dev/Screen/FeaturesProduct/PortraitFeaturedProduct.dart';
import 'package:ecommerce_bokkor_dev/Screen/Filter/Filter.dart';
import 'package:ecommerce_bokkor_dev/Screen/FlashSell/PortraitFlashSell.dart';
import 'package:ecommerce_bokkor_dev/Screen/NewArrival/PortraitNewArrival.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductBestSellPage/productBestSellPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/ProductDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductFeaturePage/productFeaturePage.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductFlashSellPage/productFlashSellPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductNewArrivalPage/productNewArrivalPage.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/model/AllProductModel/allProductModel.dart';
import 'package:ecommerce_bokkor_dev/model/BestSellerModel/bestSellerModel.dart';
import 'package:ecommerce_bokkor_dev/model/FlashSellModel/sellModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  bool _text = false;
  var bestSeller;
  var flashSellItem;
  var featuredProductsData;
  var newProductsData;
  bool _isLoading = true, isSearch = false, _isLoadingSearch = false;
  var body, user, data, imageBody;
  List filterList=[];
  List image = [];
  String curDate = "", search = "";
  var oldSearchText = "";

  @override
  void initState() {
    _getUserInfo();
    _currentDate();
    _showNewProducts();
    _showFeaturedProducts();
    _showBestProducts();
    _showFlashSells();
    _showImageSlider();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      var users = json.decode(userJson);
      setState(() {
        user = users;
      });
    }
    print("user");
    print(user);
  }

  _currentDate() {
    var now = new DateTime.now();
    var d1 = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    setState(() {
      curDate = d1;
    });
    print("object");
    print(d1);
  }

  /////// <<<<< New Products start >>>>> ///////
  Future<void> _showNewProducts() async {
    var key = 'best-products-list';
    await _getLocalFeaturedProductsData(key);

    var res = await CallApi().getData('/app/showNewProduct');
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      _newProductsState();

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(key, json.encode(body));
    }
  }

  void _newProductsState() {
    var newProducts = BestSellerModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      newProductsData = newProducts.product;
      if(newProductsData.length>0){
           newProductsData = newProductsData.toList();
      }
     
      _isLoading = false;
    });
  }

  ////// <<<<< New Products start >>>>> //////

  /////// <<<<< New Products start >>>>> ///////
  Future<void> _showFlashSells() async {
    var key = 'flash_sells';
    await _getLocalFeaturedProductsData(key);

    var res = await CallApi().getData('/app/showFlashsale?date=$curDate');
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      _flashSellState();

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(key, json.encode(body));
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  void _flashSellState() {
    var flashSell = SellModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      flashSellItem = flashSell.status;
      _isLoading = false;
    });

    if (flashSellItem != null) {
      DateTime d1 =
          DateTime.now(); //DateTime.parse('${flashSellItem.startTime}');
      DateTime d2 = DateTime.parse('${flashSellItem.endTime}');
      Duration dur = d2.difference(d1);

      print(dur);
      String duration = dur.toString();
      String time = "";
      String differenceInHours = "";
      String differenceInMins = "";
      String differenceInSec = "";

      if (duration.length > 0) {
        for (int i = 0; i < duration.length; i++) {
          if (duration[i] == ".") {
            break;
          } else {
            time = time + duration[i];
          }
        }
        // print(time);
      }

      List timeList = time.split(':');
      // print(timeList[0]);
      // print(timeList[1]);
      // print(timeList[2]);
      // print("New String: ${time.split(':')}");

      //  String difference = duration.toString();
      // String difference = (dur.inHours).toString();
      // print("differenceInHours");
      // print(difference);
      // var date = new DateTime.fromMillisecondsSinceEpoch(int.parse(dur.toString()) * 1000);

      //  var hours = (differenceInHours / 3600);
      //     var  minutes =(differenceInHours / (3600 * 60));
      //      var seconds = (differenceInHours % 60);

      //  print(hours);
      //  print(minutes);
      //  print(seconds);
      setState(() {
        hour = int.parse(timeList[0]);
        min = int.parse(timeList[1]);
        sec = int.parse(timeList[2]);
      });

      //     print("mli");
      //     print(d1);

      // new CountdownTimer(new Duration(hours: hour), new Duration(seconds: 1))
      //     .listen((data) {
      //   print('Something');
      //   print('Remaining time: ${data.remaining}');
      //   setState(() {
      //     remaining = "${data.remaining}";
      //   });
      // });
    }

    print(flashSellItem);
  }

  ////// <<<<< New Products start >>>>> //////

  /////////////// get featured Products start ///////////////

  Future _getLocalFeaturedProductsData(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localfeaturedProductsData = localStorage.getString(key);
    if (localfeaturedProductsData != null) {
      body = json.decode(localfeaturedProductsData);
      _featuredProductsState();
      //_isLoading = false;
    }
  }

  void _featuredProductsState() {
    var featuredProducts = BestSellerModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      featuredProductsData = featuredProducts.product;
      if(featuredProductsData!=null){
      featuredProductsData = featuredProductsData.reversed.toList();
      }
      _isLoading = false;
    });
  }

  Future<void> _showImageSlider() async {
    //var key = 'best-products-list';
    //await _getLocalFeaturedProductsData(key);

    var res = await CallApi().getData('/app/main_slider_all');
    imageBody = json.decode(res.body);

    if (res.statusCode == 200) {
      for (int i = 0; i < imageBody.length; i++) {

        if (!mounted) return;
        setState(() {
          image.add({
            "image": imageBody[i]['image'],
            "subHeader": imageBody[i]['subHeader'],
            "header": imageBody[i]['header'],
            "buttonText": imageBody[i]['buttonText'],
            "link": imageBody[i]['link'],
          });
        });
      }
    }
  }

  Future<void> _showFeaturedProducts() async {
    var key = 'best-products-list';
    await _getLocalFeaturedProductsData(key);

    var res = await CallApi().getData('/app/showFeaturedProduct');
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      _featuredProductsState();

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(key, json.encode(body));
    }
  }

  //////////////// get featured Products end /////////////

  /////////////// get best products start ///////////////

  Future _getLocalBestProductsData(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localbestProductsData = localStorage.getString(key);
    if (localbestProductsData != null) {
      body = json.decode(localbestProductsData);
      _bestProductsState();
    }
  }

  void _bestProductsState() {
    var bestProducts = BestSellerModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      bestSeller = bestProducts.product;

      if(bestSeller!=null){
          bestSeller = bestSeller.reversed.toList();
      }
      _isLoading = false;
    });
  }

  Future<void> _showBestProducts() async {
    var key = 'best-products-list';
    await _getLocalBestProductsData(key);

    var res = await CallApi().getData('/app/showBestSellerProduct');
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      _bestProductsState();

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(key, json.encode(body));
    }
  }  

  Future<void> getFilterData() async {
    print("searcjh vall");

   
     
    

 Future.delayed(Duration(seconds: 2), () async {
      print("This line is execute after 2 seconds");
     
    if(oldSearchText == search){
      print("match");
    }
    else{
       
    //      setState(() {      
    //   _isLoadingSearch = true;
    // });     
      oldSearchText = search;
     
      
    var res = await CallApi().getData(
        '/app/showProduct?max=&min=&cat=&sub=&ordercoloum=id&ordersort=desc&searchtext=$search');
   
   
    body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
      _getFilterlist();
    }    
    } 
    
   
       });
  }

  void _getFilterlist() {
    var newFilter = AllProductModel.fromJson(body);
    if (!mounted) return;
    setState(() { 
      filterList = newFilter.product;
      //  setState(() {
      _isLoadingSearch = false;
    // });
    });
  }

  //////////////// get best products end ///////////////

  Container shopNow(
      String image, String header, String buttonText, String link) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            //margin: EdgeInsets.only(left: 15, right: 15),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 180,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //             context, SlideLeftRoute(page: ProductsDetailsPage()));
            },
            child: Container(
              color: Colors.black38,
              padding: EdgeInsets.only(bottom: 15, right: 10),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                     header==null?"": header,
                      //textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //_launchURL(link);
                      Navigator.push(context,
                          SlideLeftRoute(page: ProductAllSearchPage()));
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(5),
                              //width: MediaQuery.of(context).size.width / 3 - 20,
                              alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.topLeft,
                                  stops: [0.1, 0.4, 0.6, 0.9],
                                    colors: [
                                    Colors.grey[400],
                                    Colors.grey[400],
                                    Colors.grey[300],
                                    Colors.grey[300],
                                  ],
                                ),
                              ),
                              //width: 320,
                              height: 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      buttonText==null?"":buttonText,
                                      //textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.black,
                                        size: 20,
                                      ))
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(FlutterI18n.translate(context, "Are_you_sure")+"?"),
            content: new Text(FlutterI18n.translate(context, "Do_you_want_to_exit_an_App")+"?"),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(FlutterI18n.translate(context, "No")),
              ),
              new FlatButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: new Text(FlutterI18n.translate(context, "Yes")),
              ),
            ],
          ),
        )) ??
        false;
  }

  imageCarousel() {
    return Container(
      child: image.length == 0
          ? Container(
              height: 180,
              child: Center(child: CircularProgressIndicator()),
            )
          : CarouselSlider(
              height: 180.0,
              //initialPage: 0,
              enlargeCenterPage: false,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              autoPlayInterval: Duration(seconds: 8),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 5),
              scrollDirection: Axis.horizontal,
              // onPageChanged: (index) {
              //   setState(() {
              //     //_current = index;
              //   });
              // },
              items: image.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      //margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          //viewImage(_current);
                        },
                        child: shopNow(imgUrl['image'], imgUrl['header'],
                            imgUrl['buttonText'], imgUrl['link']),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appTealColor,
        actions: <Widget>[
          ////////  search bar and filter  start  //////////////
          Container(
            height: 60.0,
            color: appTealColor,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isSearch == false
                    ? Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              FlutterI18n.translate(context, "Homepage"),
                            
                              style: TextStyle(fontSize: 18),
                            )),
                      )
                    : Flexible(
                        child: Container(
                          height: 50.0,
                          margin: EdgeInsets.only(right: 10, left: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.white),
                          child: TextField(
                            cursorColor: appGreyDarkColor,
                            controller: searchController,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: appTealColor,
                              ),
                              hintText:  FlutterI18n.translate(context, "Search_by_id_name"),
                              hintStyle: TextStyle(color: appGreyDarkColor),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 5.0, top: 8.0),
                              suffixIcon: search != ""
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          searchController.text = "";
                                          search = "";
                                          oldSearchText = "";
                                        });
                                      },
                                      icon: Icon(Icons.cancel),
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.cancel,
                                      color: Colors.transparent,
                                    ),
                            ),
                            onChanged: (val) {
                           
                              setState(() {
                               search = val;
                               filterList.clear();
                               _isLoadingSearch = true;
                                //  _searchShop();
                               // filterList.clear();
                               
                                getFilterData();
                              });
                            },
                          ),
                        ),
                      ),
                //////////////  filter start /////////////
                Container(
                  height: 45.0,
                  padding: EdgeInsets.only(bottom: 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSearch == false) {
                          isSearch = true;
                        } else {
                          isSearch = false;
                        }
                      });
                      // Navigator.push(context,
                      //     SlideLeftRoute(page: ProductAllSearchPage()));
                      // Navigator.push(
                      //     context, SlideLeftRoute(page: FilterDialog()));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(6)),
                      child: Icon(isSearch == true ? Icons.close : Icons.search,
                          color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, SlideLeftRoute(page: ProductAllSearchPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            FlutterI18n.translate(context, "See_All_Products"),
                            
                            style: TextStyle(fontSize: 11),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 13,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          ////////  search bar end  //////////////
        ],
      ),
      body: SafeArea(
        child: (newProductsData == null &&
                    flashSellItem == null &&
                    featuredProductsData == null &&
                    bestSeller == null) ||
                _isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Color(0xFFFFFFFF),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Stack(
                      children: <Widget>[
                        isSearch == false
                            ? Column(
                                children: <Widget>[
                                  //////////  landing page slider start ///////

                                  imageCarousel(),

                                  //////////  landing page slider end ///////

                                  ///////// New Arrival //////
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 25, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            FlutterI18n.translate(context, "New_Arrival"),
                                            
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0XFF09324B),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 15),
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  SlideLeftRoute(
                                                      page:
                                                          ProductNewArrivalPage()));
                                              //_filterPage();
                                            },
                                            child: Text(
                                               FlutterI18n.translate(context, "See_All"),
                                              
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0XFF09324B)
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //     child: Icon(
                                        //   Icons.keyboard_arrow_right,
                                        //   color: Color(0XFF09324B),
                                        //   size: 20,
                                        // )),
                                      ],
                                    ),
                                  ),

                                  ///////// New Arrival List //////

                                  newProductsData == null
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : newProductsData.length == 0
                                          ? Center(
                                              child: Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text(
                                                 FlutterI18n.translate(context, "No_new_arrival_products")+"!",
                                                  ),
                                            ))
                                          : Container(
                                              height: 200,
                                              //color: Colors.red,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.only(left: 8),
                                              child:
                                                  //   MediaQuery.of(context).orientation ==
                                                  //     Orientation.portrait
                                                  // ?

                                                  /////////// New Arrival Portrait start //////

                                                  ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5,
                                                      top: 0,
                                                      left: 3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                  ),
                                                  child: ProtraitNewArrivalCard(
                                                      user,
                                                      newProductsData[index]),
                                                ),
                                                itemCount:
                                                    newProductsData.length,
                                              )),

                                  ///////// Flash Sell //////
                                  flashSellItem == null
                                      ? Container()
                                      : Container(
                                          margin: EdgeInsets.only(
                                              top: 25, bottom: 10),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        FlutterI18n.translate(context, "Flash_Sale"),
                                                        
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Color(
                                                                0XFF09324B),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 15),
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              SlideLeftRoute(
                                                                  page: ProductFlashSellPage(
                                                                      flashSellItem
                                                                          .id)));
                                                          //_filterPage();
                                                        },
                                                        child: Text(
                                                          
                                                          FlutterI18n.translate(context, "See_All"),

                                                          
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                      0XFF09324B)
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                margin: EdgeInsets.only(
                                                    bottom: 5,
                                                    left: 20,
                                                    top: 10),
                                                child: Row(
                                                  children: <Widget>[
                                                    CountdownFormatted(
                                                      duration: Duration(
                                                          hours: hour,
                                                          minutes: min,
                                                          seconds: sec),
                                                      onFinish: () {
                                                        setState(() {
                                                          flashSellItem = null;
                                                        });
                                                      },
                                                      builder: (BuildContext
                                                              ctx,
                                                          String remaining) {
                                                        return Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    appTealColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color:
                                                                        appTealColor)),
                                                            child: Text(
                                                              //  '${remaining.inHours}:${remaining.inMinutes}:${remaining.inSeconds}',
                                                              remaining,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )); // 01:00:00
                                                      },
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        "${flashSellItem.name}",
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                  ///////// Flash Sell List //////

                                  flashSellItem == null
                                      ? Container()
                                      : Container(
                                          height: 180,
                                          margin: EdgeInsets.only(left: 8),
                                          width:MediaQuery.of(context).size.width, 
                                          /////////// Flash Sell Portrait start //////

                                           child: ListView.builder(   
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>                                    
                                                Container(
                                              margin: EdgeInsets.only(bottom: 5, top: 0, left: 3),
                                              decoration: BoxDecoration(
                                                color: Colors.white,

                                                borderRadius: BorderRadius.only(
                                                         
                                                     bottomLeft: Radius.circular(10),
                                                    bottomRight:Radius.circular(10)
                                                                                                         
                                                    ),
                                              ),       
                                              child: PortraitFlashSellCard(
                                                  user,
                                                  flashSellItem.products[index]),
                                            ),
                                            itemCount:
                                                flashSellItem.products.length,
                                          )),

                                  ///////// Featured Products  start//////
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 25, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 20),
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                
                                                FlutterI18n.translate(context, "Featured_Product"),

                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0XFF09324B),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      SlideLeftRoute(
                                                          page:
                                                              ProductFeaturePage()));
                                                  //_filterPage();
                                                },
                                                child: Text(
                                                  FlutterI18n.translate(context, "See_All"),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0XFF09324B)
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///////// Featured Products List //////

                                      featuredProductsData == null
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : featuredProductsData.length == 0
                                              ? Center(
                                                  child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    FlutterI18n.translate(context, "No_featured_products"),
                                                      ),
                                                ))
                                              : Container(
                                                  height: 200,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin:
                                                      EdgeInsets.only(left: 8),
                                                  child:

                                                      /////////// Featured Products Portrait start //////

                                                      ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 5,
                                                          top: 0,
                                                          left: 3),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10)),
                                                      ),
                                                      child: PortraitFeaturedProductsCard(
                                                          user,
                                                          featuredProductsData[
                                                              index]),
                                                    ),
                                                    itemCount:
                                                        featuredProductsData
                                                            .length,
                                                  )),

                                      /////////// Featured Products end//////
                                    ],
                                  ),

                                  //////////   Featured Products end /////////////

                                  ///////// Best Seller  start//////
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 25, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 20),
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                FlutterI18n.translate(context, "Best_Seller"),
                                                
                                                maxLines: 1,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0XFF09324B),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      SlideLeftRoute(
                                                          page:
                                                              ProductBestSellPage()));
                                                  // _filterPage();
                                                },
                                                child: Text(
                                                  FlutterI18n.translate(context, "See_All"),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0XFF09324B)
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///////// Best Seller List //////

                                      bestSeller == null
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : bestSeller.length == 0
                                              ? Center(
                                                  child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    FlutterI18n.translate(context, "No_best_seller_products"),
                                                      ),
                                                ))
                                              : Container(
                                                  height: 200,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin:
                                                      EdgeInsets.only(left: 8),
                                                  child:

                                                      /////////// Best Seller Portrait start //////

                                                      ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 5,
                                                          top: 0,
                                                          left: 3),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10)),
                                                      ),
                                                      child:
                                                          PortraitBestSellerCard(
                                                              user,
                                                              bestSeller[
                                                                  index]),
                                                    ),
                                                    itemCount:
                                                        bestSeller.length,
                                                  )

                                                  //  /////////// Best Seller Landscape end//////
                                                  ),

                                      /////////// Best Seller end//////
                                    ],
                                  ),

                                  //////////   Latest Products end /////////////
                                ],
                              )
                            // isSearch == false
                            //     ? Container()
                            : search == ""
                                ? Container(
                                    alignment: Alignment.topCenter,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                              'assets/images/search.png',
                                              height: 130,
                                              width: 120,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(),
                                              child: Text(
                                                FlutterI18n.translate(context, "Search_products_here"),
                                                
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ]))
                                : Center(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(
                                              left: 9, right: 52),
                                          color: Colors.white,
                                          //height: 230,
                                          child: _isLoadingSearch == true
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5,
                                                      top: 0,
                                                      left: 10,
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                  ),
                                                  child: Center(
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(
                                                            FlutterI18n.translate(context, "Please_wait")+"...",
                                                           
                                                          ))))
                                              : filterList== null || filterList.length == 0
                                                  ? Center(
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(
                                                            FlutterI18n.translate(context, "No_products_found"),
                                                            
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          )))
                                                  : SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Column(
                                                        children: List.generate(
                                                            filterList.length,
                                                            (index) {
                                                          return Container(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom: 5,
                                                                      top: 0,
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10)),
                                                              ),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    isSearch =
                                                                        false;
                                                                    searchController
                                                                        .text = "";
                                                                    search = "";
                                                                    oldSearchText = "";
                                                                  });
                                                                  getFilterData();
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => ProductsDetailsPage(
                                                                              filterList[index].id,
                                                                              1)));
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          7,
                                                                          0,
                                                                          0),
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.grey[300],
                                                                              blurRadius: 17,
                                                                            )
                                                                          ],
                                                                          color:
                                                                              Colors.white),
                                                                  child: Column(
                                                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 7),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              // color: Colors.teal,
                                                                              child: Row(
                                                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    alignment: Alignment.center,
                                                                                    margin: EdgeInsets.only(right: 10.0, left: 10),
                                                                                    child: filterList[index].image==null ||filterList[index].image==""?
                                                                                    Container():
                                                                                     ClipOval(
                                                                                        child: Image.network(
                                                                                      filterList == null ? '' : '${filterList[index].image}',
                                                                                      height: 40,
                                                                                      width: 40,
                                                                                      fit: BoxFit.cover,
                                                                                    )),
                                                                                  ),
                                                                                  Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width / 1.9,
                                                                                        padding: EdgeInsets.only(top: 8),
                                                                                        child: Text(
                                                                                           FlutterI18n.translate(context, "Product_id")+" #${filterList[index].id}",
                                                                                          // "${d.quantity}x ${d.item.name}",
                                                                                          textAlign: TextAlign.left,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(color: appTealColor, fontFamily: "sourcesanspro", fontSize: 12, fontWeight: FontWeight.normal),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width / 1.9,
                                                                                        padding: EdgeInsets.only(top: 3),
                                                                                        child: Text(
                                                                                          "${filterList[index].name}",
                                                                                          // "${d.quantity}x ${d.item.name}",
                                                                                          textAlign: TextAlign.left,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(color: Colors.black, fontFamily: "sourcesanspro", fontSize: 16, fontWeight: FontWeight.normal),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     setState(() {
                                        //       isSearch = false;
                                        //     });

                                        //     Navigator.push(
                                        //         context,
                                        //         SlideLeftRoute(
                                        //             page:
                                        //                 ProductAllSearchPage()));
                                        //   },
                                        //   child: Container(
                                        //       child: Stack(
                                        //     children: <Widget>[
                                        //       Container(
                                        //           width: MediaQuery.of(context)
                                        //               .size
                                        //               .width,
                                        //           margin: EdgeInsets.only(
                                        //               left: 11, right: 52),
                                        //           padding: EdgeInsets.all(10),
                                        //           color: Colors.white,
                                        //           child: Row(
                                        //             mainAxisAlignment:
                                        //                 MainAxisAlignment
                                        //                     .center,
                                        //             children: <Widget>[
                                        //               Container(
                                        //                 margin: EdgeInsets.only(
                                        //                     right: 2),
                                        //                 child: Text(
                                        //                   "",
                                        //                   textAlign:
                                        //                       TextAlign.center,
                                        //                   style: TextStyle(
                                        //                       color:
                                        //                           Colors.white),
                                        //                 ),
                                        //               ),
                                        //               Icon(
                                        //                 Icons.arrow_forward,
                                        //                 color: Colors.white,
                                        //                 size: 14,
                                        //               )
                                        //             ],
                                        //           )),
                                        //       Container(
                                        //           width: MediaQuery.of(context)
                                        //               .size
                                        //               .width,
                                        //           margin: EdgeInsets.only(
                                        //               left: 11, right: 52),
                                        //           padding: EdgeInsets.all(10),
                                        //           color: appTealColor
                                        //               .withOpacity(0.8),
                                        //           child: Row(
                                        //             mainAxisAlignment:
                                        //                 MainAxisAlignment
                                        //                     .center,
                                        //             children: <Widget>[
                                        //               Container(
                                        //                 margin: EdgeInsets.only(
                                        //                     right: 2),
                                        //                 child: Text(
                                        //                   "See more",
                                        //                   textAlign:
                                        //                       TextAlign.center,
                                        //                   style: TextStyle(
                                        //                       color:
                                        //                           Colors.white),
                                        //                 ),
                                        //               ),
                                        //               Icon(
                                        //                 Icons.arrow_forward,
                                        //                 color: Colors.white,
                                        //                 size: 14,
                                        //               )
                                        //             ],
                                        //           )),
                                        //     ],
                                        //   )),
                                        // )
                                      ],
                                    ),
                                  )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void _filterPage() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new FilterDialog();
        },
        fullscreenDialog: true));
  }
}
