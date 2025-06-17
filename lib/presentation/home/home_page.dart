import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_example/presentation/home/provider/note_state_provider.dart';
import 'package:test_example/presentation/note/note_page.dart';
import 'package:test_example/presentation/note_edit/note_edit_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteState = ref.watch(noteStateProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('홈')),
        body: ListView.separated(
          itemCount: noteState.notes.length,
          itemBuilder: (context, index) {
            final note = noteState.notes[index];
            return Dismissible(
              key: ValueKey('$index'),
              child: ListTile(
                title: Text(note.title),
                subtitle: Text(note.body),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteEditPage(
                          note: note,
                          edit: ref.read(noteStateProvider.notifier).updateNote,
                        ),
                      ),
                    );
                  },
                ),
              ),
              onDismissed: (dismissDirection) {
                ref.read(noteStateProvider.notifier).deleteNote(note.id);
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotePage(
                  create: ref.read(noteStateProvider.notifier).createNote,
                ),
              ),
            );
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
