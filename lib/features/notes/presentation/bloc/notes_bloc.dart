import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_with_clean_architecture/core/errors/failure.dart';
import 'package:notes_with_clean_architecture/core/strings/failures.dart';

import '../../domain/entities/note.dart';
import '../../domain/usecases/get_all_notes_usecase.dart';

part 'notes_event.dart';

part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotesUseCase getAllNotesUseCase;

  NotesBloc({required this.getAllNotesUseCase}) : super(NotesInitial()) {
    on<NotesEvent>((event, emit) async {
      if (event is GetAllNotesEvent) {
        emit(LoadingNotesState());
        final notes = await getAllNotesUseCase();
        emit(_mapFailureOrNotesToState(notes));
      } else if (event is RefreshNotesEvent) {
        emit(LoadingNotesState());
        final notes = await getAllNotesUseCase();
        emit(_mapFailureOrNotesToState(notes));
      }
    });
  }

  NotesState _mapFailureOrNotesToState(Either<Failure, List<Note>> either) {
    return either.fold(
        (failure) => ErrorNotesState(message: _mapFailureToMessage(failure)),
        (notes) => LoadedNotesState(notes: notes));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error , please try later';
    }
  }
}
