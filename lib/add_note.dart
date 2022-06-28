import 'package:flutter/material.dart';
import 'package:notes_pp/home.dart';
import 'package:notes_pp/sqldb.dart';

class AddNote extends StatelessWidget {
  static const String addNoteRoute = 'add_note';
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextField(
                    controller: note,
                    decoration: InputDecoration(hintText: 'note'),
                  ),
                  TextField(
                    controller: title,
                    decoration: InputDecoration(hintText: 'title'),
                  ),
                  TextField(
                    controller: color,
                    decoration: InputDecoration(hintText: 'color'),
                  ),
                  Container(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      int res = await sqlDb.insertData(
                          '''INSERT INTO notes (`note`,`title`,`color`)
                            values("${note.text}","${title.text}","${color.text}")''');
                      if (res > 0) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            HomePage.homePageRoute, (route) => false);
                      }
                    },
                    child: const Text('Add Note'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
