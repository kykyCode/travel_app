import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/services/Uploader.dart';
import 'package:flutter/material.dart';

class ImageCapture extends StatefulWidget {
  Function(String) getImgPath;
  ImageCapture(this.getImgPath);
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Color.fromRGBO(74, 171, 180, 1),
          toolbarWidgetColor: Color.fromRGBO(74, 171, 180, 1),
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Color.fromRGBO(74, 171, 180, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                ),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              IconButton(
                icon: Icon(
                  Icons.photo_library,
                  color: Colors.white,
                ),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Container(
              color: Color.fromRGBO(74, 171, 180, 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: null,
                    child: Icon(Icons.crop),
                  ),
                  FlatButton(
                    onPressed: _clear,
                    child: Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
            Uploader(this._imageFile, this.widget.getImgPath),
          ] else ...[
            Container(
                color: Color.fromRGBO(74, 171, 180, 0.5),
                padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.91,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "CHOOSE THE METHOD OF UPLOADING PHOTO BELOW",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text("PREFERRED 16:9"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_downward,
                        size: 35,
                      ),
                    ),
                  ],
                ))
          ]
        ],
      ),
    );
  }
}
