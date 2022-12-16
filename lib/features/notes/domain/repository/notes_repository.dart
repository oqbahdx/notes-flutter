
import 'package:dartz/dartz.dart';
import 'package:notes_with_clean_architecture/features/notes/domain/entities/note.dart';

import '../../../../core/errors/failure.dart';

abstract class NotesRepository{
   Future<Either<Failure,List<Note>>> getAllNotes();
   Future<Either<Failure,Unit>> addNote(Note note);
   Future<Either<Failure,Unit>> updateNote(Note note);
   Future<Either<Failure,Unit>> deleteNote(String id);

}