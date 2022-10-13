import 'dart:convert';
import 'dart:ui';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ReviewPage/ReviewPage.dart';
import 'package:ecommerce_bokkor_dev/model/FlashCheckModel/flashCheckModel.dart';
import 'package:ecommerce_bokkor_dev/model/ProductDetailsModel/productDetailsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:youtube_parser/youtube_parser.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ProductsDetailsPage extends StatefulWidget {
  final id;
  final quantity;
  ProductsDetailsPage(this.id, this.quantity);
  @override
  State<StatefulWidget> createState() {
    return ProductsDetailsPageState();
  }
}

class ProductsDetailsPageState extends State<ProductsDetailsPage>
    with TickerProviderStateMixin {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  Future<void> _initializeuTubeVideoPlayerFuture;

  TextEditingController _reviewController = TextEditingController();
  Animation<double> animation;
  AnimationController controller;
  bool _isLoggedIn = false;
  int comStock;
  String _debugLabelString = "",
      review = '',
      _ratingStatus = '',
      size = "",
      color = "",
      combo = "",
      userToken = "",
      combination = "";
  String curDate = "", userDisc = "";
  bool _requireConsent = false;
  int _current = 0,
      active = 0,
      discount = 0,
      comboId = 0,
      stock = 0,
      isWishListed = 0,
      last = 1,
      first = 1,
      quantity = 1;
  int c1 = 0,
      c2 = 0,
      idx = 0,
      varComLen = 0,
      discout = 0,
      sold = 0,
      userDiscount = 0,
      disc = 0;
  double price = 0.0,
      rating = 0.0,
      initPrice = 0.0,
      cartPrice = 0.0,
      dSold = 0.0;
  bool _isadd = true;
  bool _isadded = false;
  bool _isLoading = true;
  bool _isCart = true;
  bool _loading = false;
  bool _isWishlisted = false;
  bool _isVideo = false;
  bool _isImage = false;
  bool _isShow = false;
  bool _isPreorder = false;
  bool _isFlash = false;
  bool _isFullVideo = false;
  List allList = [];
  var body, body1, userData, flashCheck;
  var detailsProduct;
  var key = 'cart-list', cartkey = "my-cart-list";
  List<String> selectedSize = [],
      selectedColor = [],
      sizeSelected = [],
      colorSelected = [];
  var comboList = [];
  List cartList = [], myCart = [];
  List cart;
  List imgList = [];
  List vidList = [];
  String comb = "", msg = "";

  YoutubePlayerController _ucontroller;
  TextEditingController _idController = TextEditingController();
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  int count = 0;

  //List<VideoPlayerController> vidList = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    setState(() {
      userToken = token;
    });
    print(userToken);
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      //Navigator.push(context, SlideLeftRoute(page: LogInPage("3")));
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
    }

    _showProductsDetails(token);
    print(_isLoggedIn);
  }

  _currentDate() {
    var now = new DateTime.now();
    var d1 = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    setState(() {
      curDate = d1;
    });
  }

  /////////////// get featured Products start ///////////////

  void _productsDetailsState() {
    var detProducts = ProductDetailsModel.fromJson(body);
    print(body);
    if (!mounted) return;
    setState(() {
      detailsProduct = detProducts.product;
      isWishListed = detProducts.isWishlist;

      // if (userData == null) {
      //   userDisc = "0";
      // } else {
      //   userDisc = userData['discount'];
      // }

      // double discUser = double.parse(userDisc);

      // userDiscount = discUser.toInt();

      disc = detailsProduct[0].discount;
      // print("disc");
      // print(disc);

      // if (userDiscount > disc) {
      //   setState(() {
      //     discount = userDiscount;
      //   });
      // } else {
      setState(() {
        discount = disc;
      });
      // }
      String pr = detailsProduct[0].price;
      double prices = double.parse(pr);
      double dis = discount / 100;
      double pp = prices.toDouble();
      price = (pp * dis);
      price = prices - price;

      print("price 23");
      print(price);
      if (isWishListed == 0) {
        _isWishlisted = false;
      } else {
        _isWishlisted = true;
      }
      print("isWishListed");
      print(isWishListed);

      print("detailsProduct[0].photo.length");
      print(detailsProduct[0].photo.length);

      print("detailsProduct[0].video.length");
      print(detailsProduct[0].video.length);

      if (detailsProduct[0].average != null) {
        String rate = detailsProduct[0].average.averageRating;
        rating = double.parse(rate);
      }
      String rr = rating.toStringAsFixed(1);
      rating = double.parse(rr);

      print(detailsProduct[0].product_variable.length);

      for (int i = 0; i < detailsProduct[0].product_variable.length; i++) {
        if (detailsProduct[0].product_variable[i].name == "Size" ||
            detailsProduct[0].product_variable[i].name == "size") {
          for (int j = 0;
              j < detailsProduct[0].product_variable[i].values.length;
              j++) {
            selectedSize
                .add(detailsProduct[0].product_variable[i].values[j].value);
          }
        }
      }

      for (int i = 0; i < detailsProduct[0].product_variable.length; i++) {
        setState(() {});
        // if (detailsProduct[0].product_variable[i].name == "Colour" ||
        //     detailsProduct[0].product_variable[i].name == "colors") {
        //   for (int j = 0;
        //       j < detailsProduct[0].product_variable[i].values.length;
        //       j++) {
        //     selectedColor
        //         .add(detailsProduct[0].product_variable[i].values[j].value);
        //   }
        // }
      }

      if (detailsProduct[0].photo.length == 0) {
        _isImage = false;
      } else {
        _isImage = true;

        for (int i = 0; i < detailsProduct[0].photo.length; i++) {
          imgList.add(detailsProduct[0].photo[i].link);
        }
      }

      if (detailsProduct[0].video.length == 0) {
        _isVideo = false;
      } else {
        _isVideo = true;
        for (int i = 0; i < detailsProduct[0].video.length; i++) {
          vidList.add({
            "type": "${detailsProduct[0].video[i].type}",
            "vLink": "${detailsProduct[0].video[i].link}"
          });

          // print("test");
          // print(vidList[i]['vLink']);
          // print(vidList[i]['type']);
          vidList[idx]['type'] == "upload"
            ? playVideo(vidList[idx]['vLink'])
              : utubePlay(vidList[idx]['vLink']);
          // playVideo('${vidList[idx]}');
          //   playVideo('${vidList[idx]}');
          // print(detailsProduct[0].video[i].link);
        }
      }

      String ppi = detailsProduct[0].price;

      initPrice = double.parse(ppi);

      if (discount == 0) {
        cartPrice = initPrice * quantity;
      } else {
        cartPrice = price * quantity;
      }

      if (detailsProduct[0].stock == 0) {
        _isPreorder = true;
      }

     // _checkFlash();

      _isLoading = false;
    });
  }

  Future<void> _showProductsDetails(var token) async {
    if (token == null) {
      var res = await CallApi().getData('/app/showSingleProduct/${widget.id}');
      body = json.decode(res.body);
      if (res.statusCode == 200) {
        _productsDetailsState();
      }
    } else {
      var res = await CallApi()
          .getData('/app/showSingleProduct/${widget.id}?token=$token');
      body = json.decode(res.body);
      if (res.statusCode == 200) {
        _productsDetailsState();
      }
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    //Scaffold.of(context).showSnackBar(snackBar);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  //////////////// get featured Products end /////////////

  @override
  void initState() {
    quantity = widget.quantity;
    _currentDate();
    _getUserInfo();
    getcartList(key);
    getmycartList(cartkey);

    playVideo(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    utubePlay("https://www.youtube.com/watch?v=49l3WFQe0Q4");
    //active = _current + 1;
    //bottomNavIndex = 2;
    super.initState();
  }

  Future<void> _checkFlash() async {
    var res = await CallApi()
        .getData('/app/showSingleFlashsale/${widget.id}?date=$curDate');
    body1 = json.decode(res.body);

    if (res.statusCode == 200) {
      _flashCheckState();
    }
  }

  void _flashCheckState() {
    var fCheck = FlashCheckModel.fromJson(body1);
    if (!mounted) return;

    setState(() {
      flashCheck = fCheck.status;
    });

    if (flashCheck == null) {
      setState(() {
        _isFlash = false;
        discount = detailsProduct[0].discount;
        String pr = detailsProduct[0].price;
        double prices = double.parse(pr);
        double dis = discount / 100;
        double pp = prices.toDouble();
        price = (pp * dis);
        price = prices - price;
      });
      print("_isFlash 1");
      print(_isFlash);
    } else {
      setState(() {
        if (flashCheck.length == 0) {
        } else {
          discount = flashCheck[0].product.discount;
          String pr = detailsProduct[0].price;
          double prices = double.parse(pr);
          double dis = discount / 100;
          double pp = prices.toDouble();
          price = (pp * dis);
          price = prices - price;
          print("discount");
          print(discount);

          sold = flashCheck[0].product.totalSale;
          print("sold");
          print(sold);
          stock = flashCheck[0].product.quantity;

          double stockD = stock.toDouble();
          double soldD = sold.toDouble();

          dSold = (soldD / stockD);

          setState(() {
            _isFlash = true;
          });
          print("_isFlash 2");
          print(_isFlash);

          if (discount == 0) {
            cartPrice = initPrice * quantity;
          } else {
            cartPrice = price * quantity;
          }
        }
      });
    }
  }

  void playVideo(String link) {
    print(link);
    _controller = VideoPlayerController.network(
        //'https://www.youtube.com/watch?v=_SBucsSIkBU',
        link);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  void utubePlay(String link) {
    String utubelink = getIdFromUrl(link);
    print("test link");
    print(utubelink);
    _ucontroller = YoutubePlayerController(
      initialVideoId: utubelink,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHideAnnotation: true,
      ),
    )..addListener(listener);

    // _initializeuTubeVideoPlayerFuture = _ucontroller..addListener(listener)
  }

  void listener() {
    if (_isPlayerReady && mounted && !_ucontroller.value.isFullScreen) {
      setState(() {
        _playerState = _ucontroller.value.playerState;
        _videoMetaData = _ucontroller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
   
    _ucontroller.pause();
    super.deactivate();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   _idController.dispose();
  //   _seekToController.dispose();
  //   super.dispose();
  // }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    _ucontroller.dispose();
    _idController.dispose();
   // _seekToController.dispose();
    // for (var vc in vidList) {
    //   vc.dispose();
    // }

    super.dispose();
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

      // for (int i = 0; i < cartList.length; i++) {
      //   if (cartList[i]['productId'] == widget.id) {
      //     setState(() {
      //       _isadded = true;
      //     });
      //   }
      // }
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

      // for (int i = 0; i < myCart.length; i++) {
      //   if (myCart[i]['productId'] == widget.id) {
      //     setState(() {
      //       _isadded = true;
      //     });
      //   }
      // }
    });
  }

  int _rating = 0;

  void rate(int rating) {
    //Other actions based on rating such as api calls.
    setState(() {
      _rating = rating;
    });

    if (rating == 1) {
      _ratingStatus = "Poor";
    }
    if (rating == 2) {
      _ratingStatus = "Average";
    }
    if (rating == 3) {
      _ratingStatus = "Good";
    }
    if (rating == 4) {
      _ratingStatus = "Very Good";
    }
    if (rating == 5) {
      _ratingStatus = "Excellent";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              FlutterI18n.translate(context,"Product_Details"),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            // _isVideo == true && _isImage == true && _isShow == false
            //     ? GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             _isShow = true;
            //           });
            //         },
            //         child: Container(
            //           child: Text(
            //             "See Video",
            //             style: TextStyle(color: Colors.white70, fontSize: 12),
            //           ),
            //         ),
            //       )
            //     : Container(),
          ],
        ),
      ),
      body: _buildProductDetailsPage(context),
      bottomNavigationBar: _isFullVideo
          ? Container(
              height: 0,
            )
          : detailsProduct == null
              ? Container(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
              : _buildBottomNavigationBar(),
    );
  }

  _buildProductDetailsPage(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return detailsProduct == null
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _isFullVideo
            ? Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[_buildProductImagesWidgets()],
                ),
              )
            : ListView(
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
                          _buildSeeVideoWidgets(),
                          SizedBox(height: 12.0),
                          _buildPriceWidgets(),
                          SizedBox(height: 12.0),
                          _buildDivider(screenSize),
                          SizedBox(height: 12.0),
                          detailsProduct[0].product_variable.length == 0
                              ? Container()
                              : _buildComboHeader(),
                          detailsProduct[0].product_variable.length == 0
                              ? Container()
                              : SizedBox(height: 6.0),
                          detailsProduct[0].product_variable.length == 0
                              ? Container()
                              : _buildDivider(screenSize),
                          detailsProduct[0].product_variable.length == 0
                              ? Container()
                              : SizedBox(height: 4.0),

                          detailsProduct[0].product_variable.length == 0
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: _showProductsVariableList()),
                                ),
                          msg == "" ? Container() : _buildMsgHeader(),
                          //: _buildSizeChartWidgets(),
                          //_buildSizeChartWidgets(),
                          // SizedBox(height: 4.0),
                          // _buildDivider(screenSize),
                          // _buildSizeList(),
                          // SizedBox(height: 12.0),
                          // _buildColorChartWidgets(),
                          // _buildDivider(screenSize),
                          // _buildColorList(),
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
                                    viewImage(detailsProduct[0].name, imgList,
                                        _current);
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
                                        viewImage(detailsProduct[0].name,
                                            imgList, _current);
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
                          vidList[idx]['type'] == "upload"
                              ? FutureBuilder(
                                  future: _initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Center(
                                        child: AspectRatio(
                                            aspectRatio:
                                                _controller.value.aspectRatio,
                                            child: VideoPlayer(_controller)),
                                      );
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                )
                              : YoutubePlayer(
                                  controller: _ucontroller,
                                  showVideoProgressIndicator: false,
                                  //progressIndicatorColor: Colors.blueAccent,
                                  topActions: <Widget>[
                                    SizedBox(width: 8.0),
                                  ],
                                  onReady: () {
                                    setState(() {
                                      _isPlayerReady = true;
                                    });
                                  },
                                ),
                          //     FutureBuilder(
                          //   future: _initializeVideoPlayerFuture,
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.done) {
                          //       return Center(
                          //         child: ,
                          //       );
                          //     } else {
                          //       return Center(
                          //           child: CircularProgressIndicator());
                          //     }
                          //   },
                          // ),

                          Column(
                            children: <Widget>[
                              _isVideo == true &&
                                      _isImage == false &&
                                      _isShow == false
                                  ? Container()
                                  : _isFullVideo
                                      ? Container()
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isShow = false;
                                              if (_controller.value.isPlaying) {
                                                _controller.pause();
                                              } else {
                                                // If the video is paused, play it.
                                                //_controller.play();
                                              }
                                            });
                                          },
                                          child: Container(
                                              alignment: Alignment.topRight,
                                              padding: EdgeInsets.all(5),
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 25,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ),
                              _isVideo == true &&
                                      _isImage == false &&
                                      _isShow == false
                                  ? Container()
                                  : vidList[idx]['type'] == "upload"
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              //_isFullVideo = true;
                                              if (_isFullVideo == true) {
                                                _isFullVideo = false;
                                              } else {
                                                _isFullVideo = true;
                                              }
                                            });
                                          },
                                          child: Container(
                                              alignment: Alignment.topRight,
                                              padding: EdgeInsets.all(5),
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    color: _isFullVideo
                                                        ? Colors.grey
                                                            .withOpacity(0.4)
                                                        : Colors.black
                                                            .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Icon(
                                                  _isFullVideo
                                                      ? Icons.fullscreen_exit
                                                      : Icons.fullscreen,
                                                  size: 25,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        )
                                      : Container(),
                            ],
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
                                                    // print(vidList[idx].type);
                                                    setState(() {
                                                      //c1 = 0;
                                                      idx--;
                                                      if (idx <= 0) {
                                                        idx = 0;
                                                      }
                                                      idx < 0
                                                          ? null
                                                          : vidList[idx][
                                                                      'type'] ==
                                                                  "upload"
                                                              ? playVideo(
                                                                  vidList[idx]
                                                                      ['vLink'])
                                                              : utubePlay(
                                                                  vidList[idx][
                                                                      'vLink']);
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
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      decoration: BoxDecoration(
                                                          color: idx == 0
                                                              ? Colors
                                                                  .transparent
                                                              : _isFullVideo
                                                                  ? Colors.grey
                                                                      .withOpacity(
                                                                          0.4)
                                                                  : Colors.black
                                                                      .withOpacity(
                                                                          0.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Icon(
                                                          Icons.chevron_left,
                                                          color: idx == 0
                                                              ? Colors
                                                                  .transparent
                                                              : Colors.white,
                                                          size: 30),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                    vidList[idx]['type'] == "upload"
                                        ? Icon(Icons.play_arrow,
                                            color: Colors.white, size: 45)
                                        : Container(),
                                    vidList.length == 1
                                        ? Container()
                                        : last > vidList.length
                                            ? Container()
                                            : Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      //c2 = 0;
                                                      //  print(vidList[idx]);
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
                                                          : vidList[idx][
                                                                      'type'] ==
                                                                  "upload"
                                                              ? playVideo(
                                                                  vidList[idx]
                                                                      ['vLink'])
                                                              : utubePlay(
                                                                  vidList[idx][
                                                                      'vLink']);
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
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 5),
                                                      decoration: BoxDecoration(
                                                          color: idx ==
                                                                  vidList.length -
                                                                      1
                                                              ? Colors
                                                                  .transparent
                                                              : _isFullVideo
                                                                  ? Colors.grey
                                                                      .withOpacity(
                                                                          0.4)
                                                                  : Colors.black
                                                                      .withOpacity(
                                                                          0.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Icon(
                                                          Icons.chevron_right,
                                                          color: idx ==
                                                                  vidList.length -
                                                                      1
                                                              ? Colors
                                                                  .transparent
                                                              : Colors.white,
                                                          size: 30),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                  ],
                                ))
                        ],
                      ),
                    ),
                  )
                  );
  }

  void viewImage(String name, List imgList, int index) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new SomeDialog(name: name, imgList: imgList, id: index);
        },
        fullscreenDialog: true));
  }

  _buildProductTitleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        margin: EdgeInsets.only(top: 15),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      FlutterI18n.translate(context,"Product id"),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Roboto',
                          color: appTealColor,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "#${detailsProduct[0].id}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Roboto',
                          color: appTealColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                //name,
                detailsProduct == null ? "" : "${detailsProduct[0].name}",
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildSeeVideoWidgets() {
    // _isVideo == true && _isImage == true && _isShow == false
    //       ? GestureDetector(
    //           onTap: () {
    //             setState(() {
    //               _isShow = true;
    //             });
    //           },
    //           child: Container(
    //             child: Text(
    //               "See Video",
    //               style: TextStyle(color: Colors.white70, fontSize: 12),
    //             ),
    //           ),
    //         )
    //       : Container(),
    return _isVideo == true && _isImage == true && _isShow == false
        ? GestureDetector(
            onTap: () {
              setState(() {
                _isShow = true;
              });
            },
            child: Container(
              alignment: Alignment.bottomRight,
              child: Card(
                elevation: 2,
                margin: EdgeInsets.only(right: 10),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 8, bottom: 8),
                  //   margin: EdgeInsets.only(top: 15),
                  child: Text(
                    //name,
                     FlutterI18n.translate(context,"See Video"+" >"),
                    style: TextStyle(fontSize: 16.0, color: appColor),
                  ),
                ),
              ),
            ),
          )
        : Container();
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
                      : discount == 0
                          ? "${detailsProduct[0].price} BHD"
                          : "${price.toStringAsFixed(2)} BHD",
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
                    : discount == 0
                        ? Container()
                        : Text(
                            "${detailsProduct[0].price} BHD",
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
                    : discount == 0
                        ? Container()
                        : Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.blue[700],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "$discount%"+FlutterI18n.translate(context,"Off") ,
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
            child: detailsProduct == null
                ? Container()
                // : detailsProduct[0].stock == 0
                //     ? Container(
                //         margin: EdgeInsets.only(top: 3, left: 10, right: 0),
                //         child: Text(
                //           "Out of stock",
                //           style: TextStyle(
                //               color: Colors.redAccent,
                //               fontFamily: "sourcesanspro",
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold),
                //         ),
                //       )
                : Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(3),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {

                                 
                                  setState(() {
                                    if (_isLoggedIn) {
                                      quantity--;
                                      if (quantity <= 1) {
                                        quantity = 1;
                                        if (discount == 0) {
                                          cartPrice = initPrice * quantity;
                                        } else {
                                          cartPrice = price * quantity;
                                        }
                                        //_isadd = false;
                                     // } else {
                                        if (quantity <=
                                            detailsProduct[0].stock) {
                                          _isPreorder = false;
                                        }
                                        if (discount == 0) {
                                          cartPrice = initPrice * quantity;
                                        } else {
                                          cartPrice = price * quantity;
                                        }
                                        _isadd = true;
                                      }
                                    } else {
                                      Navigator.push(context,
                                          SlideLeftRoute(page: LogInPage("1")));
                                    }

                                    print(quantity);
                                      print(_isPreorder);
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
                                margin: EdgeInsets.only(
                                    top: 3, left: 10, right: 10),
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
                                    if (_isLoggedIn) {
                                      quantity++;

                                      //  _storeData();
                                      if (comb != "") {
                                        _storeData();
                                      }
                                      if (quantity > detailsProduct[0].stock) {
                                        _isPreorder = true;
                                      }
                                     
                                      if (discount == 0) {
                                        cartPrice = initPrice * quantity;
                                      } else {
                                        cartPrice = price * quantity;
                                      }

                                      print(quantity);
                                      print(_isPreorder);

                                      _isadd = true;
                                    } else {
                                      Navigator.push(context,
                                          SlideLeftRoute(page: LogInPage("1")));
                                    }
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
                        Container(
                          margin: EdgeInsets.only(top: 3, left: 10, right: 10),
                          child: Text(
                            "${detailsProduct[0].stock}"+FlutterI18n.translate(context,"Available") ,
                            style: TextStyle(
                                color: Colors.black45,
                                fontFamily: "sourcesanspro",
                                fontSize: 11,
                                fontWeight: FontWeight.normal),
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

  _buildComboHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 8.0,
      ),
      child: Text(
        FlutterI18n.translate(context,"PRODUCT COMBINATIONS"),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<Widget> _showProductsVariableList() {
    List<Widget> list = [];
    // int checkIndex=0;
    //int i=0;
    // d.add({
    //     "isSelected": false,
    //   });
    for (var d in detailsProduct[0].product_variable) {
      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 25, top: 0, bottom: 8),
                    child: Text(d.name == null ? "" : d.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))),
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 5, top: 0, bottom: 8),
                    child: Text(d.name == null ? "" : FlutterI18n.translate(context,"("+"Select one from below"+")"),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.grey, fontSize: 12))),
              ],
            ),
            d.name == null
                ? Container()
                : Container(
                    child: Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                  ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 25, top: 5, bottom: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _showProductsVariableValue(d)),
            )
          ],
        ),
      );
    }

    return list;
  }

  List<Widget> _showProductsVariableValue(var listData) {
    List<Widget> list = [];

    var name;

    for (var d in listData.values) {
      // print(d);
      // int i = 0;

      list.add(GestureDetector(
        onTap: () {
          //  print(listData.isSelected);

          //   print(d);
          // comb = d.value;
          if (d.isSelected == null) {
            // make all d.selected false first // then make d.isSelected true
            for (var d in listData.values) {
              setState(() {
                d.isSelected = null;
              });
            }
            setState(() {
              d.isSelected = true;
              name = d.value;
            });

            int index = 1;
            for (int i = 0; i < allList.length; i++) {
              if (allList[i]['listName'] == listData.name) {
                allList.removeAt(i);
              }
            }

            if (index == 1) {
              allList.add({'listName': listData.name, 'name': name});
            }

            index = 0;
          } else {
            setState(() {
              d.isSelected = null;
              for (int i = 0; i < allList.length; i++) {
                if (allList[i]['listName'] == listData.name) {
                  allList.removeAt(i);
                }
              }
              // allList = [];
            });
          }
          print(allList);

          _storeData();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: appTealColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.all(5),
                child: Text(d.value)),

            // IconButton(

            //   icon:
            Container(
              padding: EdgeInsets.only(bottom: 12, top: 6, right: 30),
              child: Icon(
                Icons.check_circle,
                color: d.isSelected == null ? Colors.transparent : appColor,
                //  ),

                // onPressed: (){

                //   setState(() {
                //     is$type = true;
                //   });

                // },
              ),
            )
          ],
        ),
      ));

      // i++;
    }

    return list;
  }

  _buildSizeChartWidgets() {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
                children: List.generate(
                    detailsProduct[0].product_variable.length, (index) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 5, left: 15),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "${detailsProduct[0].product_variable[index].name}",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      FlutterI18n.translate(context,"("+"Select one"+")"),
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              _buildDivider(screenSize),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(top: 0, bottom: 10),
                                padding: EdgeInsets.only(left: 10),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: detailsProduct[0]
                                      .product_variable[index]
                                      .values
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index1) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (comboList.contains(
                                              "${detailsProduct[0].product_variable[index].values[index1].value}")) {
                                            comboList.remove(
                                                "${detailsProduct[0].product_variable[index].values[index1].value}");
                                            detailsProduct[0]
                                                .product_variable[index]
                                                .values[index1]
                                                .isSelected = null;
                                          } else {
                                            for (var i = 0;
                                                i < comboList.length;
                                                i++) {
                                              if (comboList[i]['category'] ==
                                                      "${detailsProduct[0].product_variable[index].name}" &&
                                                  comboList[i]['value'] ==
                                                      "${detailsProduct[0].product_variable[index].values[index1].value}") {
                                                detailsProduct[0]
                                                    .product_variable[index]
                                                    .values[index1]
                                                    .isSelected = null;
                                                comboList.remove(i);
                                                detailsProduct[0]
                                                    .product_variable[index]
                                                    .values[index1]
                                                    .isSelected = true;
                                                comboList.add({
                                                  'category':
                                                      "${detailsProduct[0].product_variable[index].name}",
                                                  'value':
                                                      "${detailsProduct[0].product_variable[index].values[index1].value}",
                                                });
                                              }
                                            }
                                            if (comboList.length > 0) {
                                              comboList.removeAt(0);
                                              detailsProduct[0]
                                                  .product_variable[index]
                                                  .values[index1]
                                                  .isSelected = null;
                                              detailsProduct[0]
                                                  .product_variable[index]
                                                  .values[index1]
                                                  .isSelected = true;
                                              comboList.add({
                                                'category':
                                                    "${detailsProduct[0].product_variable[index].name}",
                                                'values':
                                                    "${detailsProduct[0].product_variable[index].values[index1].value}",
                                              });
                                            } else {
                                              detailsProduct[0]
                                                  .product_variable[index]
                                                  .values[index1]
                                                  .isSelected = true;
                                              comboList.add({
                                                'category':
                                                    "${detailsProduct[0].product_variable[index].name}",
                                                'values':
                                                    "${detailsProduct[0].product_variable[index].values[index1].value}",
                                              });
                                            }
                                          }
                                        });

                                        print(comboList);
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: detailsProduct[0]
                                                          .product_variable[
                                                              index]
                                                          .values[index1]
                                                          .isSelected ==
                                                      true
                                                  ? appTealColor
                                                      .withOpacity(0.4)
                                                  : Colors.grey[50],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          margin: EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: 8,
                                              bottom: 8),
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "${detailsProduct[0].product_variable[index].values[index1].value}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: comboList.contains(
                                                            "${detailsProduct[0].product_variable[index].values[index1].value}")
                                                        ? Colors.white
                                                        : Colors.black45),
                                              ),
                                              comboList.contains(
                                                      "${detailsProduct[0].product_variable[index].values[index1].value}")
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      child: Icon(
                                                        Icons.done,
                                                        size: 15,
                                                        color: comboList.contains(
                                                                "${detailsProduct[0].product_variable[index].values[index1].value}")
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
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            })),
          ],
        ),
      ),
    );
  }

  // _buildSizeChartWidgets() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //     child: Container(
  //       margin: EdgeInsets.only(top: 0, bottom: 5),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.max,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           Row(
  //             children: <Widget>[
  //               Icon(
  //                 Icons.straighten,
  //                 color: Colors.grey[600],
  //               ),
  //               SizedBox(
  //                 width: 12.0,
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: <Widget>[
  //                   Text(
  //                     "Size",
  //                     style: TextStyle(
  //                       color: Colors.grey[600],
  //                     ),
  //                   ),
  //                   Text(
  //                     " (Select one)",
  //                     style: TextStyle(color: Colors.grey[500], fontSize: 12),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           Text(
  //             "${selectedSize.length} available sizes",
  //             style: TextStyle(
  //               color: Colors.blue[400],
  //               fontSize: 12.0,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
                      FlutterI18n.translate(context,"Color"),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                     FlutterI18n.translate(context,"("+"Select one"+")"),
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "${selectedColor.length}"+FlutterI18n.translate(context,"available colors") ,
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
    if (detailsProduct[0].product_vc.length == 0) {
      setState(() {
        combo = "";
        stock = detailsProduct[0].stock;
      });
    } else if (selectedColor.length == 0 && selectedSize.length == 0) {
      setState(() {
        combo = "";
        stock = detailsProduct[0].stock;
      });
    } else {
      if (size == "" && color == "") {
        setState(() {
          combo = "";
          stock = detailsProduct[0].stock;
        });
      } else {
        for (int i = 0; i < detailsProduct[0].product_vc.length; i++) {
          if (detailsProduct[0].product_vc[i].combination == com &&
              detailsProduct[0].product_vc[i].stock != 0) {
            setState(() {
              combo = "1";
              comboId = detailsProduct[0].product_vc[i].id;
              combination = detailsProduct[0].product_vc[i].combination;
              stock = detailsProduct[0].product_vc[i].stock;

              print("stock");
              print(stock);
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

  _buildMsgHeader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          top: 8.0,
        ),
        child: Text(
          "$msg",
          style: TextStyle(
              color:
                  _isPreorder || comboId == 0 ? Colors.redAccent : appTealColor,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
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
        FlutterI18n.translate(context,"PRODUCT REVIEWS"),
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
                      : detailsProduct[0].average != null
                          ? "(${detailsProduct[0].review.length})"
                          : "(0)",
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
              Navigator.push(context,
                  SlideLeftRoute(page: ReviewPage(detailsProduct[0].review)));
            },
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context,"See reviews"),
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
        FlutterI18n.translate(context,"PRODUCT DESCRIPTION"),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            detailsProduct == null
                ? ""
                : detailsProduct[0].description == null
                    ? ""
                    : "${detailsProduct[0].description}",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),

         detailsProduct[0].warranty == null
                    ?Container(): Column(
            children: <Widget>[
              Text( FlutterI18n.translate(context,"Warrenty"),style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,),),
             SizedBox(height:4),
              Text(
            detailsProduct == null
                ? ""
                : detailsProduct[0].warranty == null
                    ? ""
                    : "${detailsProduct[0].warranty}",
            style: TextStyle(
              color: Colors.black45,
            ),
          ),
            ],
          ),
          
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
              onPressed: () {
                if (_isLoggedIn) {
                  if (_isWishlisted) {
                    _showToast(1);
                  } else {
                    addWishList();
                  }
                } else {
                  Navigator.push(context, SlideLeftRoute(page: LogInPage("1")));
                }
              },
              color: Colors.grey[400],
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      _isWishlisted ? Icons.favorite : Icons.favorite_border,
                      color: _isWishlisted ? Colors.redAccent : Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      _isWishlisted
                          ? FlutterI18n.translate(context,"Added")
                          : _loading == true ?  FlutterI18n.translate(context,"Processing"+"...") : 
                          FlutterI18n.translate(context,"Wishlist"),
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
                // _isadded == true
                //     ? null
                //     // : _isadd
                //     //     ? Navigator.push(
                //     //         context, SlideLeftRoute(page: Navigation(2)))
                //         : null;
                setState(() {
                  if (_isLoggedIn) {
                    if (quantity == 0) {
                      // detailsProduct[0].discount == 0
                      //     ? detailsProduct[0].price * quantity
                      //     : price * quantity;
                      _showToast(5);
                    } else {
                      if (_isadd == true) {
                        if (detailsProduct[0].product_variable.length == 0 &&
                            _isPreorder == true) {
                          //addReservation();
                          _showPreorderDialog();
                        } else if (detailsProduct[0].product_variable.length ==
                                0 &&
                            _isPreorder == false) {
                          addToCart();
                        } else {
                          if (comboId == 0 && _isPreorder == false) {
                            _showToast(8);
                          } else {
                            if (_isPreorder) {
                              //addReservation();
                              _showPreorderDialog();
                            } else {
                              addToCart();
                            }
                          }
                        }

                        //_storeData();
                        // if (selectedSize.length == 0 && selectedColor.length == 0) {
                        //   int inCart = 0;
                        //   if (cartList.length == 0) {
                        //     cartList.add({
                        //       "name": detailsProduct[0].name,
                        //       "productId": widget.id,
                        //       "combinationId": 0,
                        //       "price": detailsProduct[0].discount == 0
                        //           ? initPrice.toString()
                        //           : price.toStringAsFixed(2),
                        //       "quantity": quantity,
                        //       "totalPrice": detailsProduct[0].discount == 0
                        //           ? initPrice.toString() * quantity
                        //           : price.toStringAsFixed(2) * quantity,
                        //       "stock": stock = detailsProduct[0].stock
                        //     });

                        //     myCart.add({
                        //       "productId": widget.id,
                        //       "combinationId": 0,
                        //       "price": detailsProduct[0].discount == 0
                        //           ? initPrice.toString()
                        //           : price.toStringAsFixed(2),
                        //       "quantity": quantity,
                        //     });
                        //     _isadd = true;
                        //   } else {
                        //     for (int i = 0; i < cartList.length; i++) {
                        //       if (cartList[i]['productId'] == widget.id) {
                        //         inCart = 1;
                        //         _showToast(1);
                        //       }
                        //     }

                        //     if (inCart == 0) {
                        //       cartList.add({
                        //         "name": detailsProduct[0].name,
                        //         "productId": widget.id,
                        //         "combinationId": 0,
                        //         "price": detailsProduct[0].discount == 0
                        //             ? initPrice.toString()
                        //             : price.toStringAsFixed(2),
                        //         "quantity": quantity,
                        //         "totalPrice": detailsProduct[0].discount == 0
                        //             ? initPrice.toString() * quantity
                        //             : price.toStringAsFixed(2) * quantity,
                        //         "stock": stock = detailsProduct[0].stock
                        //       });

                        //       myCart.add({
                        //         "productId": widget.id,
                        //         "combinationId": 0,
                        //         "price": detailsProduct[0].discount == 0
                        //             ? initPrice.toString()
                        //             : price.toStringAsFixed(2),
                        //         "quantity": quantity,
                        //       });
                        //       _isadd = true;
                        //     }
                        //   }
                        // }
                      }
                    }
                  } else {
                    Navigator.push(
                        context, SlideLeftRoute(page: LogInPage("1")));
                  }

                  // selectedSize.length == 0 && selectedColor.length == 0
                  //     ? setCart()
                  //     : size == "" && color == "" ? null : setCart();
                  // print(cartList);
                });
              },
              child: Container(
                color: _isadded
                    ? Colors.grey
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
                                  : comboId == 0
                                      ? Icons.add
                                      : combo == "1"
                                          ? Icons.shopping_cart
                                          : Icons.shopping_basket,
                              //size: 20,
                              color: appTealColor,
                              size: 16,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Text(
                                    selectedSize.length == 0 &&
                                            selectedColor.length == 0
                                        ?FlutterI18n.translate(context,"Add_to_cart") 
                                        : comboId != 0 || _isPreorder == false
                                            ?FlutterI18n.translate(context,"Add_to_cart") 
                                            : FlutterI18n.translate(context,"Pre-order") ,
                                    style: TextStyle(
                                        color: appTealColor, fontSize: 12)))
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
                                  child: Text("$quantity",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.shopping_cart,
                                        //size: 20,
                                        color: appTealColor,
                                        size: 16,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 4),
                                        child: Text(
                                            _isadded
                                                ? FlutterI18n.translate(context,"Processing")+"..."
                                                : 
                                                detailsProduct[0].stock == 0
                                                    ? FlutterI18n.translate(context,"Pre-order")
                                                    : comboId != 0 ||
                                                            _isPreorder == false
                                                        ? FlutterI18n.translate(context,"Add_to_cart")
                                                        :  FlutterI18n.translate(context,"Pre-order"),
                                            style: TextStyle(
                                              color: appTealColor,
                                              //fontSize: 17
                                            )),
                                      ),
                                    ],
                                  )),
                              Container(
                                  // color: appTealColor,
                                  //   padding: EdgeInsets.all(5),

                                  child: Text(
                                      "${cartPrice.toStringAsFixed(2)} BHD",
                                      style: TextStyle(
                                          color: appTealColor,
                                          //fontSize: 15,
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showPreorderDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Image.network(
                        '${detailsProduct[0].image}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )),
                  Expanded(
                    child: Container(child: Text("${detailsProduct[0].name}")),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                     FlutterI18n.translate(context,"Stock"+":"),
                      style: TextStyle(fontSize: 13, color: Colors.black45),
                    ),
                    Text(
                      "${detailsProduct[0].stock}",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      FlutterI18n.translate(context,"Quantity"+":"),
                      style: TextStyle(fontSize: 13, color: Colors.black45),
                    ),
                    Text(
                      "$quantity",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                     FlutterI18n.translate(context,"Total Amount"+":"),
                      style: TextStyle(fontSize: 13, color: Colors.black45),
                    ),
                    Text(
                      "${cartPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
              ),
              Text(
                FlutterI18n.translate(context,"This_product_is_out_of_stock_It_will_be_added_into_your_Pre_order_list_Please_confirm_it_there"),
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Container(
              //color: appTealColor,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: FlatButton(
                      //highlightColor: appTealColor,
                      color: appTealColor,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0)),
                      child: new Text(
                       FlutterI18n.translate(context, "OK"),
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        addReservation();
                      },
                    ),
                  ),
                  FlatButton(
                    //highlightColor: appTealColor,
                    color: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0)),
                    child: new Text(
                      FlutterI18n.translate(context, "Cancel"),
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
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

  void _storeData() async {
    List com = [];

    for (var d in detailsProduct[0].product_vc) {
      com.add(d.combination);
    }

    comb = '';
    for (int i = 0; i < allList.length; i++) {
      comb += allList[i]['name'];

      if (i != allList.length - 1) {
        comb += '-';
      }

      print("comb");
      print(comb);
    }
    int index;

    if (detailsProduct[0].product_vc.length != 0) {
      print("check com");
      print(com);
      print("check comb");
      print(comb);
      if (com.contains(comb)) {
        for (int i = 0; i < com.length; i++) {
          if (com[i] == comb) {
            index = i;

            int stock = detailsProduct[0].product_vc[index].stock;
            combination = detailsProduct[0].product_vc[i].combination;
            comboId = detailsProduct[0].product_vc[index].id;
            print("comboId");
            print(comboId);

            setState(() {
              _isPreorder = false;
              msg = "";
            });

            if (quantity > detailsProduct[0].product_vc[index].stock) {
              //_showMsg("No available stock for this combination");
              setState(() {
                _isPreorder = true;
                print("comboId");
                comboId = 0;
                print(comboId);
                // msg = "No available stock for this combination";
              });
              print(_isPreorder);
            }

            int countItem = 0;

            for (int i = 0; i < productData.length; i++) {
              if (productData[i]['id'].toString() ==
                  detailsProduct[0].id.toString()) {
                countItem = 1;
              }
            }

            if (countItem == 0) {
              if (quantity > detailsProduct[0].product_vc[index].stock) {
                //_showMsg("No available stock for this combination");
                setState(() {
                  _isPreorder = true;
                  print("comboId");
                  comboId = 0;
                  print(comboId);
                  //msg = "No available stock for this combination";
                });
                print(_isPreorder);
              } else {
                // productData.add({
                //   'id': '${detailsProduct[0].id}',
                //   'name': '${detailsProduct[0].name} ' + comb,
                //   'price': cartPrice,
                //   'quantity': quantity,
                //   'total': cartPrice * quantity,
                //   'stock': stock,
                //   'combinationId': comboId,
                //   'img': detailsProduct[0].photo.length == 0
                //       ? ""
                //       : detailsProduct[0].photo[0].link
                // });
                // print(productData);
                // SharedPreferences localStorage =
                //     await SharedPreferences.getInstance();
                // localStorage.setString('cartList', json.encode(productData));

                //Navigator.push(context, SlideLeftRoute(page: AddOrder()));
              }
            } else {}
          }
        }
      } else {
        //_showMsg("No available combination! Select combination sequentially");
        setState(() {
          //  _isPreorder = true;
          print("comboId");
          comboId = 0;
          print(comboId);
          msg = "No available combination! Select combination sequentially";
          if (msg ==
              "No available combination! Select combination sequentially") {
            _isPreorder = false;
          } else {
            _isPreorder = true;
          }
        });

        print(_isPreorder);
      }
    } else {
      int stock = detailsProduct[0].stock;
      // comStock = detailsProduct[0].stock;

      if (quantity > stock) {
        //_showMsg("No available stock for this combination");

        print("stock combo");
        print(stock);
        setState(() {
          _isPreorder = true;
          print("comboId");
          comboId = 0;
          print(comboId);
          msg = "No available stock for this combination";
        });
        print(_isPreorder);
      } else {
        print(quantity);

        int countItem = 0;

        for (int i = 0; i < productData.length; i++) {
          if (productData[i]['id'].toString() ==
              detailsProduct[0].id.toString()) {
            countItem = 1;
          }
        }

        if (countItem == 0) {
          // productData.add({
          //   'id': '${detailsProduct[0].id}',
          //   'name': '${detailsProduct[0].name}',
          //   'price': cartPrice,
          //   'quantity': quantity,
          //   'total': cartPrice * quantity,
          //   'stock': stock,
          //   'combinationId': 0,
          //   'img': detailsProduct[0].photo.length == 0
          //       ? ""
          //       : detailsProduct[0].photo[0].link
          // });
        } else {}

        print("productData");

        print(productData);
        // SharedPreferences localStorage = await SharedPreferences.getInstance();
        // localStorage.setString('cartList', json.encode(productData));

        //Navigator.push(context, SlideLeftRoute(page: AddOrder()));
      }
    }
  }

  addToCart() async {                 
    var data = {
      "userId": userData['id'],
      "productId": widget.id,          
      "combinationId": comboId,  
      "combination": combination,     
      "quantity": quantity,
      "type":"normal"
    };
                            
    setState(() {
      _isadded = true;            
      _isCart = true;
    });

    var res = await CallApi().postData(data, '/app/addCartUpdated?token=$userToken');

    if (res != null) {
      var body = json.decode(res.body); 
      print(body);            

      if (body['success'] == true) {
        setState(() {
          //_isadd = false;
          _showToast(7);
        });
      } else {
        if (body['message'] == "product Out of stock!") {
          setState(() {
            //_isadd = false;
            _showToast(12);
          });
        } else {
          _showToast(2);
        }
      }
    }

    setState(() {
      _isadded = false;
      _isCart = false;
    });
  }

  addReservation() async {
    print("quantity");
    print(quantity);
    var data = {
      "productId": widget.id,
      "quantity": quantity,
      "combinationId": comb,
    };

    print(data);

    setState(() {
      _isadded = true;
    });

    if (_isFlash == true) {
      _showToast(25);
    } else {
      var res = await CallApi()
          .postData(data, '/app/addReservation?token=$userToken');

      if (res != null) {
        var body = json.decode(res.body);
        print(body);
        if (body['reservation'] == null &&
            body['message']
                .contains("You already added this product in pre-order")) {
          _showToast(15);
        } else {
          _showToast(6);
        }
      }
    }

    setState(() {
      _isadded = false;
      _loading = false;
    });
  }

  _showToast(int number) {
    Fluttertoast.showToast(
        msg: number == 25
            ? "Flash Sale product cannot be pre-ordered"
            : number == 15
                ? "You already added this product in pre-order"
                : number == 1
                    ? "Already added!"
                    : number == 2
                        ? "Something went wrong!"
                        : number == 5
                            ? "Out of stock!"
                            : number == 5
                                ? "Please select a quantity first!"
                                : number == 6
                                    ? "Added to Pre-order list successfully!"
                                    : number == 7
                                        ? "Added to cart successfully!"
                                        : number == 8
                                            ? "Please select a combination first!"
                                            : "Product out of stock!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: number == 1
            ? appTealColor.withOpacity(0.9)
            : number == 2 ||
                    number == 5 ||
                    number == 12 ||
                    number == 15 ||
                    number == 25
                ? Colors.red[400]
                : number == 5 ? Colors.red[400] : appTealColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }
}

class SomeDialog extends StatefulWidget {
  final String name;
  final List imgList;
  int id;

  SomeDialog(
      {Key key, @required this.name, @required this.imgList, @required this.id})
      : super(key: key);
  @override
  _SomeDialogPageState createState() => new _SomeDialogPageState();
}

class _SomeDialogPageState extends State<SomeDialog> {
  int _current = 0;
  int _isBack = 0;
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      // appBar: new AppBar(
      //     //title: const Text('Dialog Magic'),
      //     ),
      //body: new Text("It's a Dialog!"),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _isBack++;
                });
              },
              child: Center(
                child: new Container(
                  padding: EdgeInsets.all(0.0),
                  color: Colors.black,
                  child: CarouselSlider(
                    height: MediaQuery.of(context).size.height,
                    initialPage: widget.id,
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
                        widget.id = index;
                      });
                    },
                    items: widget.imgList.map((imgUrl) {
                      return Builder(                            
                        builder: (BuildContext context) { 
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 80),
                            decoration: BoxDecoration(
                                //color: Colors.white,
                                ),
                            child: GestureDetector(
                              onScaleStart: (ScaleStartDetails details) {
                                print(details);
                                _previousScale = _scale;
                                setState(() {});
                              },
                              onScaleUpdate: (ScaleUpdateDetails details) {
                                print(details);
                                _scale = _previousScale * details.scale;
                                setState(() {});
                              },
                              onScaleEnd: (ScaleEndDetails details) {
                                print(details);

                                _previousScale = 1.0;
                                setState(() {});
                              },
                              child: Container(
                                child: Transform(
                                  transform: Matrix4.diagonal3(
                                      Vector3(_scale, _scale, _scale)),
                                  child: Image.network(
                                    imgUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: _isBack % 2 == 0
                  ? Container(
                      child: Row(
                        children: <Widget>[
                          BackButton(
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text("${widget.name}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17))),
                                  ),
                                  Text(
                                      "${widget.id + 1}/${widget.imgList.length}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
