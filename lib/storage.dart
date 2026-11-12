import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<void> uploadPicture() async {
  XFile? photo = await ImagePicker().pickImage(
    source: ImageSource.camera,
  );

  if (photo == null) throw ('Error taking picture');

  // Save Photo
  final Directory systemTempDir = Directory.systemTemp;
  final String systemTempPath = systemTempDir.path;

  final String filePath = '$systemTempPath/test.jpeg';
  await photo.saveTo(filePath);

  File file = File(filePath);

  print('Normally sticks here');

  final TaskSnapshot taskSnapshot =
      await FirebaseStorage.instance.ref().child('/test').putFile(file);

  final String url = await taskSnapshot.ref.getDownloadURL();

  print('Url $url');
}
