import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'dart:io';

class Uploader extends StatefulWidget {
  final File file;
  Function(String) getImgPath;

  Uploader(this.file, this.getImgPath);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  var _uploadTask;
  String filePath;

  void _startUpload() {
    String filePath = 'images/${DateTime.now()}.jpg';
    _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    this.widget.getImgPath(filePath);
    Navigator.pop(context);
  }

  // ignore: unused_element

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent =
                event != null ? event.bytesTranfered / event.totalByteCount : 0;

            return Container(
                child: Column(
              children: <Widget>[
                if (_uploadTask.isComplete) Text("Done!!!"),
                if (_uploadTask.isPaused) Text("Paused"),
                if (_uploadTask.isInProgress) Text("in progress"),
              ],
            ));
          });
    } else {
      return Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(74, 171, 180, 0.5),
              border: Border.all(color: Colors.black, width: 1)),
          height: MediaQuery.of(context).size.height * 0.16,
          child: FlatButton.icon(
            label: Text("Upload To Firebase",
                style: TextStyle(color: Colors.black, fontSize: 18)),
            onPressed: _startUpload,
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.black,
            ),
          ));
    }
  }
}
