import 'package:flutter/material.dart';
import 'package:note_flutter/models/note.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/notes_provider.dart';

class AddNewNotePage extends StatefulWidget {
  final bool forUpdate;
  final Note? note;
  const AddNewNotePage({super.key, required this.forUpdate, this.note});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    Note newNote = Note(
      id: const Uuid().v1(),
      userId: "Ankush Paul",
      title: titleController.text,
      content: contentController.text,
      dateAdded: DateTime.now(),
    );
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    if (widget.forUpdate) {
      widget.note!.title = titleController.text;
      widget.note!.content = contentController.text;
      Provider.of<NotesProvider>(context, listen: false)
          .updateNote(widget.note!);
      Navigator.pop(context);
    } else {
      addNewNote();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.forUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => updateNote(),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                autofocus: (widget.forUpdate == true) ? false : true,
                onSubmitted: (value) {
                  if (value != "") {
                    noteFocus.requestFocus();
                  }
                },
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  focusNode: noteFocus,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Note',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
