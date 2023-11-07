import 'dart:math';
import 'dart:typed_data';
import 'package:cloudinary/cloudinary.dart';
import 'package:efficacy_admin/utils/database/constants.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:efficacy_admin/widgets/compressed_image/image_compressor.dart';

part 'functions/_upload_image_impl.dart';
part 'functions/_compressed_image_impl.dart';
part 'functions/_get_min_size_impl.dart';
part 'functions/_user_compression_impl.dart';

class UploadInformation {
  final String? url;
  final String? publicID;
  const UploadInformation({
    required this.url,
    required this.publicID,
  });
}

enum ImageFolder {
  eventThumbnail("events/posters"),
  userImage("users/profile");

  final String name;
  const ImageFolder(this.name);
}

class ImageController {
  const ImageController._();

  static Future<int> _getMinSize(Uint8List image, int maxSize) async {
    return _getMinSizeImpl(image, maxSize);
  }

  static Future<Uint8List?> _userCompression({
    required Uint8List image,
    required int maxQuality,
    required BuildContext context,
  }) async {
    return _userCompressionImpl(
      image: image,
      maxQuality: maxQuality,
      context: context,
    );
  }

  /// Uploads image to the server and
  /// returns the url if the image was uploaded successfully
  static Future<UploadInformation> uploadImage({
    required Uint8List img,
    String? clubName,
    String? eventName,
    String? userName,
    String? publicID,
    required ImageFolder folder,
    void Function(int count, int total)? progressCallback,
  }) async {
    return _uploadImageImpl(
      img: img,
      clubName: clubName,
      eventName: eventName,
      userName: userName,
      folder: folder,
      publicID: publicID,
      progressCallback: progressCallback,
    );
  }

  static Future<Uint8List?> compressedImage({
    required ImageSource source,
    required int maxSize,
    required BuildContext context,
  }) async {
    return await _compressedImageImpl(
      source: source,
      maxSize: maxSize,
      context: context,
    );
  }
}
