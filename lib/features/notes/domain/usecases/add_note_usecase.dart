
import 'package:dartz/dartz.dart';
import 'package:notes_with_clean_architecture/core/errors/failure.dart';
import 'package:notes_with_clean_architecture/features/notes/domain/repository/notes_repository.dart';

import '../entities/note.dart';

class AddNoteUseCase {
  final NotesRepository repository;

  AddNoteUseCase(this.repository);

  Future<Either<Failure,Unit>> call(Note note)async{
    return await repository.addNote(note);
  }
}