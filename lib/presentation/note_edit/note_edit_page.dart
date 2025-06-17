import 'package:flutter/material.dart';
import 'package:test_example/data/model/note.dart';

class NoteEditPage extends StatelessWidget {
  const NoteEditPage({
    super.key,
    required this.note,
    required this.edit,
  });

  final Note note;
  final void Function({required int id, String? title, String? body}) edit;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: note.title);
    final bodyController = TextEditingController(text: note.body);

    return Scaffold(
      appBar: AppBar(
        title: const Text('노트 수정 페이지'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const ValueKey('editTitle'),
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            Expanded(
              child: TextField(
                key: const ValueKey('editBody'),
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: 500,
                decoration: const InputDecoration(hintText: 'Enter your text here...'),
              ),
            ),
            ElevatedButton(
              child: const Text('수정'),
              onPressed: () {
                edit(
                  id: note.id,
                  title: titleController.text,
                  body: bodyController.text,
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
