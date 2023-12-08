import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:efficacy_admin/config/configurations/theme/utils/palette.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// [imagePath] refers to a network image
/// [imageData] is for local data while editing
class ProfileImageViewer extends StatefulWidget {
  final double height;
  final String? imagePath;
  final Uint8List? imageData;
  final bool enabled;
  final void Function(Uint8List?)? onImageChange;
  const ProfileImageViewer({
    super.key,
    this.height = 150,
    this.imagePath,
    this.imageData,
    this.enabled = true,
    this.onImageChange,
  });

  @override
  State<ProfileImageViewer> createState() => _ProfileImageViewerState();
}

class _ProfileImageViewerState extends State<ProfileImageViewer> {
  Uint8List? _image;
  ImagePicker picker = ImagePicker();

  void updateImage(Uint8List? image) {
    if (image != null) {
      setState(() {
        _image = image;
      });
      if (widget.onImageChange != null) {
        widget.onImageChange!(image);
      }
    }
  }

  Future<Uint8List?> pickImage(ImageSource imageSource) async {
    Uint8List? img = await ImageController.compressedImage(
      source: ImageSource.gallery,
      maxSize: 1024 * 1024,
      context: context,
    );
    if (img != null && mounted) {
      Directory tempDir = await getTemporaryDirectory();
      File compressed = File("${tempDir.path}/compressed.jpg");
      await compressed.writeAsBytes(img);

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: compressed.path,
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
      if (croppedFile != null) {
        img = await croppedFile.readAsBytes();
      }
      await compressed.delete(recursive: true);
    }
    return img;
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
    if (widget.imageData != null) {
      _image = widget.imageData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => (widget.enabled) ? _showPicker(context) : null,
        child: CircleAvatar(
          backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
          radius: widget.height / 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.height / 2),
            // clipBehavior: Clip.hardEdge,
            child: _image != null
                ? Image.memory(
                    _image!,
                    fit: BoxFit.cover,
                    height: widget.height,
                  )
                : widget.imagePath != null
                    ? CachedNetworkImage(
                        imageUrl: widget.imagePath!,
                        fit: BoxFit.cover,
                        height: widget.height,
                        errorWidget: (BuildContext context, _, __) {
                          return Icon(
                            CupertinoIcons.person_alt_circle,
                            size: widget.height,
                          );
                        },
                      )
                    : Icon(
                        CupertinoIcons.person_alt_circle,
                        size: widget.height,
                      ),
          ),
        ),
      ),
    );
  }
}
