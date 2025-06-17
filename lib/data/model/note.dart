import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';

@freezed
class Note with _$Note {
  factory Note({
    required int id,
    required String title,
    required String body,
  }) = _Note;
}

@freezed
class NoteList with _$NoteList {
  factory NoteList({required List<Note> notes}) = _NoteList;
}
