// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class CallApi {
//   final String _url = 'http://192.168.0.106:8000';

//   postData(data, apiUrl) async {
//     var fullUrl = _url + apiUrl + await _getToken();
//     //print(fullUrl);
//     return await http.post(fullUrl,
//         body: jsonEncode(data), headers: _setHeaders());
//   }

//   getData(apiUrl) async {
//     var fullUrl = _url + apiUrl + await _getToken();
//     return await http.get(fullUrl, headers: _setHeaders());
//   }

//   _setHeaders() => {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//       };

//   _getToken() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var token = localStorage.getString('token');
//     return '?token=$token';
//   }
// }
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  // final String _url = 'https://www.dynamyk.biz/';
  //final String _url = 'http://192.168.0.124:8000';
  final String _url = 'https://mobile.bahrainunique.com';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    //print(await _setHeaders());
    print(fullUrl);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: await setHeaders());
  }

  getData(apiUrl) async {                                 
    var fullUrl = _url + apiUrl;
    print(fullUrl);                                 
    return await http.get(fullUrl, headers: await setHeaders());
  }    

  getData1(apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.post(fullUrl, headers: await setHeaders());
  }

  putData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    //print(await _setHeaders());
    return await http.put(fullUrl,
        body: jsonEncode(data), headers: await setHeaders());
  }

  setHeaders() async => {
        "Authorization": 'Bearer ' + await _getToken(),
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '$token';
  }
}
