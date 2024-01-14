part of '../image_controller.dart';

Future<UploadInformation> _uploadImageImpl({
  required Uint8List img,
  String? clubName,
  String? eventName,
  String? name,
  String? publicID,
  required ImageFolder folder,
  void Function(int count, int total)? progressCallback,
}) async {
  if (folder == ImageFolder.eventThumbnail) {
    if ((eventName == null || clubName == null)) {
      throw Exception("Club And Event Name are required");
    }
  } else if (name == null) {
    throw Exception("User name is required");
  }
  String fileName = "";
  if (folder == ImageFolder.eventThumbnail) {
    fileName = "${clubName}_$eventName";
  } else {
    fileName = name!;
  }
  Cloudinary cloudinary = Cloudinary.signedConfig(
    apiKey: dotenv.env[EnvValues.CLOUDINARY_API_KEY.name]!,
    apiSecret: dotenv.env[EnvValues.CLOUDINARY_API_SECRET.name]!,
    cloudName: dotenv.env[EnvValues.CLOUDINARY_CLOUD_NAME.name]!,
  );
  if (publicID != null) {
    await cloudinary.destroy(publicID);
  }

  CloudinaryResponse response = await cloudinary.upload(
    fileBytes: img.toList(),
    resourceType: CloudinaryResourceType.image,
    folder: folder.name,
    fileName: '${fileName}_${DateTime.now().millisecondsSinceEpoch}',
    progressCallback: progressCallback,
  );

  if (response.isSuccessful && response.secureUrl != null) {
    return UploadInformation(
      url: response.secureUrl!,
      publicID: response.publicId,
    );
  } else {
    throw Exception("Couldn't upload image");
  }
}
