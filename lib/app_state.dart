import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _note = prefs.getStringList('ff_note') ?? _note;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<String> _note = [];
  List<String> get note => _note;
  set note(List<String> value) {
    _note = value;
    prefs.setStringList('ff_note', value);
  }

  void addToNote(String value) {
    _note.add(value);
    prefs.setStringList('ff_note', _note);
  }

  void removeFromNote(String value) {
    _note.remove(value);
    prefs.setStringList('ff_note', _note);
  }

  void removeAtIndexFromNote(int index) {
    _note.removeAt(index);
    prefs.setStringList('ff_note', _note);
  }

  void updateNoteAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _note[index] = updateFn(_note[index]);
    prefs.setStringList('ff_note', _note);
  }

  void insertAtIndexInNote(int index, String value) {
    _note.insert(index, value);
    prefs.setStringList('ff_note', _note);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
