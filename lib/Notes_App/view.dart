import 'package:flutter/material.dart';
import 'package:notes_app/Model/notes_Model.dart';
import 'package:notes_app/Notes_App/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  final titleController = TextEditingController();
  final discriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: const Text("Notes Application"),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: NotesBoxses.getData().listenable(),
        builder: (BuildContext context, box, Widget? child) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
              // reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 2, color: Colors.brown),
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 2, color: Colors.brown),
                          borderRadius: BorderRadius.circular(20)),
                      selected: true,
                      selectedColor: Colors.black,
                      selectedTileColor: Colors.white,
                      leading: IconButton(
                        onPressed: () {
                          editDialogueBox(
                              data[index],
                              data[index].title.toString(),
                              data[index].discription.toString());
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 152, 150, 150),
                        ),
                      ),
                      title: Text(data[index].title),
                      subtitle: Text(data[index].discription),
                      trailing: IconButton(
                        onPressed: () {
                          deleteNotes(data[index]);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              }));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          showDialogueBox();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
// Function for show Dialogue box

  void showDialogueBox() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
              height: 110,
              width: 80,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "images/notesImage.jpg",
                      ),
                      fit: BoxFit.fill)),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Notes",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                  ),
                  TextFormField(
                    showCursor: true,
                    cursorColor: Colors.brown,
                    controller: titleController,
                    decoration: const InputDecoration(
                        label: Text("Title"),
                        labelStyle: TextStyle(color: Colors.brown),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown))),
                  ),
                  TextFormField(
                    showCursor: true,
                    cursorColor: Colors.brown,
                    controller: discriptionController,
                    decoration: const InputDecoration(
                        label: Text("Discription"),
                        labelStyle: TextStyle(color: Colors.brown),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown))),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel",
                      style: TextStyle(
                          // fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown))),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  final data = NotesModel(
                      title: titleController.text.toString(),
                      discription: discriptionController.text.toString());
                  final box = NotesBoxses.getData();
                  box.add(data);
                  // data.save();
                  titleController.clear();
                  discriptionController.clear();
                },
                child: const Text("Add",
                    style: TextStyle(
                        // fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              )
            ],
          );
        });
  }

  // function for Delete Notes
  void deleteNotes(NotesModel notesModel) {
    notesModel.delete();
  }

  // Function for Update/Edit Notes
  void editDialogueBox(
      NotesModel notesModel, String title, String discription) async {
    titleController.text = title;
    discriptionController.text = discription;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
              height: 110,
              width: 80,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "images/notesImage.jpg",
                      ),
                      fit: BoxFit.fill)),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Edit Notes",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                  ),
                  TextFormField(
                    showCursor: true,
                    cursorColor: Colors.brown,
                    controller: titleController,
                    decoration: const InputDecoration(
                        label: Text("Title"),
                        labelStyle: TextStyle(color: Colors.brown),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown))),
                  ),
                  TextFormField(
                    showCursor: true,
                    cursorColor: Colors.brown,
                    controller: discriptionController,
                    decoration: const InputDecoration(
                        label: Text("Discription"),
                        labelStyle: TextStyle(color: Colors.brown),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown))),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel",
                      style: TextStyle(
                          // fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown))),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  notesModel.title = titleController.text.toString();
                  notesModel.discription =
                      discriptionController.text.toString();
                  notesModel.save();
                  titleController.clear();
                  discriptionController.clear();
                },
                child: const Text("Edit",
                    style: TextStyle(
                        // fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              )
            ],
          );
        });
  }
}
