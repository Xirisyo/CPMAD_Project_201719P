import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_project/components/global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallAPI {
  final String _url = 'http://${Globals.apiIP}/CPMAD_GameAPI/api';

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  sendData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(jsonEncode(data) + ' ' + fullUrl);
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}
