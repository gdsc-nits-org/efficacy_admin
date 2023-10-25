import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileImageViewer extends StatefulWidget {
  final double height;
  final File? image;
  final bool enabled;
  final void Function(String)? onImageChange;
  const ProfileImageViewer({
    super.key,
    this.height = 150,
    this.image,
    this.enabled = true,
    this.onImageChange,
  });

  @override
  State<ProfileImageViewer> createState() => _ProfileImageViewerState();
}

class _ProfileImageViewerState extends State<ProfileImageViewer> {
  File? _image;
  ImagePicker picker = ImagePicker();

  void updateImage(File? image) {
    if (image != null) {
      setState(() {
        _image = image;
      });
      if (widget.onImageChange != null) {
        widget.onImageChange!(image.path);
      }
    }
  }

  Future<File?> pickImage(ImageSource imageSource) async {
    XFile? original =
        await picker.pickImage(source: imageSource, imageQuality: 50);
    XFile? compressed = await FlutterImageCompress.compressAndGetFile(
        original!.path, "${original.path}compressed.jpg",
        quality: 10);
    // debugPrint('Initial file size: ${File(original.path).lengthSync()} bytes');
    // debugPrint(
    //     'Compressed file size: ${File(compressed!.path).lengthSync()} bytes');
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: compressed!.path,
      cropStyle: CropStyle.circle,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: dark,
            activeControlsWidgetColor: shadow,
            toolbarWidgetColor: light,
            initAspectRatio: CropAspectRatioPreset.original,
            dimmedLayerColor: shadow,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );
    return File(croppedFile!.path);
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
      onTap: () => (widget.enabled)?_showPicker(context):null,
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
                  width: widget.height,
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
