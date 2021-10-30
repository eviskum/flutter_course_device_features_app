import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function selectImageHandler;

  const ImageInput(this.selectImageHandler, {Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final _picker = ImagePicker();
    // final imageFile = await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    try {
      final _imageFile = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 600);
      if (_imageFile == null) return;
      setState(() {
        _storedImage = File(_imageFile.path);
      });
      final appDir = await syspath.getApplicationDocumentsDirectory();
      final fileName = path.basename(_storedImage!.path);
      final filePath = path.join(appDir.path, fileName);
      final savedImage = await _storedImage!.copy(filePath);
      widget.selectImageHandler(savedImage);
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage == null
              ? Text(
                  'No Image taken',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextButton.icon(
          onPressed: _takePicture,
          icon: Icon(Icons.camera),
          label: Text('Take Picture'),
        )),
      ],
    );
  }
}
