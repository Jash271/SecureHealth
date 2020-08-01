import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as m;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future _uploadFile() async{
    var file = await FilePicker.getFile(allowedExtensions: ['pdf','docx'], type: FileType.custom);
    final StorageReference firebaseStorageReference = FirebaseStorage.instance.ref().child('Prescription #'+m.Random().nextInt(10000).toString());
    final StorageUploadTask task = firebaseStorageReference.putFile(file);
    return await (await task.onComplete).ref.getDownloadURL();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20.0,
              right: 10.0,
              bottom: 20,
            ),
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Want to upload prescriptions? Tap here!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 20
                        ),
                      ),
                      onPressed: ()async{
                        String url = await _uploadFile();
                        print(url);
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Your prescriptions : ',
                      style: GoogleFonts.montserrat(
                        fontSize: 25
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
