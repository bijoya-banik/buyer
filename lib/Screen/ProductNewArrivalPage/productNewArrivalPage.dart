import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/Screen/CategoryPage/CategoryCard.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductPage/ProductsCard.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/model/AllProductModel/allProductModel.dart';
import 'package:ecommerce_bokkor_dev/model/BestSellerModel/bestSellerModel.dart';
import 'package:ecommerce_bokkor_dev/model/CategoryModel/categoryModel.dart';
import 'package:ecommerce_bokkor_dev/model/SubCategoryModel/subCategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductNewArrivalPage extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<ProductNewArrivalPage> {
  var body, body1, body2, filterList;
  int catId = 0;
  bool _isLoading = true;
  bool isSearch = false;
  bool isFilter = false;
  TextEditingController searchController = new TextEditingController();
  String search = "";
  String result = '',
      maxPrice = "",
      minPrice = "",
      cat = "",
      catName = "",
      subCat = "",
      subCatName = "",
      orderName = "",
      nameOrder = "",
      orderType = "",
      typeOrder = "";
  var catList, subCatList, user;
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    _getUserInfo();
    getFilterData();
    getCategory();
    getSubcategory();
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

  Future<void> getFilterData() async {
    // var res = await CallApi().getData(
    //     '/app/showProduct?max=${widget.data['maxPrice']}&min=${widget.data['minPrice']}&cat=${widget.data['category']}&sub=${widget.data['subCategory']}&ordercoloum=${widget.data['orderName']}&ordersort=${widget.data['orderType']}&searchtext=${widget.data['searchtext']}');
    var res = await CallApi().getData(
        '/app/showNewProductfilter?max=${maxController.text}&min=${minController.text}&cat=$cat&sub=$subCat&ordercoloum=$orderName&ordersort=$orderType&searchtext=$search');
    body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
      _getFilterlist();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _getFilterlist() {
    var newFilter = AllProductModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      filterList = newFilter.product.reversed.toList();
    });
  }

  Future<void> getCategory() async {
    var res = await CallApi().getData('/app/showCategory');
    body1 = json.decode(res.body);

    //print(body);

    if (res.statusCode == 200) {
      _getCategorylist();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _getCategorylist() {
    var newCat = CategoryModel.fromJson(body1);
    if (!mounted) return;
    setState(() {
      catList = newCat.status;
    });
  }

  Future<void> getSubcategory() async {
    var res = await CallApi().getData('/app/showSubCategory?cat=$catId');
    body2 = json.decode(res.body);

    //print(body1);

    if (res.statusCode == 200) {
      _getSubCategorylist();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _getSubCategorylist() {
    var newSub = SubCategoryModel.fromJson(body2);
    if (!mounted) return;
    setState(() {
      subCatList = newSub.status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: appTealColor,
        title: isSearch == false
            ? Text(FlutterI18n.translate(context,"New_Arrival") )
            : Container(
                height: 50.0,
                margin: EdgeInsets.only(right: 0, left: 0),
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
                     hintText: FlutterI18n.translate(context, "Search"),
                    hintStyle: TextStyle(color: appGreyDarkColor),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5.0, top: 15.0),
                    suffixIcon: search != ""
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.text = "";
                                search = "";
                              });
                            },
                            icon: Icon(Icons.arrow_forward),
                            color: Colors.grey,
                          )
                        : Icon(
                            Icons.cancel,
                            color: Colors.transparent,
                          ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      //  _searchShop();
                      filterList = null;
                      search = val;
                      getFilterData();
                    });
                  },
                ),
              ),
        actions: <Widget>[
          Container(
            height: 45.0,
            padding: EdgeInsets.only(bottom: 5, right: 10, top: 5),
            child: GestureDetector(
              onTap: () {
                //_filterPage();
              },
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSearch == false) {
                            isSearch = true;
                          } else {
                            isSearch = false;
                          }
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(
                              isSearch == true ? Icons.close : Icons.search,
                              color: Colors.white)),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isFilter == false) {
                            isFilter = true;
                          } else {
                            filterList = null;
                            isFilter = false;
                            getFilterData();
                          }
                        });
                      },
                      child: Container(
                          child: Icon(
                              isFilter == true ? Icons.done : Icons.filter_list,
                              color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: filterList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : filterList.length == 0
              ? Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                         child: Text(FlutterI18n.translate(context, "No_products_found")+"!"),
                        
                        
                      ),
                    ),
                    isFilter == false
                        ? Container()
                        : Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            selection(1);
                                          },
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.attach_money,
                                                  size: 11,
                                                  color: minController.text ==
                                                              "" &&
                                                          maxController.text ==
                                                              ""
                                                      ? Colors.black54
                                                      : appTealColor,
                                                ),
                                                Text(
                                                  minController.text == "" &&
                                                          maxController.text ==
                                                              ""
                                                      ? FlutterI18n.translate(context, "Total_Price")
                                                      : minController.text ==
                                                                  "" &&
                                                              maxController
                                                                      .text !=
                                                                  ""
                                                          ? FlutterI18n.translate(context, "Max")+": ${maxController.text}"
                                                          : minController.text !=
                                                                      "" &&
                                                                  maxController
                                                                          .text ==
                                                                      ""
                                                              ? FlutterI18n.translate(context, "Min")+":  ${minController.text}"
                                                              :  FlutterI18n.translate(context, "Min")+" ${minController.text}"+ FlutterI18n.translate(context, "Max") +"${maxController.text}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: minController
                                                                      .text ==
                                                                  "" &&
                                                              maxController
                                                                      .text ==
                                                                  ""
                                                          ? Colors.black54
                                                          : appTealColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          height: 20,
                                          child: VerticalDivider(
                                            color: appTealColor,
                                          )),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            selection(2);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.category,
                                                  size: 10,
                                                  color: cat == ""
                                                      ? Colors.black54
                                                      : appTealColor,
                                                ),
                                                Text(
                                                    catName == ""
                                                        ?  FlutterI18n.translate(context, "Category")
                                                        : "$catName",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: cat == ""
                                                            ? Colors.black54
                                                            : appTealColor)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          height: 20,
                                          child: VerticalDivider(
                                            color: appTealColor,
                                          )),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            selection(3);
                                          },
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.list,
                                                  size: 10,
                                                  color: subCatName == ""
                                                      ? Colors.black54
                                                      : appTealColor,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      subCatName == ""
                                                          ? FlutterI18n.translate(context, "Sub_category")
                                                          : "$subCatName",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: subCatName ==
                                                                  ""
                                                              ? Colors.black54
                                                              : appTealColor)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(top: 10, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            selection(4);
                                          },
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.line_style,
                                                  size: 10,
                                                  color: orderName == ""
                                                      ? Colors.black54
                                                      : appTealColor,
                                                ),
                                                Text(
                                                    nameOrder == ""
                                                        ? FlutterI18n.translate(context, "Order_Name")
                                                        : "$nameOrder",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: orderName == ""
                                                            ? Colors.black54
                                                            : appTealColor)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          height: 20,
                                          child: VerticalDivider(
                                            color: appTealColor,
                                          )),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            selection(5);
                                          },
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.line_weight,
                                                  size: 10,
                                                  color: orderType == ""
                                                      ? Colors.black54
                                                      : appTealColor,
                                                ),
                                                Text(
                                                    typeOrder == ""
                                                        ? FlutterI18n.translate(context, "Order_Type") 
                                                        : "$typeOrder",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: orderType == ""
                                                            ? Colors.black54
                                                            : appTealColor)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                )
              : SafeArea(
                  child: Container(
                      margin: EdgeInsets.only(
                        left: 0,
                        right: 0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 4, bottom: 5),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: isFilter == false ? 0 : 60),
                            child: OrientationBuilder(
                              builder: (context, orientation) {
                                return orientation == Orientation.portrait
                                    ////// <<<<< Portrait Card start >>>>> //////
                                    ? GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3) /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      4),
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                new Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ProductsCard(
                                              user, filterList[index]),
                                        ),
                                        itemCount: filterList.length,
                                      )
                                    ////// <<<<< Portrait Card end >>>>> //////
                                    :
                                    ////// <<<<< Landscape Card start >>>>> //////
                                    GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2) /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2.5),
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                new Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ProductsCard(
                                              user, filterList[index]),
                                        ),
                                        itemCount: filterList.length,
                                      );
                                ////// <<<<< Landscape Card end >>>>> //////
                              },
                            ),
                          ),
                          isFilter == false
                              ? Container()
                              : Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  selection(1);
                                                },
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.attach_money,
                                                        size: 11,
                                                        color: minController
                                                                        .text ==
                                                                    "" &&
                                                                maxController
                                                                        .text ==
                                                                    ""
                                                            ? Colors.black54
                                                            : appTealColor,
                                                      ),
                                                      Text(
                                                        minController.text ==
                                                                    "" &&
                                                                maxController
                                                                        .text ==
                                                                    ""
                                                            ?FlutterI18n.translate(context, "Total_Price")
                                                            : minController.text ==
                                                                        "" &&
                                                                    maxController
                                                                            .text !=
                                                                        ""
                                                                ? FlutterI18n.translate(context, "Max")+": ${maxController.text}"
                                                                : minController.text !=
                                                                            "" &&
                                                                        maxController.text ==
                                                                            ""
                                                                    ? FlutterI18n.translate(context, "Min")+":  ${minController.text}"
                                                                    : FlutterI18n.translate(context, "Min")+" ${minController.text}"+ FlutterI18n.translate(context, "Max") +"${maxController.text}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: minController
                                                                            .text ==
                                                                        "" &&
                                                                    maxController
                                                                            .text ==
                                                                        ""
                                                                ? Colors.black54
                                                                : appTealColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: 20,
                                                child: VerticalDivider(
                                                  color: appTealColor,
                                                )),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  selection(2);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.category,
                                                        size: 10,
                                                        color: cat == ""
                                                            ? Colors.black54
                                                            : appTealColor,
                                                      ),
                                                      Text(
                                                          catName == ""
                                                              ? FlutterI18n.translate(context, "Category")
                                                              : "$catName",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: cat == ""
                                                                  ? Colors
                                                                      .black54
                                                                  : appTealColor)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: 20,
                                                child: VerticalDivider(
                                                  color: appTealColor,
                                                )),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  selection(3);
                                                },
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.list,
                                                        size: 10,
                                                        color: subCatName == ""
                                                            ? Colors.black54
                                                            : appTealColor,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            subCatName == ""
                                                                ? FlutterI18n.translate(context, "Sub_category")
                                                                : "$subCatName",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: subCatName ==
                                                                        ""
                                                                    ? Colors
                                                                        .black54
                                                                    : appTealColor)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        padding:
                                            EdgeInsets.only(top: 10, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  selection(4);
                                                },
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.line_style,
                                                        size: 10,
                                                        color: orderName == ""
                                                            ? Colors.black54
                                                            : appTealColor,
                                                      ),
                                                      Text(
                                                          nameOrder == ""
                                                              ?  FlutterI18n.translate(context, "Order_Name")
                                                              : "$nameOrder",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: orderName ==
                                                                      ""
                                                                  ? Colors
                                                                      .black54
                                                                  : appTealColor)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: 20,
                                                child: VerticalDivider(
                                                  color: appTealColor,
                                                )),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  selection(5);
                                                },
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.line_weight,
                                                        size: 10,
                                                        color: orderType == ""
                                                            ? Colors.black54
                                                            : appTealColor,
                                                      ),
                                                      Text(
                                                          typeOrder == ""
                                                              ?FlutterI18n.translate(context, "Order_Type") 
                                                              : "$typeOrder",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: orderType ==
                                                                      ""
                                                                  ? Colors
                                                                      .black54
                                                                  : appTealColor)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      )),
                ),
    );
  }

  Container priceInputField(String label, TextEditingController control) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              // width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 5),
              child: Text(
                 FlutterI18n.translate(context, label),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Oswald',
                    fontWeight: FontWeight.w400),
              )),
          Container(
            //   width: ,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
            margin: EdgeInsets.only(top: 13),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                border: Border.all(width: 0.2, color: Colors.grey)),
            child: TextFormField(
              cursorColor: Colors.grey,
              controller: control,
              keyboardType: TextInputType.number,
              autofocus: false,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                //  hintText: hint,
                hintStyle: TextStyle(fontSize: 14),
                //labelText: 'Enter E-mail',
                contentPadding: EdgeInsets.fromLTRB(0.0, 8.0, 20.0, 0.0),
                border: InputBorder.none,
              ),
              validator: (val) => val.isEmpty ? 'Field is empty' : null,
              // onSaved: (val) => name = val,
              //validator: _validateEmail,
            ),
          ),
        ],
      ),
    );
  }

  void selection(int num) {
    num == 1
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: Column(
                  children: <Widget>[
                    new Text(FlutterI18n.translate(context, "Price") ),
                    Divider(
                      color: Colors.grey[400],
                    ),
                    priceInputField("Min_Price", minController),
                    priceInputField("Max_Price", maxController),
                  ],
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            maxPrice = maxController.text;
                            minPrice = minController.text;
                          });
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      child: Text(
                                    FlutterI18n.translate(context, "Cancel"),
                                    style: TextStyle(color: Colors.grey),
                                  )))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            maxPrice = maxController.text;
                            minPrice = minController.text;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new OutlineButton(
                                borderSide: BorderSide(
                                    color: appTealColor,
                                    style: BorderStyle.solid,
                                    width: 1),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(50.0)),
                                child: new Text(
                                  FlutterI18n.translate(context, "Done"),
                                  style: TextStyle(color: appTealColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        : num == 2
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      title: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(top: 5, bottom: 15),
                                child: new Text(FlutterI18n.translate(context, "Category"))),
                            Divider(
                              height: 0,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                      content: Container(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: 40,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:
                                    List.generate(catList.length, (index) {
                                  return categoryList(catList[index]);
                                })),
                          ),
                        ),
                      ));
                },
              )
            : num == 3
                ? showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          title: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 5, bottom: 15),
                                    child: new Text(FlutterI18n.translate(context, "Sub_category"))),
                                Divider(
                                  height: 0,
                                  color: Colors.grey[400],
                                ),
                              ],
                            ),
                          ),
                          content: Container(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Container(
                                padding: EdgeInsets.only(
                                  bottom: 40,
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(subCatList.length,
                                        (index) {
                                      return subCategoryList(subCatList[index]);
                                    })),
                              ),
                            ),
                          ));
                    },
                  )
                : num == 4
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              title: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 15),
                                        child: new Text(FlutterI18n.translate(context, "Order_Name"))),
                                    Divider(
                                      height: 0,
                                      color: Colors.grey[400],
                                    ),
                                  ],
                                ),
                              ),
                              content: Container(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: 40,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        nameList("ID"),
                                        nameList("Name"),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                      )
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              title: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 15),
                                        child: new Text(FlutterI18n.translate(context, "Order_Type") )),
                                    Divider(
                                      height: 0,
                                      color: Colors.grey[400],
                                    ),
                                  ],
                                ),
                              ),
                              content: Container(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: 40,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[

                                       

                                     
                                        typeList( nameOrder=="Name"?"A_to_Z":"First_to_Last"),
                                          typeList( nameOrder=="Name"?"Z_to_A":"Last_to_First"),

                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                      );
  }

  Container categoryList(var catList) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            int cats = catList.id;
            catId = catList.id;
            cat = "$cats";
            catName = catList.name;
            getSubcategory();
          });
          Navigator.pop(context);
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(bottom: 12, top: 12, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  catList.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container subCategoryList(var subCatList) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            int subCats = subCatList.id;
            subCat = "$subCats";

            subCatName = subCatList.name;
          });
          Navigator.pop(context);
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(bottom: 12, top: 12, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  subCatList.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container nameList(String name) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (name == FlutterI18n.translate(context,"ID")) {
              orderName = "id";
           } else if(name==FlutterI18n.translate(context,"Name")){
              orderName = "name";
            }
           

            nameOrder = name;
            Navigator.pop(context);
          });
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(bottom: 12, top: 12, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  FlutterI18n.translate(context, name),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container typeList(String type) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (type == FlutterI18n.translate(context, "A_to_Z") || type == FlutterI18n.translate(context, "Low_to_High") || type ==FlutterI18n.translate(context, "First_to_Last")) {
              orderType = "asc";
           } else if(type == FlutterI18n.translate(context, "Z_to_A") || type == FlutterI18n.translate(context, "High_to_Low") || type ==FlutterI18n.translate(context, "Last_to_First")){
              orderType = "desc";
            }
            typeOrder = type;
            Navigator.pop(context);
          });
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(bottom: 12, top: 12, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                 FlutterI18n.translate(context, type),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
