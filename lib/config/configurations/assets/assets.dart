/// CONVENTION:
/// _basePath is prefixed to every asset
/// As required the next folders are added like image and svg
///
/// When searching all the paths which are for images must contain Image in their name
/// Same for others

class Assets {
  static const String _basePath = "assets";
  static const String _imageBasePath = "images";
  static const String _svgBasePath = "svgs";

  static const String googleLogoSVGPath =
      "$_basePath/$_svgBasePath/google_logo.svg";
  static const String efficacyAdminLogoImagePath =
      "$_basePath/$_imageBasePath/efficacy_admin_logo.png";
}
