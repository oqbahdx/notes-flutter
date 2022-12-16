import 'package:notes_with_clean_architecture/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel(
      {required String id, required String title, required String content})
      : super(id: id, title: title, content: content);

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        id: json['_id'], title: json['title'], content: json['content']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
    };
  }
}
