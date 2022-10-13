
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategory.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategoryProducts/SubCategoryProducts.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CategoryCard extends StatefulWidget {
  final index;
  CategoryCard(this.index);
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
           Navigator.push(
                          context, SlideLeftRoute(page: CategorySearchDialog()));
        },
        child: Container(
        //  margin: EdgeInsets.only(bottom: 0, top: 5, left: 2.5, right: 2.5),
          decoration: BoxDecoration(
           color: Colors.white,
            borderRadius: BorderRadius.only(
              
                bottomLeft:   Radius.circular(10),
                bottomRight:   Radius.circular(10)
              ),
            boxShadow: [
              BoxShadow(
                blurRadius: 1.0,
                color: Colors.black.withOpacity(.5),
              ),
            ],
          ),
          child: GridTile(
            child: Container(
              padding: EdgeInsets.only(bottom: 0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                     
                    //  child: Icon(
                    //    Icons.account_circle,
                    //      color: appTealColor,
                    //      size: 30
                       
                       
                    //  ),
                      child: Container(
                       // color: Colors.blue,
                       // padding: const EdgeInsets.all(5.0),
                       // margin: EdgeInsets.only(top: 5),
                        child: Image.asset(
                          'assets/images/category.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                          // height: 150,
                          // width: MediaQuery.of(context)
                          //                   .size
                          //                   .width/2 ,
                          //                   fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Divider(
                      height: 0,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                   
                    padding: EdgeInsets.fromLTRB(5, 8, 5, 13),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ////// <<<<< Name start >>>>> //////
                        Expanded(
                          child: Text(
                              "Furniture",
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black87,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ////// <<<<< Name end >>>>> //////
                      ],
                    ),
                  ),
               
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
