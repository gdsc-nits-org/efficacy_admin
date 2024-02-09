/// CONVENTION:
/// _basePath is prefixed to every asset
/// As required the next folders are added like image and svg
///
/// When searching all the paths which are for images must contain Image in their name
/// Same for others

class Assets {
  const Assets._();
  static const String _basePath = "assets";
  static const String _imageBasePath = "images";
  static const String _fontBasePath = "fonts";

  static const String gdscLogoImagePath =
      "$_basePath/$_imageBasePath/gdsc_logo.png";
  static const String googleLogoImagePath =
      "$_basePath/$_imageBasePath/google_logo.png";
  static const String efficacyAdminLogoImagePath =
      "$_basePath/$_imageBasePath/efficacy_admin_logo.png";
  static const String mediaImgPath = "$_basePath/$_imageBasePath/media.png";

  static const String regularFontPath =
      "$_basePath/$_fontBasePath/Sofia_Pro/SofiaProRegular.ttf";
}
