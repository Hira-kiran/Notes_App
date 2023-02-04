// ignore_for_file: file_names


import 'package:hive/hive.dart';
part 'notes_Model.g.dart';
// Then run "flutter packages pub run build_runner build" command

@HiveType(typeId: 0)// This is Id that are unique for every class
class NotesModel extends HiveObject{
  @HiveField(0)// unique Id for title
  String title;
  @HiveField(1)// unique Id for discription
  String discription;

  NotesModel({required this.title, required this.discription});
}
