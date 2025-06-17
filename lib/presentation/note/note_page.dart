import 'package:flutter/material.dart';

class NotePage extends StatelessWidget {
  const NotePage({
    super.key,
    required this.create,
  });

  final void Function({required String title, required String body}) create;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('노트 생성 페이지'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const ValueKey('title'),
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            Expanded(
              child: TextField(
                key: const ValueKey('body'),
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: 500,
                decoration: const InputDecoration(hintText: 'Enter your text here...'),
              ),
            ),
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () {
                create(
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
