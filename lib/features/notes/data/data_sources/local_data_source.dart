import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:notes_with_clean_architecture/core/errors/exception.dart';
import 'package:notes_with_clean_architecture/features/notes/data/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<NoteModel>> getCachedNotes();

  Future<Unit> cacheNotes(List<NoteModel> noteModel);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<Unit> cacheNotes(List<NoteModel> noteModel) {
    final List notesModelsToJson = noteModel
        .map<Map<String, dynamic>>((noteModel) => noteModel.toJson())
        .toList();
    sharedPreferences.setString('CACHED_NOTES', json.encode(notesModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<NoteModel>> getCachedNotes() {
    final jsonString = sharedPreferences.getString('CACHED_NOTES');
    if (jsonString != null) {
      List decodeJson = jsonDecode(jsonString);
      List<NoteModel> jsonToNoteModel = decodeJson
          .map<NoteModel>((jsonNoteModel) => NoteModel.fromJson(jsonNoteModel))
          .toList();
      return Future.value(jsonToNoteModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
