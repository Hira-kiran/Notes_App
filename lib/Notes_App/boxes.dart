import 'package:hive/hive.dart';
import 'package:notes_app/Model/notes_Model.dart';

class NotesBoxses {
  static Box<NotesModel> getData() => Hive.box<NotesModel>("Notess");
}
