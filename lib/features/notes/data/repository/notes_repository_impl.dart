import 'package:dartz/dartz.dart';
import 'package:notes_with_clean_architecture/core/errors/exception.dart';

import 'package:notes_with_clean_architecture/core/errors/failure.dart';
import 'package:notes_with_clean_architecture/features/notes/data/data_sources/local_data_source.dart';
import 'package:notes_with_clean_architecture/features/notes/data/data_sources/remote_data_source.dart';
import 'package:notes_with_clean_architecture/features/notes/data/models/note_model.dart';

import 'package:notes_with_clean_architecture/features/notes/domain/entities/note.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repository/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetWorkInfo netWorkInfo;

  NotesRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.netWorkInfo});

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    if (await netWorkInfo.isConnected) {
      try {
        final remoteNotes = await remoteDataSource.getAllNotes();
        localDataSource.cacheNotes(remoteNotes);
        return Right(remoteNotes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localNotes = await localDataSource.getCachedNotes();
        return Right(localNotes);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addNote(Note note) async {
    final NoteModel noteModel =
        NoteModel(id: note.id, title: note.title, content: note.content);
    return await _getMessage((){
      return remoteDataSource.addNote(noteModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateNote(Note note) async {
    final NoteModel noteModel =
        NoteModel(id: note.id, title: note.title, content: note.content);
    return await _getMessage((){
      return remoteDataSource.updateNote(noteModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(String id) async {
   return await _getMessage((){
     return remoteDataSource.deleteNote(id);
   });
  }
  Future<Either<Failure, Unit>> _getMessage(Future<Unit>Function() methods) async{
    if (await netWorkInfo.isConnected) {
      try {
       await methods();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
