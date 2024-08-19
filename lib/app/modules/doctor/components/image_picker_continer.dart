import 'dart:io';
import 'dart:developer';

import 'package:field_asistence/app/data/constrants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PicProfileImgWidget extends StatefulWidget {
  final Function(String) onImagePicked;

  const PicProfileImgWidget({required this.onImagePicked, super.key});

  @override
  State<PicProfileImgWidget> createState() => _PicProfileImgWidgetState();
}

class _PicProfileImgWidgetState extends State<PicProfileImgWidget> {
  String _selectedImagePath = '';
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(CupertinoIcons.photo),
                title: const Text('Pick from gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.camera),
                title: const Text('Take a photo'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      log('Picked file path: ${pickedFile.path}'); // Log the file path
      log('Picked file name: ${pickedFile.name}'); // Log the file name, if needed

      setState(() {
        _selectedImagePath = pickedFile.path;
      });

      widget.onImagePicked(
          _selectedImagePath); // Pass the image path to the callback
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _showImagePickerOptions(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: isDarkMode(context)
                        ? AppColors.kDarkContiner
                        : AppColors.kWhite,
                    radius: 60,
                    backgroundImage: _selectedImagePath.isEmpty
                        ? const NetworkImage(
                            'https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg') // Fallback image URL
                        : kIsWeb
                            ? NetworkImage(_selectedImagePath)
                                as ImageProvider<Object>?
                            : FileImage(File(_selectedImagePath)),
                  ),
                ),
                CircleAvatar(
                  radius: 20.h,
                  backgroundColor: AppColors.kPrimary,
                  child: Icon(
                    Icons.add,
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kDarkContiner,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
