import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notes_with_clean_architecture/core/network/network_info.dart';
import 'package:notes_with_clean_architecture/features/notes/data/data_sources/local_data_source.dart';
import 'package:notes_with_clean_architecture/features/notes/data/data_sources/remote_data_source.dart';
import 'package:notes_with_clean_architecture/features/notes/data/repository/notes_repository_impl.dart';
import 'package:notes_with_clean_architecture/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:notes_with_clean_architecture/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:notes_with_clean_architecture/features/notes/domain/usecases/get_all_notes_usecase.dart';
import 'package:notes_with_clean_architecture/features/notes/domain/usecases/update_note_usecase.dart';
import 'package:notes_with_clean_architecture/features/notes/presentation/bloc/add_delete_update_bloc.dart';
import 'package:notes_with_clean_architecture/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/notes/domain/repository/notes_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => NotesBloc(getAllNotesUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdateNotesBloc(
      addNoteUseCase: sl(), updateNoteUseCase: sl(), deleteNoteUseCase: sl()));
  // useCases

  sl.registerFactory(() => GetAllNotesUseCase(sl()));
  sl.registerFactory(() => AddNoteUseCase(sl()));
  sl.registerFactory(() => UpdateNoteUseCase(sl()));
  sl.registerFactory(() => DeleteNoteUseCase(sl()));

  // repository
  sl.registerFactory<NotesRepository>(() => NotesRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), netWorkInfo: sl()));
  sl.registerFactory<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  sl.registerFactory<LocalDataSource>(() => LocalDataSourceImpl(sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPreferences);
  sl.registerFactory(() => http.Client());
  sl.registerFactory(() => InternetConnectionChecker());
  sl.registerFactory<NetWorkInfo>(() => NetWorkInfoImpl(sl()));
}
