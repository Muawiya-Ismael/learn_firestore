/*

import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController textController = TextEditingController();

  PlatformFile? pickedFile;
  Uint8List? imageBytes;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
        // Read the file contents into bytes
        File file = File(pickedFile!.path!);
        imageBytes =file.readAsBytesSync();
      });
    } else {
      print('No file selected');
    }
  }

  void openNoteBox(String? docID){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: TextField(
        controller:  textController,
      ),
      actions: [
        FilledButton(
          onPressed: (){

            if(docID == null){
              firestoreService.addNote(textController.text);
            }
            else{
              firestoreService.updateNote(docID, textController.text);
            }

            textController.clear();

            Navigator.pop(context);
          },
          child:const Text("Save",),
        ),

        FilledButton(
          onPressed: selectFile,
          child: const Text("Select Image")
        )

      ],
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:()=> openNoteBox(null),
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getNotesStream(),

          builder: (context, snapshot) {

            if(snapshot.hasData){

              List notesList = snapshot.data!.docs;
              return ListView.builder(

                  itemCount: notesList.length,

                  itemBuilder: (context, index){

                    DocumentSnapshot document = notesList[index];
                    String docId = document.id;

                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                    String noteText = data ["note"];

                    return ListTile(
                      title:  Text(noteText),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: ()=> openNoteBox(docId),
                            icon: const Icon(Icons.update),
                          ),
                          IconButton(
                            onPressed: ()=> firestoreService.deleteNote(docId),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );

                  });
            } else{
              return const Center(child: Text("No notes...", style: TextStyle(color: Colors.white),));
            }
          }
      ),
    );
  }
}



class FirestoreService{
  final CollectionReference notes = FirebaseFirestore.instance.collection("notesWithImage");

  Future<void> addNote(String note){
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotesStream(){
    final notesStream = notes.orderBy(
        "timestamp",
        descending: true
    ).snapshots();

    return notesStream;
  }

  Future<void> updateNote(String docID,String newNote){
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteNote(String docID){
    return notes.doc(docID).delete();
  }


}
*/
