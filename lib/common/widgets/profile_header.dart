import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  String? _pickedImagePath;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _pickedImagePath = pickedFile.path;
        });
      }
    } catch (e) {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Error taking photo: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
          width: 70.w,
          height: 68.h,
          child: ClipOval(
            child: _pickedImagePath != null
                ? Image.file(
                    File(_pickedImagePath!),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Container(
                    color: Colors.grey.shade700,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    )),
          ),
        ),
        GestureDetector(
          onTap: _pickImageFromGallery,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(3),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
