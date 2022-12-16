
import 'package:dartz/dartz.dart';
import 'package:notes_with_clean_architecture/core/errors/failure.dart';
import 'package:notes_with_clean_architecture/features/notes/domain/repository/notes_repository.dart';

class DeleteNoteUseCase {
  final NotesRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<Either<Failure,Unit>> call(String id)async{
    return await repository.deleteNote(id);
  }
}