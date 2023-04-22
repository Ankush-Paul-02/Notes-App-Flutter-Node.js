import 'package:flutter/material.dart';
import 'package:note_flutter/models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    int indexOfNote = notes.indexOf(
      notes.firstWhere(
        (element) => element.id == note.id,
      ),
    );
    notes[indexOfNote] = note;
    notifyListeners();
  }

  void deleteNote(Note note) {
    int indexOfNote = notes.indexOf(
      notes.firstWhere(
        (element) => element.id == note.id,
      ),
    );
    notes.removeAt(indexOfNote);
    notifyListeners();
  }
}
