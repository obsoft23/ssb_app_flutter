// ignore_for_file: unused_import, unused_field, unused_local_variable, unused_element, avoid_print, prefer_adjacent_string_concatenation, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/constructors/signup_error.dart';

//import 'package:sqflite/sqflite.dart';

class Network {
  static var baseURL = "http://localhost:8000/api/";
// static var baseURL = "http://10.0.2.2:8000/api/";
  static dynamic token;
  //if you are using android studio emulator, change localhost to 10.0.2.2

  static final authHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $Network().getToken(token)'
  };

  static final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $Network.getToken(token)'
  };

  static _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/*',
      };

  setToken(token) async {
    final prefs = await SharedPreferences.getInstance();
    token = await prefs.setString('token', token);
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
  }

  clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('counter');
    return success;
  }

  setUserId(id) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.setInt("id", id);
  }

  getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt("id");
    return id;
  }

  clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('id');
  }

  setEmail(email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
  }

  getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email");
  }

  clearEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }

  setProfessionalStatus(value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString("has_professional_acc", value);
  }

  getProfessionalStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("has_professional_acc");
  }

  clearProfessionalStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('has_professional_acc');
  }

  setBusinessId(value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt("business_id", value);
  }



  clearBusinessId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('business_id');
  }

  registerUser(String name, email, String password, platformType) async {
    // ignore: prefer_typing_uninitialized_variables
    var url = Uri.parse('http://localhost:8000/api/auth/register');
    final data = {"name": name, "email": email, "password": password};
    final body = jsonEncode(data);
    debugPrint(body);
    return await http.post(url, body: data);
  }

  loginUser(String email, String password) async {
    var url = Uri.parse("http://localhost:8000/api/auth/login"); //needs fixing
    final data = {"email": email, "password": password};
    final body = jsonEncode(data);
    debugPrint("to be sent: ${body}");
    return await http.post(url, body: body, headers: Network.authHeaders);
  }

  updateUser(name, email, phone, bio, image, token, id) async {
    final Uri url = Uri.parse("http://localhost:8000/api/auth/update");
    final data = {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "bio": bio,
      "image": image
    };

    final body = jsonEncode(data);
    debugPrint("sending request: ${body}");
    return await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
  }

  fetchUser(token) async {
    var url = Uri.parse("http://localhost:8000/api/profile/fetch");
    print("token to attach to fetch user: ${token}");
    return await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
  }

  static List<User> parseUser(responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static List<User> parseError(responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  void logout() async {
    /*var res = await Network().postData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      //Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }*/
  }
}
