import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/CategoryPage/CategoryPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/Filter/portraitTags.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/ProductDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductPage/ProductPage.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/model/CategoryModel/categoryModel.dart';
import 'package:ecommerce_bokkor_dev/model/SubCategoryModel/subCategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => new _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  int _current = 0;
  int _isBack = 0;
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
  double _itemsliderValue1 = 0.0;
  double _itemsliderValue2 = 1000.0;
  var body, body1, catList, subCatList;
  bool _isLoading = true;

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

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

  @override
  void initState() {
    getCategory();
    getSubcategory();
    super.initState();
  }

  Future<void> getCategory() async {
    var res = await CallApi().getData('/app/showCategory');
    body = json.decode(res.body);

    //print(body);

    if (res.statusCode == 200) {
      _getCategorylist();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _getCategorylist() {
    var newCat = CategoryModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      catList = newCat.status;
    });
  }

  Future<void> getSubcategory() async {
    var res = await CallApi().getData('/app/showSubCategory');
    body1 = json.decode(res.body);

    //print(body1);

    if (res.statusCode == 200) {
      _getSubCategorylist();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _getSubCategorylist() {
    var newSub = SubCategoryModel.fromJson(body1);
    if (!mounted) return;
    setState(() {
      subCatList = newSub.status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: appTealColor,
        title:  Text(FlutterI18n.translate(context, "Filter"),),
      ),
      //body: new Text("It's a Dialog!"),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.all(0.0),
                //color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(height: 2, child: Divider()),
                    Expanded(
                      child: Container(
                        child: ListView(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                // print("object");
                                selection(1);
                              },
                              child: Container(
                                child: ListTile(
                                  title: Container(
                                      child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.attach_money,
                                        color: Colors.grey,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  FlutterI18n.translate(context, "Price"),
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 8, top: 3),
                                              child: Text(
                                                FlutterI18n.translate(context, "Find_product_by_range_of_price"),
                                                
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12),
                                              )),
                                          minController.text == "" ||
                                                  maxController.text == ""
                                              ? Container()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      left: 8, top: 3),
                                                  child: Text(
                                                   FlutterI18n.translate(context, "Minimum_Price")+":" +'${minController.text}'+FlutterI18n.translate(context, "Maximum_Price") +":"+ '${maxController.text}',
                                                    style: TextStyle(
                                                        color: appTealColor,
                                                        fontSize: 12),
                                                  ))
                                        ],
                                      ),
                                    ],
                                  )),
                                  trailing: Icon(Icons.chevron_right),
                                ),
                              ),
                            ),
                            Divider(),
                            GestureDetector(
                              onTap: () {
                                selection(2);
                              },
                              child: ListTile(
                                title: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.category,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(
                                                FlutterI18n.translate(context, "Category"),
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 8, top: 3),
                                            child: Text(
                                              FlutterI18n.translate(context, "Find_product_by_suitable_Category"),
                                              
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            )),
                                        catName == ""
                                            ? Container()
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    left: 8, top: 3),
                                                child: Text(
                                                 FlutterI18n.translate(context, "Category")+":"+ '${catName}',
                                                  style: TextStyle(
                                                      color: appTealColor,
                                                      fontSize: 12),
                                                ))
                                      ],
                                    ),
                                  ],
                                )),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                            Divider(),
                            GestureDetector(
                              onTap: () {
                                selection(3);
                              },
                              child: ListTile(
                                title: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.list,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(
                                                FlutterI18n.translate(context, "Sub-category"),
                                               
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 8),
                                            child: Text(
                                               FlutterI18n.translate(context, "Find_product_by_any_sub_category"),
                                              
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            )),
                                        subCatName == ""
                                            ? Container()
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    left: 8, top: 3),
                                                child: Text(
                                                 FlutterI18n.translate(context, "Sub-category")+ ": $subCatName",
                                                  style: TextStyle(
                                                      color: appTealColor,
                                                      fontSize: 12),
                                                ))
                                      ],
                                    ),
                                  ],
                                )),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                            Divider(),
                            GestureDetector(
                              onTap: () {
                                selection(4);
                              },
                              child: ListTile(
                                title: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.line_style,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(
                                                FlutterI18n.translate(context, "Order_Name"),
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 8),
                                            child: Text(
                                              FlutterI18n.translate(context, "Find_product_by_order_name"),
                                              
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            )),
                                        nameOrder == ""
                                            ? Container()
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    left: 8, top: 3),
                                                child: Text(
                                                FlutterI18n.translate(context, "Order")+  ": $nameOrder",
                                                  style: TextStyle(
                                                      color: appTealColor,
                                                      fontSize: 12),
                                                ))
                                      ],
                                    ),
                                  ],
                                )),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                            Divider(),
                            GestureDetector(
                              onTap: () {
                                selection(5);
                              },
                              child: ListTile(
                                title: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.line_weight,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(
                                                 FlutterI18n.translate(context, "Order_Type"),
                                             
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 8),
                                            child: Text(
                                               FlutterI18n.translate(context, "Find_product_by_order_type"),
                                              
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            )),
                                        typeOrder == ""
                                            ? Container()
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    left: 8, top: 3),
                                                child: Text(
                                                  FlutterI18n.translate(context, "Type")+": $typeOrder",
                                                  style: TextStyle(
                                                      color: appTealColor,
                                                      fontSize: 12),
                                                ))
                                      ],
                                    ),
                                  ],
                                )),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          // alignment: Alignment.bottomCenter,
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          // height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    var data = {
                                      "minPrice": minController.text,
                                      "maxPrice": maxController.text,
                                      "category": cat,
                                      "subCategory": subCat,
                                      "orderName": orderName,
                                      "orderType": orderType,
                                      "searchtext": "",
                                    };

                                    Navigator.push(
                                        context,
                                        SlideLeftRoute(
                                            page: ProductPage(data)));
                                    // setState(() {
                                    //   print(maxController.text);
                                    //   print(minController.text);
                                    //   print(cat);
                                    //   print(subCat);
                                    //   print(orderName);
                                    //   print(orderType);
                                    // });
                                  },
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          color: appTealColor.withOpacity(0.3),
                                          border: Border.all(
                                              width: 0.2, color: Colors.grey)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.search,
                                            size: 20,
                                            color: appTealColor,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Text(FlutterI18n.translate(context, "Search"),
                                                  style: TextStyle(
                                                      color: appTealColor,
                                                      fontSize: 17)))
                                        ],
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
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
                    new Text(FlutterI18n.translate(context, "Price"),),
                    Divider(
                      color: Colors.grey[400],
                    ),
                    priceInputField("Min_Price", minController),
                    priceInputField("Max_Price", maxController),
                  ],
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
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
                          new OutlineButton(
                            borderSide: BorderSide(
                                color: appTealColor,
                                style: BorderStyle.solid,
                                width: 1),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0)),
                            child: new Text(
                              FlutterI18n.translate(context, "Ok"),
                              
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
                                child: new Text(
                                   FlutterI18n.translate(context, "Category"),
                                  )),
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
                                    child: new Text(
                                     FlutterI18n.translate(context, "Sub-category"),
                                      )),
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
                                        child: new Text(
                                           FlutterI18n.translate(context, "Order_Name"),
                                       
                                          )),
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
                                        child: new Text(FlutterI18n.translate(context, "Order_Type"))),
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
                                        typeList("A_to_Z"),
                                        typeList("Z_to_A"),
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
            cat = "$cats";

            catName = catList.name;
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
            } else {
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
            if (type == FlutterI18n.translate(context, "A_to_Z")) {
              orderType = "asc";
            } else {
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
