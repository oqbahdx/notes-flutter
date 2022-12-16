import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/note.dart';
import '../repository/notes_repository.dart';

class GetAllNotesUseCase {
  final NotesRepository repository;

  GetAllNotesUseCase(this.repository);

  Future<Either<Failure, List<Note>>> call() async {
    return await repository.getAllNotes();
  }
}
