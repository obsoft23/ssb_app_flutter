// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, use_key_in_widget_constructors, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, unnecessary_null_comparison, unnecessary_import, prefer_typing_uninitialized_variables, import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/api.dart';
import 'package:flutter_application_1/screens/components/parse/acc_view.dart';
import 'package:flutter_application_1/screens/components/parse/searchParse.dart';
import 'package:flutter_application_1/screens/components/view_business_accpage.dart';
import 'package:flutter_application_1/screens/favourites.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/profile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import '../search.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math' show cos, sqrt, asin;

List businessAccounts = [];
var accs = <Autogenerated>[];
var searchStatus = false;
var image;
List common = [];

class SearchPageBody extends StatefulWidget {
  const SearchPageBody({Key? key}) : super(key: key);

  @override
  State<SearchPageBody> createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //  Categories(),
        Expanded(
          child: ItemCard(),
        ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  @override
  const ItemCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final List<Map> myProducts =
        List.generate(1, (index) => {"id": index, "name": "Product $index"})
            .toList();*/
    return FutureBuilder(
      future: fetchList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: common.length,
            itemBuilder: (context, index) => ItemTile(index),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  //
}

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(
    this.itemNo,
  );

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.primaries[itemNo % Colors.primaries.length];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          print(searchResults[itemNo]);
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) =>
                searchVocation(context, common[itemNo]["vocations"]),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(7)),
            image: DecorationImage(
              image: NetworkImage(
                  "${Network.baseURL}/api/vocation/${common[itemNo]["vocation_image"]}"),
              fit: BoxFit.cover,
            ),
          ),
          child: common.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    '${common[itemNo]["vocations"]}',
                    key: Key('text_$itemNo'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  searchVocation(context, title) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            accs.clear();
            favouriteStream = fetchUserFavourites();
            Navigator.pop(context);
            // favouriteStream = fetchUserFavourites();
            fetchUserFavourites();
          },
          child: Container(
            margin: EdgeInsets.only(left: 8),
            child: Center(
              child: Icon(Icons.arrow_back, color: Colors.blue, size: 24),
            ),
          ),
        ),
        title: Text(
          '$title',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          /* IconButton(
            icon: Icon(CupertinoIcons.search),
            color: Colors.blueAccent,
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),*/
        ],
      ),
      body: StreamBuilder(
        stream: findUserRequest(title),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                searchStatus == false
                    ? Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: SizedBox(
                              width: 300,
                              height: 100,
                              child: Text(
                                  "Sorry ... we could not find any ${title} around you"),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 10,
                      ),
                Expanded(
                  child: businessList(),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
                Center(child: Text("processing your request"))
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                ),
                Center(child: Text("looking for ${title} around you"))
              ],
            );
          }
        },
      ),
    );
  }
}

Stream findUserRequest(title) async* {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final _data = {
    "sub_category": title,
    "country": country,
    "town": town,
    "lat": latitude,
    "long": longtitude,
  };

  print("query to be sent to DB${_data}");
  final response = await http.post(
    Uri.parse("${Network.baseURL}/api/vocations/find"),
    body: jsonEncode(_data),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString("token")}'
    },
  );

  if (response.statusCode == 200) {
    final _accs = json.decode(response.body);
    print("error in new empty ${_accs} here");
    if (_accs[0] != false) {
      for (var acc in _accs) {
        accs.add(Autogenerated.fromJson(acc));
      }
      searchStatus = true;
      await Future.delayed(const Duration(seconds: 1));
      print(" state $accs");
      yield accs;
    } else {
      print("sorry no data found");
      _accs.clear();
      searchStatus = false;
      await Future.delayed(const Duration(seconds: 1));
      yield searchStatus;
    }
  } else {
    print("sorry no data found");
    searchStatus = false;
    await Future.delayed(const Duration(seconds: 1));
    yield searchStatus;
  }
}

@override
Widget businessList() {
  return ListView.builder(
    itemCount: accs.length,
    itemBuilder: (context, index) {
      final acc = accs[index];

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ViewBusinessAccpage(
                businessName: acc.businessName,
                id: acc.businessAccId,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomListItemTwo(
            thumbnail: acc.image != null
                ? Container(
                    child: Image.network(
                      "${Network.baseURL}/api/fetch-business-acc-image/${acc.image}",
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(color: Colors.blueGrey),
                    child: Center(
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    ),
                  ),
            title: acc.businessName!,
            subtitle: acc.businessDescripition!,
            author: acc.fullAddress,
            publishDate: acc.openingTime! + " : " + acc.closingTime!,
            readDuration: Geolocator.distanceBetween(
              longtitude,
              latitude,
              acc.longtitude!,
              acc.latitude!,
            ).floor(),
          ),
        ),
      );
    },
  );
}

fetchList() async {
  var url = Uri.parse("${Network.baseURL}/api/vocations/fetch");
  print("fetching list of common professions");
  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });
  if (response.statusCode == 200) {
    final List data = json.decode(response.body);
    await Future.delayed(const Duration(seconds: 1));
    common = data;

    return common;
  } else {
    return null;
  }
}
