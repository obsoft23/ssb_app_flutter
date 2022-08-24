// ignore_for_file: unused_import, implementation_imports, unused_local_variable, prefer_const_literals_to_create_immutables
/*
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void chatApp() async {
  final client = StreamChatClient(
    'vqe6zf3pjavt',
    logLevel: Level.INFO,
  );

  final prefs = await SharedPreferences.getInstance();

  await client.connectUser(
    User(
      id: 'robertbrunhage',
      extraData: {
        'image': 'https://robertbrunhage.com/logo.png',
      },
    ),
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoicm9iZXJ0YnJ1bmhhZ2UifQ.5bYlaBFJ8w-_zSh3pgFPUVVlJNtiVKdz8F1clUhF8Dg",
  );

  final channel = client.channel(
    'messaging',
    id: 'coolkids',
    extraData: {
      "name": "Cool Kids",
      "image": "https://robertbrunhage.com/logo.png",
    },
  );

  channel.watch();
}
*/