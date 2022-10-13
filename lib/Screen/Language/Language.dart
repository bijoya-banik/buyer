import 'dart:convert';

import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  Locale currentLang;
  //List languageOptions=[];
  var languageOptions = [
    {'flag': 'assets/images/us.jpeg', 'name': 'English', 'selected': false, 'id': 1, 'code': 'en'},
    {
      'flag': 'assets/images/bahrain-flag.jpg',
      'name': 'عربى', 
      'selected': false,
      'id': 3, 
      'code': 'bh'
    },
    
  ];

  var languageData;
 // bool _isLoading = true;

  @override
  void initState() {
    // get the current 

   // _getLanguage();
    super.initState();
    new Future.delayed(Duration.zero, () async {
    //  setState(() {
        currentLang = FlutterI18n.currentLocale(context);
        print(currentLang);
     // });
    });
    
    changeSelectedLang();
 }

  //  void _getLanguage() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var language = localStorage.getString('language-list');
  
  //  // print(user);
  //   setState(() {
  //     languageData = json.decode(language);
  //     _isLoading = false;
  //     print(languageData['language']);
        
  //   });

    // for(var d in languageData['language']){

    //   languageOptions.add( {
    //   'flag': d['flag_language'],
    //   'name': d['name'],
    //   'selected': false,
    //   'id': d['id'], 
    // });

    // }
    // print(languageOptions);
  //}

  void changeSelectedLang() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var localCode =  localStorage.getString('localCode');
   

    for (var d in languageOptions) {
      if (localCode == d['code']) {
       setState(() {
          d['selected'] = true;
       });

       print(d['selected']);
       } 
    }
  }

  

  changeLanguage(String name) {
    setState(() {
      currentLang = new Locale(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
       appBar:  AppBar(
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                  // bottomNavIndex = 2;
                  // Navigator.push(context, SlideLeftRoute(page: Navigation()));
                },
              );
            },
          ),
          title: Text(
             FlutterI18n.translate(context, "Change_Language"),
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          backgroundColor: appTealColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              children: _showLanguageOptions(),
            ),
          ),
        ));
  }
   


  List<Widget> _showLanguageOptions() {
    List<Widget> items = [];
    var index = 0;
    for (var d in languageOptions) {
      items.add(
        GestureDetector(
          onTap: () async {
            _changeLanguageOptions(d['id']);
            print(d['id']);
            changeLanguage(d['code']);
            await FlutterI18n.refresh(context, currentLang);
          },
          child: Container(
            padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        //child: ClipOval(
                        //     child: Image.asset(
                        //   "assets/images/profile.png",
                        //   height: 45,
                        //   width: 45,
                        //   fit: BoxFit.fill,
                        // )
                       // ) ,
                        margin: EdgeInsets.only(bottom: 1.0),
                        child: d['flag']==null?Container():Image.asset(
                          d['flag'],
                          height: 40,
                          width: 50,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        //color: Colors.red,
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                           // FlutterI18n.translate(context, d['name']),
                          "${d['name']}",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 19.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'BebasNeue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ], 
                  ),
                ),

                /////////Join Button start/////////

                Container(
                    child: d['selected']
                        ? Icon(
                            Icons.check_circle,
                            color: appTealColor,
                          )
                        : Container())

                /////////Join Button end/////////
              ],
            ),
          ),
        ),
      );
      index++;
    }

    return items;
  }

  void _changeLanguageOptions(id) async{
    var code;
    for (var d in languageOptions) {
      if (id == d['id']) {
        setState(() {
          d['selected'] = true;
        code = d['code'];
        });
      } else {
       setState(() {
          d['selected'] = false;
       });
      }
    }
    // save the language in shared prefrences 
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('localCode', code);
    
    setState(() {
      languageOptions = languageOptions;
    });
  }
}
