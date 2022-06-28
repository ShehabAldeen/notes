import 'package:flutter/material.dart';
import 'package:notes_pp/sqldb.dart';

class EditNote extends StatefulWidget {
  final id;
  final note;
  final title;
  final color;

  EditNote(this.id, this.note, this.title, this.color);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController note = TextEditingController();

  TextEditingController title = TextEditingController();

  TextEditingController color = TextEditingController();

  SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    // TODO: implement initState
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
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
                      int res = await sqlDb.updateData('''UPDATE notes 
                      SET note = "${note.text}",
                      title =   "${title.text}",
                      color =   "${color.text}"
                      WHERE id = ${widget.id}
                            ''');
                      if (res > 0) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save Edit'),
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
