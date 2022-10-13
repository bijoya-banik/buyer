import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewContainer extends StatefulWidget {
  final review;
  ReviewContainer(this.review);
  @override
  _ReviewContainerState createState() => _ReviewContainerState();
}

class _ReviewContainerState extends State<ReviewContainer> {
  double rating = 0;
  String firstName = "", lastName = "";
  @override
  void initState() {
    setState(() {
      int rate = widget.review.rating;
      rating = rate.toDouble();

      String fn = "${widget.review.user.firstName}";

      firstName = fn;

      String ln = "${widget.review.user.lastName}";

      lastName = ln;

      String replaceCharAt(String oldString, int index, String newChar) {
        return oldString.substring(0, index) +
            newChar +
            oldString.substring(index + 1);
      }

      for (int i = 1; i < fn.length; i++) {
        firstName = replaceCharAt(firstName, i, "*");
        print("$firstName");
      }

      for (int i = 1; i < ln.length; i++) {
        lastName = replaceCharAt(lastName, i, "*");
        print("$lastName");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.white, blurRadius: 1.0, offset: Offset(0.0, 3.0))
        ],
      ),
      margin: EdgeInsets.only(bottom: 5, top: 5),
      padding: EdgeInsets.only(bottom: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.only(right: 10),
            decoration: new BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/camera.png')),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.only(left: 2, top: 3, bottom: 4),
                child: Text(
                  "$firstName $lastName",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Color(0xFF343434),
                    fontSize: 15.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'MyriadPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: null,
                          starCount: 5,
                          rating: rating,
                          size: 20.0,
                          color: Color(0xFFffa900),
                          borderColor: Color(0xFF707070),
                          spacing: 0.0),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 2),
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  "${widget.review.review}",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'MyriadPro',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              // Center(
              //   child: Html(
              //     data: "${widget.review.review}",
              //     padding: EdgeInsets.all(8.0),
              //     onLinkTap: (url) {
              //       print("Opening $url...");
              //     },
              //     // customRender: (node, children) {
              //     //   if (node is dom.Element) {
              //     //     switch (node.localName) {
              //     //       case "custom_tag": // using this, you can handle custom tags in your HTML
              //     //         return Column(children: children);
              //     //     }
              //     //   }
              //     // },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
