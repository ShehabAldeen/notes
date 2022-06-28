import 'package:flutter/material.dart';
import 'package:notes_pp/add_note.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomePage.homePageRoute: (buildContext) => HomePage(),
        AddNote.addNoteRoute: (buildContext) => AddNote(),
      },
      initialRoute: HomePage.homePageRoute,
    );
  }
}
