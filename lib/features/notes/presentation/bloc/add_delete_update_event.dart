part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();

  @override
  List<Object> get props => [];
}

class AddNoteEvent extends AddDeleteUpdateEvent {
  final Note note;

 const AddNoteEvent({required this.note});
  @override
  List<Object> get props => [note];
}

class DeleteNoteEvent extends AddDeleteUpdateEvent {
  final String id ;

const   DeleteNoteEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class UpdateNoteEvent extends AddDeleteUpdateEvent {
  final Note note;

 const  UpdateNoteEvent({required this.note});
  @override
  List<Object> get props => [note];
}
