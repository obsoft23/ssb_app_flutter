// ignore_for_file: unused_import, unused_field, unused_local_variable, unused_element, avoid_print, prefer_adjacent_string_concatenation, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//import 'package:sqflite/sqflite.dart';

class Network {
  static var baseURL = "http://localhost:8000";
// static var baseURL = "http://10.0.2.2:8000/api/";

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
    return prefs.setInt("has_professional_acc", value);
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
    var url = Uri.parse('${Network.baseURL}/api/auth/register');
    final data = {"name": name, "email": email, "password": password};
    final body = jsonEncode(data);
    debugPrint("data sent  trying to register user$body");
    return await http.post(url, body: data);
  }

  loginUser(String email, String password) async {
    var url = Uri.parse("${Network.baseURL}/api/auth/login"); //needs fixing
    final data = {"email": email, "password": password};
    final body = jsonEncode(data);
    debugPrint("to be sent: ${body}");
    return await http.post(url, body: body, headers: Network.authHeaders);
  }

  updateUser(name, email, phone, bio, image, token, id) async {
    final Uri url = Uri.parse("${Network.baseURL}/api/auth/update");
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
    var url = Uri.parse("${Network.baseURL}/api/profile/fetch");
    print("token to attach to fetch user: ${token}");
    return await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
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

  likes(isLiked, businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt('id');
    final Uri url = Uri.parse("${Network.baseURL}/api/business/update/like");
    final data = {
      "isLiked": isLiked,
      "business_id": businessId,
      "user_id": _id
    };

    final body = jsonEncode(data);

    debugPrint("sending request for likes or not: ${body}");

    final response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );
    print(json.decode(response.body));
    return isLiked;
  }

  Future<bool> confirmIfUserLiked(businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt('id');
    final Uri url = Uri.parse("${Network.baseURL}/api/business/confirm/like");
    final data = {"business_id": businessId, "user_id": _id};

    final body = jsonEncode(data);

    debugPrint("sending request for see if previusly liked: ${body}");

    final request = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );
    final response = json.decode(request.body);
    print(response);
    if (response == true) {
      return true;
    } else {
      return false;
    }
    //
  }

  sendReview(businessId, review, rating) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id');
    final Uri url = Uri.parse("${Network.baseURL}/api/business/confirm/review");
    final data = {
      "business_id": businessId,
      "user_id": userId,
      "review": review,
      "rating": rating,
    };

    final body = jsonEncode(data);

    debugPrint("sending request for save review: ${body}");
    final request = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );

    final response = json.decode(request.body);
    print(response);
    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
    /* */
  }

  addToFav(id) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id');
    final Uri url = Uri.parse("${Network.baseURL}/api/business/add/favourite");
    final data = {
      "business_id": id,
      "user_id": userId,
    };

    final body = jsonEncode(data);

    final request = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );

    debugPrint("sending request to add to fav: ${data}");
    final response = json.decode(request.body);
    print("data returned from after adding to  favs $response");

    if (response == true) {
      return true;
    } else {
      return false;
    }
  }

  checkFav(id) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id');
    final Uri url =
        Uri.parse("${Network.baseURL}/api/business/confirm/favourite/status");
    final data = {
      "business_id": id,
      "user_id": userId,
    };

    final body = jsonEncode(data);

    final request = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );

    debugPrint("sending request for see if favourites: ${data}");
    final response = json.decode(request.body);
    print("data returned from check if fav $response");

    if (response == true) {
      print(" added as  favourite yet");
      return true;
    } else {
      print("not added as  favourite yet");
      return false;
    }
  }

  //

  fetchCommon() async {
    var url = Uri.parse("${Network.baseURL}/api/vocations/common");
    print("fetching list of common professions");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data;
    } else {
      return null;
    }
  }
}
