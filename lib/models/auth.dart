import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  // static const _url =
  //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBNvjPWzm0G1FydYhM5OS4chndxmjwP8ds';

  Future<void> _autenthicate(
      String email, String password, String urlFragment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyBNvjPWzm0G1FydYhM5OS4chndxmjwP8ds';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
  }

  Future<void> signup(String email, String password) async {
    _autenthicate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    _autenthicate(email, password, 'signInWithPassword');
  }
}
