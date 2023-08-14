import 'package:flutter/material.dart';

import '../model/iphone_model.dart';

class SubmitDataScreen extends StatefulWidget {
  const SubmitDataScreen({Key? key}) : super(key: key);

  @override
  State<SubmitDataScreen> createState() => _SubmitDataScreenState();
}

class _SubmitDataScreenState extends State<SubmitDataScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah To Do List'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Judul'),
          ),
          TextField(
            controller: categoryController,
            decoration: const InputDecoration(labelText: 'Kategori'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            if (titleController.text.isNotEmpty &&
                categoryController.text.isNotEmpty) {
              Task newTask = Task(
                id: 0, // Generate a temporary ID
                title: titleController.text,
                category: categoryController.text,
              );
              Navigator.of(context).pop(newTask);
            }
          },
          child: const Text('Tambah'),
        ),
      ],
    );
  }
}
