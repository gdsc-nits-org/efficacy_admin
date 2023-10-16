import 'dart:typed_data';
import 'package:cloudinary/cloudinary.dart';
import 'package:efficacy_admin/utils/database/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageController {
  const ImageController._();

  /// Uploads image to the server and
  /// returns the url if the image was uploaded successfully
  static Future<String> uploadImage({
    required Uint8List img,
    required String clubName,
    required String eventName,
    void Function(int count, int total)? progressCallback,
  }) async {
    Cloudinary cloudinary = Cloudinary.signedConfig(
      apiKey: dotenv.env[EnvValues.CLOUDINARY_API_KEY]!,
      apiSecret: dotenv.env[EnvValues.CLOUDINARY_API_SECRET]!,
      cloudName: dotenv.env[EnvValues.CLOUDINARY_CLOUD_NAME]!,
    );
    CloudinaryResponse response = await cloudinary.upload(
      fileBytes: img.toList(),
      resourceType: CloudinaryResourceType.image,
      folder: "events/posters",
      fileName:
          '${clubName}_${eventName}_${DateTime.now().millisecondsSinceEpoch}',
      progressCallback: progressCallback,
    );

    if (response.isSuccessful && response.secureUrl != null) {
      return response.secureUrl!;
    } else {
      throw Exception("Couldn't upload image");
    }
  }
}
