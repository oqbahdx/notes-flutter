import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:notes_with_clean_architecture/core/errors/exception.dart';

import '../models/note_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<NoteModel>> getAllNotes();

  Future<Unit> addNote(NoteModel noteModel);

  Future<Unit> updateNote(NoteModel noteModel);

  Future<Unit> deleteNote(String id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  String baseUrl = "http://192.168.43.100:8000";

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final response = await http.get(Uri.parse('$baseUrl/notes'),
        headers: {'Content-type': 'Application/json'});
       print( "res : ${response.body}");
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<NoteModel> notesModel = decodedJson
          .map<NoteModel>((jsonNoteModel) => NoteModel.fromJson(jsonNoteModel))
          .toList();
      return notesModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addNote(NoteModel noteModel) async {
    final body = {'title': noteModel.title, 'content': noteModel.content};

    final response = await http.post(Uri.parse('$baseUrl/notes'), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateNote(NoteModel noteModel) async {
    final body = {'title': noteModel.title, 'content': noteModel.content};

    final response = await http
        .patch(Uri.parse('$baseUrl/notes/${noteModel.id}'), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteNote(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/notes/$id'),
        headers: {'Content-type': 'Application/json'});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
