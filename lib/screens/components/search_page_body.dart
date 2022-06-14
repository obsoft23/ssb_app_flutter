// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SearchPageBody extends StatelessWidget {
  const SearchPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Categories(),
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
    final List<Map> myProducts =
        List.generate(1, (index) => {"id": index, "name": "Product $index"})
            .toList();
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return GridView.builder(
      itemCount: 15,
      itemBuilder: (context, index) => ItemTile(index),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
    );
  }
}

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "common",
    "vocation",
    "social",
    "religion",
    "mosque",
    "electrician",
    "electrician",
    "electrician",
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 25,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) => buildCategory(index)),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {});
        selectedIndex = index;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: selectedIndex == index
                    ? Colors.blueAccent
                    : Colors.grey[500],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 2,
              width: 30,
              color: selectedIndex == index
                  ? Colors.blueAccent
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
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
      child: ListTile(
        tileColor: color.withOpacity(0.3),
        onTap: () {
          showBarModalBottomSheet(
            context: context,
            builder: (context) => Container(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: 360,
                    child: Image.network("https://i.gifer.com/ZF6H.gif")),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SEARCHING",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 35,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballBeat,
                        colors: [Colors.red],
                        strokeWidth: 1,
                        backgroundColor: Colors.transparent,
                        pathBackgroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: MediaQuery.of(context).size.height * .070),
                Divider(),
                ElevatedButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child: Text("Cancel"),
                    style: ElevatedButton.styleFrom(primary: Colors.red))
              ],
            )),
          );
        },
        leading: Container(
          width: 50,
          height: 50,
          color: color.withOpacity(0.5),
          child: Placeholder(
            color: color,
          ),
        ),
        title: Text(
          'Product $itemNo',
          key: Key('text_$itemNo'),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget cancelButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    Widget launchButton = TextButton(
      child: Text("No"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text("WorkSpace Search")),
      content: Text("Do you want to cancel search..."),
      actions: [
        cancelButton,
        launchButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
