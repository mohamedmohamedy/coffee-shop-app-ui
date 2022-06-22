import 'dart:convert';
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;
  String? _token;
  DateTime? _expiryDate;
  Timer? _authTimer;

// Making sure the user is authenticated...
  String? get token {
    if (_token != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _expiryDate != null) {
      return _token;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String? get userId {
    if (_userId != null) {
      return _userId;
    }
    return null;
  }

  // Making a signing method because it is the same logic to avoid repeating and make clean, linear code.
  Future<void> _authenticate(
      String? email, String? password, String? segment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$segment?key=AIzaSyBllw0DalXtZ7q4GJdiJGgOPM_OaUh2jZ0');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      // Catching errors with our HttpException class if exists...
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      // Get user data...
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      autoSignOut();
      notifyListeners();

      // Save user data on the hard storage..
      final prefs = await SharedPreferences.getInstance();

      final userData = json.encode({
        'token': _token,
        'expireDate': _expiryDate!.toIso8601String(),
        'userId': _userId,
      });

      prefs.setString('userData', userData);

      //catch errors if not in HttpException...
    } catch (error) {
      rethrow;
    }
  }

//.........................Sign Up................................................

  Future<void> signUp(String? email, String? password) async {
    await _authenticate(email, password, 'signUp');
  }

  //.........................Sign in..................................................

  Future<void> signIn(String? email, String? password) async {
    await _authenticate(email, password, 'signInWithPassword');
  }

  //...................Sign out.....................................................
  Future<void> signOut() async {
    _expiryDate = null;
    _token = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  //........................Auto sign out.........................................
  void autoSignOut() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }

    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;

    _authTimer = Timer(
      Duration(seconds: timeToExpiry),
      signOut,
    );
  }

  //..........................Auto Sign in.................................
  Future<bool> autoLogIn() async {
    final prefs = await SharedPreferences.getInstance();

    // make sure user have token..
    if (!prefs.containsKey('userData')) {
      return false;
    }

    // fetch the user data...
    final data =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

    // make sure token is still valid..
    final expiryDate = DateTime.parse(data['expireDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    // Extract user data...
    _token = data['token'] as String;
    _userId = data['userId'] as String;
    _expiryDate = expiryDate;

    notifyListeners();
    autoSignOut();
    return true;
  }
}
