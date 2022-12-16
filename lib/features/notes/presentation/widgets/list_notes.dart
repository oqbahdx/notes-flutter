
import 'package:flutter/material.dart';

import '../../domain/entities/note.dart';



class NoteListWidget extends StatelessWidget {
  final List<Note> notes;
  const NoteListWidget({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return ListTile(
           leading: Text('${index + 1}'),
          title: Text(
            notes[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            notes[index].content,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (_) => PostDetailPage(post: posts[index]),
          //     ),
          //   );
           },
        );
      },
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}