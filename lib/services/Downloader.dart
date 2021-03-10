import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirestoreStorageService extends ChangeNotifier {
  FirestoreStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}

Future<Widget> getImg(BuildContext context, String imageName) async {
  Image image;
  await FirestoreStorageService.loadImage(context, imageName).then((val) => {
        image = Image.network(
          val.toString(),
        )
      });
  return image;
}
