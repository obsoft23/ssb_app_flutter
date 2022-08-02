// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class _ArticleDescription extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? author;
  final String? publishDate;
  var readDuration;

  _ArticleDescription({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 4.0)),
              Text(
                subtitle!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              author != null
                  ? Text(
                      author!,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.black87,
                      ),
                    )
                  : Text(""),
              Text(
                '$publishDate - $readDuration',
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  final Widget? thumbnail;
  final String title;
  final String? subtitle;
  final String? author;
  final String? publishDate;
  var readDuration;

  CustomListItemTwo({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        /*  CustomListItemTwo(
          thumbnail: Container(
            decoration: const BoxDecoration(color: Colors.pink),
          ),
          title: 'Flutter 1.0 Launch',
          subtitle: 'Flutter continues to improve and expand its horizons. '
              'This text should max out at two lines and clip',
          author: 'Dash',
          publishDate: 'Dec 28',
          readDuration: '5 mins',
        ),
        CustomListItemTwo(
          thumbnail: Container(
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          title: 'Flutter 1.2 Release - Continual updates to the framework',
          subtitle: 'Flutter once again improves and makes updates.',
          author: 'Flutter',
          publishDate: 'Feb 26',
          readDuration: '12 mins',
        ),*/
      ],
    );
  }
}
