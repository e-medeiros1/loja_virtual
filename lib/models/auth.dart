import 'dart:async';
import 'dart:convert';

import 'package:e_shop/exceptions/auth_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expireDate;
  Timer? _logoutTime;
//Recebendo token depois do submit

  bool get isAuth {
    //Verifica se a data é depois da atual
    final isValid = _expireDate?.isAfter(DateTime.now()) ?? false;
    //Infos necessárias para saber se o user está autenticado
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

  Future<void> _authenticate(
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

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(key: body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];
      //Salva a data atual + uma duração de 3600 segundos
      _expireDate = DateTime.now().add(Duration(
        seconds: int.parse(body['expiresIn']),
      ));
      _autoLogout();
      notifyListeners();
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logout() {
    _token = null;
    _email = null;
    _uid = null;
    _expireDate = null;
    _clearLogoutTimer();
    notifyListeners();
  }

  void _clearLogoutTimer() {
    _logoutTime?.cancel();
    _logoutTime = null;
  }

//AutoLogout method
  void _autoLogout() {
    final _timeToLogout = _expireDate?.difference(DateTime.now()).inSeconds;
    _logoutTime = Timer(Duration(seconds: _timeToLogout ?? 0), logout);
  }
}
