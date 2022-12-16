import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/notes_bloc.dart';
import '../widgets/list_notes.dart';
import '../widgets/message_display.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: const Text('Notes'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is LoadingNotesState) {
            return const LoadingWidget();
          } else if (state is LoadedNotesState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: NoteListWidget(notes: state.notes));
          } else if (state is ErrorNotesState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<NotesBloc>(context).add(RefreshNotesEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => PostAddUpdatePage(
        //               isUpdatePost: false,
        //             )));
      },
      child:const Icon(Icons.add),
    );
  }
}
