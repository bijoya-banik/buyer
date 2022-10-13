//import 'package:chewie/chewie.dart';
import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ReviewPage/ReviewPage.dart';
import 'package:ecommerce_bokkor_dev/model/ProductDetailsModel/productDetailsModel.dart';
import 'package:ecommerce_bokkor_dev/model/WishlistModel/wishlistModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import '../../main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WishDetailsPage extends StatefulWidget {
  final id;
  WishDetailsPage(this.id);
  @override
  State<StatefulWidget> createState() {
    return WishDetailsPageState();
  }
}

class WishDetailsPageState extends State<WishDetailsPage>
    with TickerProviderStateMixin {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  //ChewieController _chewieController;

  TextEditingController _reviewController = TextEditingController();
  Animation<double> animation;
  AnimationController controller;
  bool _isLoggedIn = false;
  String _debugLabelString = "",
      review = '',
      _ratingStatus = '',
      size = "",
      color = "",
      combo = "",
      userToken = "";
  bool _requireConsent = false;
  int _current = 0,
      active = 0,
      discount = 0,
      stock = 0,
      comboId = 0,
      last = 1,
      first = 1,
      quantity = 0;
  int c1 = 0, c2 = 0, idx = 0;
  double price = 0.0, rating = 0.0, initPrice = 0.0;
  bool _isadd = false;
  bool _isLoading = true;
  bool _loading = false;
  bool _isWishlisted = false;
  bool _isVideo = false;
  bool _isImage = false;
  bool _isShow = false;
  var body;
  var detailsProduct;
  var key = 'cart-list', cartkey = "my-cart-list";
  List<String> selectedSize = [],
      selectedColor = [],
      sizeSelected = [],
      colorSelected = [];

  List cartList = [], myCart = [];
  List imgList = [];
  List vidList = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  /////////////// get featured Products start ///////////////

  void _productsDetailsState() {
    var detProducts = WishlistModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      detailsProduct = detProducts.status;
      discount = detailsProduct[0].product.discount;
      String pr = detailsProduct[0].product.price;
      double prices = double.parse(pr);
      double dis = discount / 100;
      double pp = prices.toDouble();
      price = (pp * dis);
      price = prices - price;
      if (detailsProduct[0].product.average != null) {
        String rate = detailsProduct[0].product.average.averageRating;
        rating = double.parse(rate);
      }
      String rr = rating.toStringAsFixed(1);
      rating = double.parse(rr);

      for (int i = 0;
          i < detailsProduct[0].product.product_variable.length;
          i++) {
        if (detailsProduct[0].product.product_variable[i].name == "Size") {
          for (int j = 0;
              j < detailsProduct[0].product.product_variable[i].values.length;
              j++) {
            selectedSize.add(
                detailsProduct[0].product.product_variable[i].values[j].value);
          }
        }
      }

      for (int i = 0;
          i < detailsProduct[0].product.product_variable.length;
          i++) {
        if (detailsProduct[0].product.product_variable[i].name == "Colour") {
          for (int j = 0;
              j < detailsProduct[0].product.product_variable[i].values.length;
              j++) {
            selectedColor.add(
                detailsProduct[0].product.product_variable[i].values[j].value);
          }
        }
      }

      if (detailsProduct[0].product.photo.length == 0) {
        _isImage = false;
      } else {
        _isImage = true;

        for (int i = 0; i < detailsProduct[0].product.photo.length; i++) {
          imgList.add(detailsProduct[0].product.photo[i].link);
        }
      }

      if (detailsProduct[0].product.video.length == 0) {
        _isVideo = false;
      } else {
        _isVideo = true;
        for (int i = 0; i < detailsProduct[0].product.video.length; i++) {
          vidList.add("${detailsProduct[0].product.video[i].link}");
          playVideo('${vidList[idx]}');
          // print(detailsProduct[0].video[i].link);
        }
      }

      String ppi = detailsProduct[0].product.price;

      initPrice = double.parse(ppi);

      _isLoading = false;
    });
  }

  Future<void> _showProductsDetails() async {
    var res = await CallApi().getData('/app/showSingleWishlist/${widget.id}');
    body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
      _productsDetailsState();
    }
  }

  //////////////// get featured Products end /////////////

  @override
  void initState() {
    _getUserInfo();
    getcartList(key);
    getmycartList(cartkey);
    _showProductsDetails();
    active = _current + 1;
    playVideo(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    super.initState();
  }

  void playVideo(String link) {
    _controller = VideoPlayerController.network(
        //'https://www.youtube.com/watch?v=_SBucsSIkBU',
        link);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  void getcartList(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var cartsList = localStorage.getString(key);
    setState(() {
      if (cartsList != null) {
        cartList = json.decode(cartsList);
      }

      print("cartList");
      print(cartList);
      print(cartList.length);
    });
  }

  void getmycartList(cartkey) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var mycartsList = localStorage.getString(cartkey);
    setState(() {
      if (mycartsList != null) {
        myCart = json.decode(mycartsList);
      }

      print("myCart");
      print(myCart);
      print(myCart.length);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    //_chewieController.dispose();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    userToken = token;
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
    print(_isLoggedIn);
  }

  int _rating = 0;

  void rate(int rating) {
    //Other actions based on rating such as api calls.
    setState(() {
      _rating = rating;
    });

    if (rating == 1) {
      _ratingStatus = FlutterI18n.translate(context,  "Poor");
    }
    if (rating == 2) {
      _ratingStatus = FlutterI18n.translate(context,  "Average");
    }
    if (rating == 3) {
      _ratingStatus = FlutterI18n.translate(context,  "Good");
    }
    if (rating == 4) {
      _ratingStatus = FlutterI18n.translate(context,  "Very Good");
    }
    if (rating == 5) {
      _ratingStatus = FlutterI18n.translate(context,  "Excellent");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        titleSpacing: 8,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 35.0,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: appTealColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context,  "Product_Details"),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            _isVideo == true && _isImage == true && _isShow == false
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _isShow = true;
                      });
                    },
                    child: Container(
                      child: Text(
                        FlutterI18n.translate(context,  "See_Video"),
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      body: _buildProductDetailsPage(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  _buildProductDetailsPage(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildProductImagesWidgets(),
                _buildProductTitleWidget(),
                SizedBox(height: 12.0),
                _buildPriceWidgets(),
                SizedBox(height: 12.0),
                _buildDivider(screenSize),
                SizedBox(height: 12.0),
                _buildSizeChartWidgets(),
                _buildDivider(screenSize),
                _buildSizeList(),
                SizedBox(height: 12.0),
                _buildColorChartWidgets(),
                _buildDivider(screenSize),
                _buildColorList(),
                SizedBox(height: 12.0),
                _buildStyleNoteHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildStyleNoteData(),
                SizedBox(height: 20.0),
                _buildMoreInfoHeader(),
                SizedBox(height: 6.0),
                _buildDivider(screenSize),
                SizedBox(height: 4.0),
                _buildMoreInfoData(),
                SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[600],
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildProductImagesWidgets() {
    return Container(
        child: _isVideo == true && _isImage == true && _isShow == false
            ? imgList.length == 0
                ? Center(child: CircularProgressIndicator())
                : Stack(
                    children: <Widget>[
                      CarouselSlider(
                        height: 250.0,
                        //initialPage: 0,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        reverse: false,
                        enableInfiniteScroll: true,
                        viewportFraction: 1.0,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(milliseconds: 2000),
                        pauseAutoPlayOnTouch: Duration(seconds: 10),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          setState(() {
                            _current = index;
                          });
                        },
                        items: imgList.map((imgUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    //viewImage(_current);
                                  },
                                  child: Image.network(
                                    imgUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.black,
                              child: Text(
                                "${_current + 1}/${imgList.length}",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "Oswald"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
            : _isVideo == false && _isImage == true && _isShow == false
                ? imgList.length == 0
                    ? Center(child: CircularProgressIndicator())
                    : Stack(
                        children: <Widget>[
                          CarouselSlider(
                            height: 250.0,
                            //initialPage: 0,
                            enlargeCenterPage: true,
                            autoPlay: false,
                            reverse: false,
                            enableInfiniteScroll: true,
                            viewportFraction: 1.0,
                            autoPlayInterval: Duration(seconds: 2),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 2000),
                            pauseAutoPlayOnTouch: Duration(seconds: 10),
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index) {
                              setState(() {
                                _current = index;
                              });
                            },
                            items: imgList.map((imgUrl) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        //viewImage(_current);
                                      },
                                      child: Image.network(
                                        imgUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  color: Colors.black,
                                  child: Text(
                                    "${_current + 1}/${imgList.length}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Oswald"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          // If the video is paused, play it.
                          _controller.play();
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Stack(
                        children: <Widget>[
                          FutureBuilder(
                            future: _initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return VideoPlayer(_controller);
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                          _isVideo == true &&
                                  _isImage == false &&
                                  _isShow == false
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isShow = false;
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Icon(
                                          Icons.close,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                          _controller.value.isPlaying
                              ? Container()
                              : Center(
                                  child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    vidList.length == 1
                                        ? Container()
                                        : idx < 0
                                            ? Container()
                                            : Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      //c1 = 0;
                                                      idx--;
                                                      first--;
                                                      if (idx <= 0) {
                                                        idx = 0;
                                                      }
                                                      idx < 0
                                                          ? null
                                                          : playVideo(
                                                              vidList[idx]);
                                                    });
                                                    print(idx);
                                                  },
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Icon(
                                                        Icons.chevron_left,
                                                        color: idx == 0
                                                            ? Colors.transparent
                                                            : Colors.white,
                                                        size: 45),
                                                  ),
                                                ),
                                              ),
                                    Icon(Icons.play_arrow,
                                        color: Colors.white, size: 45),
                                    vidList.length == 1
                                        ? Container()
                                        : last > vidList.length
                                            ? Container()
                                            : Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      //c2 = 0;
                                                      idx++;

                                                      print("idx");
                                                      print(idx);
                                                      print(
                                                          "vidList.length - 1");
                                                      print(vidList.length - 1);
                                                      if (idx >=
                                                          vidList.length - 1) {
                                                        last = vidList.length;
                                                        idx =
                                                            vidList.length - 1;
                                                        // playVideo(
                                                        //     vidList[vidList.length - 1]);
                                                      }
                                                      idx > vidList.length - 1
                                                          ? null
                                                          : playVideo(
                                                              vidList[idx]);
                                                    });
                                                    print(idx);
                                                  },
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Icon(
                                                        Icons.chevron_right,
                                                        color: idx ==
                                                                vidList.length -
                                                                    1
                                                            ? Colors.transparent
                                                            : Colors.white,
                                                        size: 45),
                                                  ),
                                                ),
                                              ),
                                  ],
                                ))
                        ],
                      ),
                    ),
                  ));
  }

  _buildProductTitleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          //name,
          detailsProduct == null ? "" : "${detailsProduct[0].product.name}",
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
    );
  }

  _buildPriceWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  detailsProduct == null
                      ? ""
                      : detailsProduct[0].product.discount == 0
                          ? "\$${detailsProduct[0].product.price}"
                          : "\$${price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 8.0,
                ),
                detailsProduct == null
                    ? Container()
                    : detailsProduct[0].product.discount == 0
                        ? Container()
                        : Text(
                            "\$${detailsProduct[0].product.price}",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                SizedBox(
                  width: 8.0,
                ),
                detailsProduct == null
                    ? Container()
                    : detailsProduct[0].product.discount == 0
                        ? Container()
                        : Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.blue[700],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "${detailsProduct[0].product.discount}%"+ FlutterI18n.translate(context,  "Off") ,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0, top: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Container(
              padding: EdgeInsets.all(3),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity--;
                        if (quantity <= 0) {
                          quantity = 0;
                        }
                      });
                    },
                    child: Container(
                      child: Icon(
                        Icons.remove,
                        color: appTealColor,
                        //size: 14,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3, left: 10, right: 10),
                    child: Text(
                      "$quantity",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "sourcesanspro",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    child: Container(
                      child: Icon(
                        Icons.add,
                        color: appTealColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSizeChartWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.straighten,
                  color: Colors.grey[600],
                ),
                SizedBox(
                  width: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      FlutterI18n.translate(context, "Size"),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                       " ("+FlutterI18n.translate(context, "Select_one")+")",
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "${selectedSize.length}"+FlutterI18n.translate(context, "available_sizes") ,
              style: TextStyle(
                color: Colors.blue[400],
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSizeList() {
    return selectedSize.length == 0
        ? Container()
        : Container(
            height: 40,
            decoration: BoxDecoration(color: Colors.white),
            margin: EdgeInsets.only(top: 0, bottom: 10),
            padding: EdgeInsets.only(left: 10),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: selectedSize.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (sizeSelected == null) {
                        sizeSelected.insert(0, "${selectedSize[index]}");
                        size = "${selectedSize[index]}";
                      } else {
                        if (sizeSelected.contains(selectedSize[index])) {
                          sizeSelected.remove(selectedSize[index]);
                          size = "";
                        } else {
                          sizeSelected.length = 0;
                          size = "";
                          sizeSelected.insert(0, "${selectedSize[index]}");
                          size = "${selectedSize[index]}";
                        }
                      }
                      combo = "";
                    });
                    comboCheck();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: sizeSelected.contains(selectedSize[index])
                              ? appTealColor.withOpacity(0.4)
                              : Colors.grey[50],
                          borderRadius: BorderRadius.circular(10)),
                      margin:
                          EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "${selectedSize[index]}",
                            style: TextStyle(
                                fontSize: 15,
                                color:
                                    sizeSelected.contains(selectedSize[index])
                                        ? Colors.white
                                        : Colors.black45),
                          ),
                          sizeSelected.contains(selectedSize[index])
                              ? Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.done,
                                    size: 15,
                                    color: sizeSelected
                                            .contains(selectedSize[index])
                                        ? Colors.white
                                        : Colors.black45,
                                  ),
                                )
                              : Container()
                        ],
                      )),
                );
              },
            ),
          );
  }

  _buildColorChartWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.color_lens,
                  color: Colors.grey[600],
                ),
                SizedBox(
                  width: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      FlutterI18n.translate(context, "Color"),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      " ("+FlutterI18n.translate(context, "Select_one")+")",
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "${selectedColor.length}"+FlutterI18n.translate(context, "available_colors") ,
              style: TextStyle(
                color: Colors.blue[400],
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  comboCheck() {
    String com = "$size-$color";
    if (detailsProduct[0].product.product_vc.length == 0) {
      setState(() {
        combo = "";
        stock = detailsProduct[0].product.stock;
      });
    } else {
      if (size == "" && color == "") {
        setState(() {
          combo = "";
          stock = detailsProduct[0].product.stock;
        });
      } else {
        for (int i = 0; i < detailsProduct[0].product.product_vc.length; i++) {
          if (detailsProduct[0].product.product_vc[i].combination == com &&
              detailsProduct[0].product.product_vc[i].stock != 0) {
            setState(() {
              combo = "1";
              comboId = detailsProduct[0].product.product_vc[i].id;
              stock = detailsProduct[0].product.product_vc[i].stock;
            });
          }
        }
      }
    }
    print(combo);
  }

  _buildColorList() {
    return selectedColor.length == 0
        ? Container()
        : Container(
            height: 50,
            decoration: BoxDecoration(color: Colors.white),
            margin: EdgeInsets.only(top: 0, bottom: 5),
            padding: EdgeInsets.only(left: 10),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: selectedColor.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (colorSelected == null) {
                        colorSelected.insert(0, "${selectedColor[index]}");
                        color = "${selectedColor[index]}";
                      } else {
                        if (colorSelected.contains(selectedColor[index])) {
                          colorSelected.remove(selectedColor[index]);
                          color = "";
                        } else {
                          colorSelected.length = 0;
                          color = "";
                          colorSelected.insert(0, "${selectedColor[index]}");
                          color = "${selectedColor[index]}";
                        }
                      }
                      combo = "";
                    });
                    comboCheck();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: colorSelected.contains(selectedColor[index])
                              ? appColor.withOpacity(0.4)
                              : Colors.grey[50],
                          borderRadius: BorderRadius.circular(10)),
                      margin:
                          EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "${selectedColor[index]}",
                            style: TextStyle(
                                fontSize: 15,
                                color:
                                    colorSelected.contains(selectedColor[index])
                                        ? Colors.white
                                        : Colors.black45),
                          ),
                          colorSelected.contains(selectedColor[index])
                              ? Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.done,
                                    size: 15,
                                    color: colorSelected
                                            .contains(selectedColor[index])
                                        ? Colors.white
                                        : Colors.black45,
                                  ),
                                )
                              : Container()
                        ],
                      )),
                );
              },
            ),
          );
  }

  _buildStyleNoteHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 8.0,
      ),
      child: Text(
        FlutterI18n.translate(context, "PRODUCT_REVIEWS"),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildStyleNoteData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 8.0,
      ),
      child: Container(
          // child: widget.item.avgRating == null
          //     ?
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SmoothStarRating(
                  allowHalfRating: false,
                  onRatingChanged: null,
                  starCount: 5,
                  rating: rating,
                  size: 18.0,
                  color: Color(0xFFFD68AE),
                  borderColor: appTealColor,
                  spacing: 0.0),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  detailsProduct == null
                      ? "(0)"
                      : detailsProduct[0].product.average != null
                          ? "(${detailsProduct[0].product.review.length})"
                          : "(0)",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 15.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'MyriadPro',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  SlideLeftRoute(
                      page: ReviewPage(detailsProduct[0].product.review)));
            },
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                     FlutterI18n.translate(context, "See_reviews"),
                    style: TextStyle(
                      color: Colors.blue[400],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.blue[400],
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  _buildMoreInfoHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 8.0,
      ),
      child: Text(
        FlutterI18n.translate(context, "PRODUCT_DESCRIPTION"),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildMoreInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 8.0,
      ),
      child: Text(
        detailsProduct == null
            ? ""
            : "${detailsProduct[0].product.description}",
        style: TextStyle(
          color: Colors.black45,
        ),
      ),
    );
  }

  _buildBottomNavigationBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: RaisedButton(
              onPressed: () {},
              color: Colors.grey,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      FlutterI18n.translate(context, "Added"),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                _isLoggedIn
                    ? _isadd
                        ? Navigator.push(
                            context, SlideLeftRoute(page: Navigation(2)))
                        : null
                    : Navigator.push(
                        context, SlideLeftRoute(page: LogInPage("1")));
                setState(() {
                  if (selectedSize.length == 0 && selectedColor.length == 0) {
                    cartList.add({
                      "name": detailsProduct[0].product.name,
                      "productId": widget.id,
                      "combinationId": 0,
                      "price": detailsProduct[0].product.discount == 0
                          ? initPrice.toString()
                          : price.toStringAsFixed(2),
                      "quantity": 1,
                      "totalPrice": detailsProduct[0].product.discount == 0
                          ? initPrice.toString() * 1
                          : price.toStringAsFixed(2) * 1,
                      "stock": stock = detailsProduct[0].product.stock
                    });

                    myCart.add({
                      "productId": widget.id,
                      "combinationId": 0,
                      "price": detailsProduct[0].product.discount == 0
                          ? initPrice.toString()
                          : price.toStringAsFixed(2),
                      "quantity": 1,
                    });
                    _isadd = true;
                  } else {
                    if (size != "" && color != "") {
                      cartList.add({
                        "name": detailsProduct[0].product.name,
                        "productId": widget.id,
                        "combinationId": comboId,
                        "price": detailsProduct[0].product.discount == 0
                            ? initPrice.toString()
                            : price.toStringAsFixed(2),
                        "quantity": 1,
                        "totalPrice": detailsProduct[0].product.discount == 0
                            ? initPrice.toString() * 1
                            : price.toStringAsFixed(2) * 1,
                        "stock": stock
                      });

                      myCart.add({
                        "productId": widget.id,
                        "combinationId": comboId,
                        "price": detailsProduct[0].product.discount == 0
                            ? initPrice.toString()
                            : price.toStringAsFixed(2),
                        "quantity": 1,
                      });
                      _isadd = true;
                    }
                  }
                  selectedSize.length == 0 && selectedColor.length == 0
                      ? setCart()
                      : size == "" && color == "" ? null : setCart();
                  print(cartList);
                });
                // Navigator.push(
                //         context, SlideLeftRoute(page: Navigation()));
              },
              child: Container(
                color: selectedSize.length == 0 && selectedColor.length == 0
                    ? Colors.greenAccent.withOpacity(0.8)
                    : size == "" && color == ""
                        ? Colors.greenAccent.withOpacity(0.2)
                        : Colors.greenAccent.withOpacity(0.8),
                child: Center(
                  child: !_isadd
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              selectedSize.length == 0 &&
                                      selectedColor.length == 0
                                  ? Icons.shopping_cart
                                  : size == "" && color == ""
                                      ? Icons.add
                                      : combo == "1"
                                          ? Icons.shopping_cart
                                          : Icons.shopping_basket,
                              //size: 20,
                              color: selectedSize.length == 0 &&
                                      selectedColor.length == 0
                                  ? appTealColor
                                  : size == "" && color == ""
                                      ? Colors.grey[500]
                                      : appTealColor,
                              size: 16,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                    selectedSize.length == 0 &&
                                            selectedColor.length == 0
                                        ?FlutterI18n.translate(context, "Add_to_cart")
                                        : size == "" && color == ""
                                            ? FlutterI18n.translate(context, "Add")
                                            : combo == "1"
                                                ?FlutterI18n.translate(context, "Add_to_cart")
                                                : FlutterI18n.translate(context, "Pre_order"),
                                    style: TextStyle(
                                        color: selectedSize.length == 0 &&
                                                selectedColor.length == 0
                                            ? appTealColor
                                            : size == "" && color == ""
                                                ? Colors.grey[500]
                                                : appTealColor,
                                        fontSize: 12)))
                          ],
                        )
                      : Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, top: 5, bottom: 5),
                                  // margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: appTealColor,
                                  ),
                                  child: Text("3",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(FlutterI18n.translate(context, "View_Cart"),
                                      style: TextStyle(
                                        color: appTealColor,
                                        //fontSize: 17
                                      ))),
                              Container(
                                  // color: appTealColor,
                                  //   padding: EdgeInsets.all(5),

                                  child: Text(
                                      detailsProduct[0].product.discount == 0
                                          ? "\$${detailsProduct[0].product.price}"
                                          : "\$${price.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          color: appTealColor,
                                          //fontSize: 15,
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                        ),
                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Icon(
                  //       Icons.shopping_cart,
                  //       color: Colors.white,
                  //     ),
                  //     SizedBox(
                  //       width: 4.0,
                  //     ),
                  //     Text(
                  //       "Add to Cart",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  setCart() async {
    var key = 'cart-list';
    //await _getCartData(key);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(key, json.encode(cartList));

    var cartkey = 'my-cart-list';
    //await _getCartData(key);
    SharedPreferences cartStorage = await SharedPreferences.getInstance();
    cartStorage.setString(cartkey, json.encode(myCart));
  }

  addWishList() async {
    var data = {
      "productId": widget.id,
      "token": userToken,
    };

    setState(() {
      _loading = true;
    });

    var res = await CallApi().postData(
        data, '/app/addWishlist?productId=${widget.id}&token=$userToken');

    if (res != null) {
      var body = json.decode(res.body);
      print(body);

      if (body['success'] == true) {
        setState(() {
          _isWishlisted = true;
        });
      } else {
        _showToast(2);
      }
    }

    setState(() {
      _loading = false;
    });
  }

  _showToast(int number) {
    Fluttertoast.showToast(
        msg: number == 1 ? FlutterI18n.translate(context, "Already_added") : FlutterI18n.translate(context, "Something_went_wrong"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor:
            number == 1 ? appTealColor.withOpacity(0.9) : Colors.red[400],
        textColor: Colors.white,
        fontSize: 13.0);
  }
}
