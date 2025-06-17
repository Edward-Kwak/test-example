import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_example/data/model/note.dart';
import 'package:test_example/presentation/home/provider/state/note_state.dart';

final noteStateProvider = StateNotifierProvider<NoteState, NoteList>((ref) {
  return NoteState();
});
