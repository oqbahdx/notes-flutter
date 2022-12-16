import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_with_clean_architecture/core/di.dart' as di;
import 'package:notes_with_clean_architecture/features/notes/presentation/bloc/add_delete_update_bloc.dart';
import 'package:notes_with_clean_architecture/features/notes/presentation/bloc/notes_bloc.dart';

import 'features/notes/presentation/pages/notes_home.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>di.sl<NotesBloc>()..add(GetAllNotesEvent())),
        BlocProvider(create: (_)=>di.sl<AddDeleteUpdateNotesBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal
        ),
        debugShowCheckedModeBanner: false,
        home:const NotePage(),
      ),
    );
  }
}
