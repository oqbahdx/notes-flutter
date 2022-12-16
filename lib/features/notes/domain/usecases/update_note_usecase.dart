import 'package:dartz/dartz.dart';
import 'package:notes_with_clean_architecture/core/errors/failure.dart';
import 'package:notes_with_clean_architecture/features/notes/domain/entities/note.dart';
import 'package:notes_with_clean_architecture/features/notes/domain/repository/notes_repository.dart';

class UpdateNoteUseCase {
  final NotesRepository repository;

  UpdateNoteUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Note note) async {
    return await repository.updateNote(note);
  }
}
