import 'dart:typed_data';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/club/utils/create_edit_club_utils.dart';
import 'package:efficacy_admin/pages/club/utils/get_lead_name.dart';
import 'package:efficacy_admin/pages/club/widgets/club_form.dart';
import 'package:efficacy_admin/pages/club/widgets/buttons.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ClubPage extends StatefulWidget {
  //route
  static const String routeName = '/ClubPage';
  final bool? createMode;
  final ClubModel? club;
  const ClubPage({super.key, this.createMode, this.club});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  //form variables
  final _formKey = GlobalKey<FormState>();
  late bool _createMode;
  bool _editMode = false;
  late ClubModel? club;

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController githubUrlController = TextEditingController();
  TextEditingController fbUrlController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String instituteName = "NIT, Silchar";
  PhoneNumber? phoneNumber;

  @override
  void initState() {
    super.initState();
    emailController.text = UserController.currentUser?.email ?? "";
    phoneNumber = UserController.currentUser?.phoneNumber;
    _createMode = widget.createMode ?? false;
    club = widget.club;
    if (_createMode == false) {
      nameController.text = club?.name ?? "NIL";
      descController.text = club?.description ?? "NIL";
      githubUrlController.text = club?.socials[Social.github] ?? "";
      fbUrlController.text = club?.socials[Social.facebook] ?? "";
      instaController.text = club?.socials[Social.instagram] ?? "";
      linkedinController.text = club?.socials[Social.linkedin] ?? "";
      instituteName = club?.instituteName ?? "NIT, Silchar";
      _clubImgPath = club?.clubLogoURL;
      _bannerImgPath = club?.clubBannerURL;
      emailController.text = club?.email ?? "NIL";
      phoneNumber = club?.phoneNumber;
    }
  }

// Function to update club
  void _updateClub() async {
    UploadInformation logo = UploadInformation(
      url: club!.clubLogoURL,
      publicID: club!.clubLogoPublicId,
    );
    if (_clubImage != null) {
      logo = await ImageController.uploadImage(
        img: _clubImage!,
        folder: ImageFolder.clubImage,
        publicID: UserController.currentUser?.userPhotoPublicID,
        userName: nameController.text,
      );
    }
    UploadInformation banner = UploadInformation(
      url: club!.clubBannerURL,
      publicID: club!.clubBannerPublicId,
    );
    if (_bannerImage != null) {
      logo = await ImageController.uploadImage(
        img: _bannerImage!,
        folder: ImageFolder.clubBanner,
        publicID: UserController.currentUser?.userPhotoPublicID,
        userName: "${nameController.text}_banner",
      );
    }
    await ClubController.update(club!.copyWith(
        name: nameController.text,
        description: descController.text,
        socials: {
          Social.github: githubUrlController.text,
          Social.facebook: fbUrlController.text,
          Social.instagram: instaController.text,
          Social.linkedin: linkedinController.text
        },
        email: emailController.text,
        phoneNumber: phoneNumber,
        clubLogoURL: logo.url!,
        clubLogoPublicId: logo.publicID,
        clubBannerURL: banner.url!,
        clubBannerPublicId: banner.publicID));
  }

  //form validate function
  void _validateForm() async {
    if (_clubImage == null) {
      throw Exception("Club must have an image");
    }
    if (_formKey.currentState!.validate()) {
      String? leadName = await getLeadName(context);
      if (leadName == null) {
        throw Exception("Lead name must be provided");
      }
      showLoadingOverlay(
        context: context,
        asyncTask: () async {
          UploadInformation? bannerImageInfo, clubImageInfo;
          if (_bannerImage != null) {
            bannerImageInfo = await ImageController.uploadImage(
              img: _bannerImage!,
              userName: "${nameController.text}_banner",
              folder: ImageFolder.clubBanner,
            );
          }
          if (_clubImage != null) {
            clubImageInfo = await ImageController.uploadImage(
              img: _clubImage!,
              userName: nameController.text,
              folder: ImageFolder.clubImage,
            );
          }
          if (clubImageInfo?.url == null) {
            throw Exception("Could not upload image");
          }
          // validation logic
          ClubModel? club = ClubModel(
            name: nameController.text,
            description: descController.text,
            email: emailController.text,
            phoneNumber: phoneNumber,
            clubLogoURL: clubImageInfo!.url!,
            clubLogoPublicId: clubImageInfo.publicID,
            clubBannerURL: bannerImageInfo?.url,
            clubBannerPublicId: bannerImageInfo?.publicID,
            instituteName: instituteName,
            members: {},
          );
          club = await ClubController.create(club!);
          if (club != null) {
            ClubPositionModel? clubPosition =
                await ClubPositionController.create(
              ClubPositionModel(
                clubID: club!.id!,
                position: leadName,
                permissions: Permissions.values,
              ),
            );
            if (clubPosition != null && clubPosition.id != null) {
              club = club!.copyWith(
                members: {
                  clubPosition.id!: [UserController.currentUser!.id!],
                },
              );
              await ClubController.update(club!);
              List<String> clubPositions = UserController.currentUser!.position;
              clubPositions = [...clubPositions, clubPosition.id!];
              UserController.currentUser = UserController.currentUser!.copyWith(
                position: clubPositions,
              );
              await UserController.update();
            }
          }
        },
        onCompleted: () {
          if (mounted) {
            showErrorSnackBar(context, "Club Created");
            Navigator.pop(context);
          }
        },
      );
    } else {
      showErrorSnackBar(
        context,
        "Please fill the required fields",
      );
    }
  }

