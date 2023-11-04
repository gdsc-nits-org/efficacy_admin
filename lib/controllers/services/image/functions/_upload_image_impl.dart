part of '../image_controller.dart';

Future<String> _uploadImageImpl({
  required Uint8List img,
  String? clubName,
  String? eventName,
  String? userName,
  required ImageFolder folder,
  void Function(int count, int total)? progressCallback,
}) async {
  if (folder == ImageFolder.eventThumbnail &&
      (eventName == null || clubName == null)) {
    throw Exception("Club And Event Name are required");
  } else if (folder == ImageFolder.userImage && userName == null) {
    throw Exception("User name is required");
  }
  String fileName = "";
  if (folder == ImageFolder.eventThumbnail) {
    fileName = "${clubName}_$eventName";
  } else if (folder == ImageFolder.userImage) {
    fileName = userName!;
  }
  Cloudinary cloudinary = Cloudinary.signedConfig(
    apiKey: dotenv.env[EnvValues.CLOUDINARY_API_KEY.name]!,
    apiSecret: dotenv.env[EnvValues.CLOUDINARY_API_SECRET.name]!,
    cloudName: dotenv.env[EnvValues.CLOUDINARY_CLOUD_NAME.name]!,
  );
  CloudinaryResponse response = await cloudinary.upload(
    fileBytes: img.toList(),
    resourceType: CloudinaryResourceType.image,
    folder: folder.name,
    fileName: '${fileName}_${DateTime.now().millisecondsSinceEpoch}',
    progressCallback: progressCallback,
  );

  if (response.isSuccessful && response.secureUrl != null) {
    return response.secureUrl!;
  } else {
    throw Exception("Couldn't upload image");
  }
}
