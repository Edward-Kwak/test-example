import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_example/data/model/note.dart';

class NoteState extends StateNotifier<NoteList> {
  NoteState() : super(NoteList(notes: []));

  int _autoIncrementId = 0;

  void createNote({required String title, required String body}) {
    state = state.copyWith(
      notes: [
        ...state.notes,
        Note(
          id: _autoIncrementId++,
          title: title,
          body: body,
        ),
      ],
    );
  }

  void deleteNote(int id) {
    state = state.copyWith(notes: state.notes.where((element) => element.id != id).toList());
  }

  void updateNote({required int id, String? title, String? body}) {
    state = state.copyWith(
        notes: state.notes.map((e) => e.id == id ? e.copyWith(title: title ?? e.title, body: body ?? e.body) : e).toList());
  }
}
