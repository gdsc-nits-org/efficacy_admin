import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileImageViewer extends StatefulWidget {
  final double height;
  final File? image;
  final void Function(String)? onImageChange;
  const ProfileImageViewer({
    super.key,
    this.height = 150,
    this.image,
    this.onImageChange,
  });

  @override
  State<ProfileImageViewer> createState() => _ProfileImageViewerState();
}

class _ProfileImageViewerState extends State<ProfileImageViewer> {
  File? _image;
  ImagePicker picker = ImagePicker();

  void updateImage(XFile? image) {
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      if (widget.onImageChange != null) {
        widget.onImageChange!(image.path);
      }
    }
  }

  Future<XFile?> pickImage(ImageSource imageSource) async {
    return await picker.pickImage(source: imageSource, imageQuality: 50);
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Photo Library'),
                  onTap: () async {
                    updateImage(await pickImage(ImageSource.gallery));
                    if (mounted) Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  updateImage(await pickImage(ImageSource.camera));
                  if (mounted) Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPicker(context),
      child: CircleAvatar(
        backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
        radius: widget.height / 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.height / 2),
          clipBehavior: Clip.hardEdge,
          child: _image != null
              ? Image.file(
                  _image!,
                  fit: BoxFit.fitHeight,
                  height: widget.height,
                )
              : Icon(
                  CupertinoIcons.person_alt_circle,
                  size: widget.height,
                ),
        ),
      ),
    );
  }
}
