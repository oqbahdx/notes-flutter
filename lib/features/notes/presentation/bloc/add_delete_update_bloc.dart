import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_with_clean_architecture/features/notes/domain/entities/note.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/strings/message.dart';
import '../../domain/usecases/add_note_usecase.dart';
import '../../domain/usecases/delete_note_usecase.dart';
import '../../domain/usecases/update_note_usecase.dart';

part 'add_delete_update_event.dart';

part 'add_delete_update_state.dart';

class AddDeleteUpdateNotesBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddNoteUseCase addNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;

  AddDeleteUpdateNotesBloc(
      {required this.addNoteUseCase,
      required this.updateNoteUseCase,
      required this.deleteNoteUseCase})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is AddNoteEvent) {
        emit(LoadingAddDeleteUpdateState());
        final notes = await addNoteUseCase(event.note);
        _eitherMessageOrErrorState(notes, ADD_SUCCESS_MESSAGE);
      } else if (event is UpdateNoteEvent) {
        emit(LoadingAddDeleteUpdateState());
        final notes = await updateNoteUseCase(event.note);
        _eitherMessageOrErrorState(notes, UPDATE_SUCCESS_MESSAGE);
      } else if (event is DeleteNoteEvent) {
        emit(LoadingAddDeleteUpdateState());
        final notes = await deleteNoteUseCase(event.id);
        _eitherMessageOrErrorState(notes, DELETE_SUCCESS_MESSAGE);
      }
    });
  }

  AddDeleteUpdateState _eitherMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) =>
            ErrorAddDeleteUpdateState(message: _mapFailureToMessage(failure)),
        (_) => MessageAddDeleteUpdateState(message: message));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error , please try later';
    }
  }
}
