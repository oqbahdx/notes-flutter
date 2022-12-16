part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class LoadingAddDeleteUpdateState extends AddDeleteUpdateState {}

class ErrorAddDeleteUpdateState extends AddDeleteUpdateState {
  final String message;

  const ErrorAddDeleteUpdateState({required this.message});
}
class MessageAddDeleteUpdateState extends AddDeleteUpdateState{
  final String message;

 const MessageAddDeleteUpdateState({required this.message});
  @override
  List<Object> get props => [message];
}