//image variables
  Uint8List? _bannerImage;
  Uint8List? _clubImage;
  String? _bannerImgPath;
  String? _clubImgPath;

//function to get banner image from gallery
  Future<void> _getBannerImage() async {
    Uint8List? temp = await ImageController.compressedImage(
      source: ImageSource.gallery,
      maxSize: 1024 * 1024,
      context: context,
    );
    setState(() {
      _bannerImage = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    //screen size
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double gap = height * 0.02;
    double hMargin = width * 0.08;
    double vMargin = width * 0.08;
    getSize(context);
    double profileSize = 100;
    double profileBorder = 7;

    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: CustomAppBar(
          title: (_createMode) ? "New Club" : nameController.text,
          actions: [
            if (_editMode == false && _createMode == false)
              EditButton(
                onPressed: () {
                  setState(() {
                    _editMode = true;
                  });
                },
              ),
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _createMode
          ? CreateButton(onPressed: _validateForm)
          : _editMode
              ? SaveButton(onPressed: () {
                  _updateClub();
                  setState(() {
                    _editMode = false;
                  });
                })
              : null,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: vMargin),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.25,
                    // clipBehavior: Clip.none,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        SizedBox(
                          height: height * 0.15,
                          width: width,
                          child: GestureDetector(
                            onTap: (_editMode || _createMode)
                                ? _getBannerImage
                                : () {},
                            child: _bannerImgPath != null
                                ? Image(
                                    image: NetworkImage(_bannerImgPath!),
                                    fit: BoxFit.cover,
                                    width: width,
                                  )
                                : _bannerImage == null
                                    ? Image.asset(
                                        "assets/images/media.png",
                                        width: width,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.memory(
                                        _bannerImage!,
                                        width: width,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                        ),
                        Positioned(
                          left: profileSize / 2 - profileBorder * 2,
                          top: height * 0.1,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: profileBorder,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: _clubImgPath != null
                                ? ProfileImageViewer(
                                    height: profileSize,
                                    enabled: _editMode || _createMode,
                                    imagePath: _clubImgPath,
                                    onImageChange: (Uint8List? newImage) {
                                      _clubImage = newImage;
                                    },
                                  )
                                : ProfileImageViewer(
                                    height: profileSize,
                                    enabled: _editMode || _createMode,
                                    imageData: _clubImage,
                                    onImageChange: (Uint8List? newImage) {
                                      _clubImage = newImage;
                                    },
                                  ),
                          ),
                        ),
                        (_editMode || _createMode)
                            ? Container()
                            : Positioned(
                                left: width - profileSize - profileBorder * 2,
                                top: height * 0.12,
                                child: InviteButton(onPressed: () {}))
                      ],
                    ),
                  ),
                  ClubForm(
                    editMode: _editMode || _createMode,
                    formKey: _formKey,
                    nameController: nameController,
                    descController: descController,
                    githubUrlController: githubUrlController,
                    phoneNumber: phoneNumber,
                    onPhoneChanged: (PhoneNumber? phone) {
                      setState(() {
                        phoneNumber = phone;
                      });
                    },
                    fbUrlController: fbUrlController,
                    instaController: instaController,
                    linkedinController: linkedinController,
                    emailController: emailController,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
