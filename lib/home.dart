import 'package:flutter/material.dart';
import 'package:notes_pp/add_note.dart';
import 'package:notes_pp/edit_note.dart';
import 'package:notes_pp/sqldb.dart';

class HomePage extends StatefulWidget {
  static const String homePageRoute = 'homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = false;
  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM notes');
    notes.addAll(response);
    isLoading = true;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddNote.addNoteRoute);
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: isLoading == false
            ? Center(child: Text('Loading.....'))
            : Container(
                child: ListView.builder(
                    itemCount: notes.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (buildContext, index) {
                      return Card(
                          child: ListTile(
                              title: Text('${notes[index]['note']}'),
                              subtitle: Text('${notes[index]['title']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      int response = await sqlDb.deleteData('''
                                  DELETE FROM notes WHERE id=${notes[index]['id']}
                                 ''');
                                      if (response > 0) {
                                        notes.removeWhere((element) =>
                                            element['id'] ==
                                            notes[index]['id']);
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              EditNote(
                                                  notes[index]['id'],
                                                  notes[index]['note'],
                                                  notes[index]['title'],
                                                  notes[index]['color']),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  )
                                ],
                              )));
                    }),
              ));
  }
}
