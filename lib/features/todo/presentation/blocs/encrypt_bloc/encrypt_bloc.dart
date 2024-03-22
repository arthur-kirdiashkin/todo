
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/encrypt_bloc/encrypt_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/encrypt_bloc/encrypt_state.dart';

class EncryptBloc extends Bloc<EncryptEvent, EncryptState> {
  late SharedPreferences prefs;
  bool isSelected = false;
  EncryptBloc() : super(EncryptInitialState()) {
    on<AddEncryptDataEvent>(_addEncryptDataEvent);
    on<EncryptDataEvent>(_encryptDataEvent);
  }

  _addEncryptDataEvent(AddEncryptDataEvent event, emit) async {
    emit(AddEncryptStateLoaded());
  }

  _encryptDataEvent(EncryptDataEvent event, emit) async {
    prefs = await SharedPreferences.getInstance();

    prefs.setString('key', event.password);
  }
}
