import 'dart:typed_data';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/create_edit_club/utils/create_edit_club_utils.dart';
import 'package:efficacy_admin/pages/create_edit_club/utils/get_lead_name.dart';
import 'package:efficacy_admin/pages/create_edit_club/widgets/club_form.dart';
import 'package:efficacy_admin/pages/create_edit_club/widgets/create_edit_button.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'widgets/overlay_search.dart';

class CreateEditClub extends StatefulWidget {
  //route
  static const String routeName = '/CreateEditClubPage';
  final bool? createMode;
  final ClubModel? club;

  const CreateEditClub({super.key, this.createMode, this.club});

  @override
  State<CreateEditClub> createState() => _CreateEditClubState();
}

class _CreateEditClubState extends State<CreateEditClub> {
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

  //show invite overlay
  void _showOverlay(BuildContext context) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: height * 0.2,
        left: width * 0.1,
        right: width * 0.1,
        height: height * 0.6,
        child: const Material(
          child: OverlaySearch(),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
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
    getSize(context);
    double profileSize = 100;
    double profileBorder = 7;

    return Stack(children: [
      Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: _createMode
            ? CreateEditButton(label: "Create", onPressed: _validateForm)
            : Column(
                children: [
                  const Spacer(flex: 50),
                  CreateEditButton(
                      onPressed: () {
                        _showOverlay(context);
                      },
                      label: "Invite"),
                  const Spacer(flex: 1),
                  _editMode
                      ? CreateEditButton(
                          onPressed: () {
                            setState(() {
                              _editMode = false;
                            });
                          },
                          label: "Save")
                      : CreateEditButton(
                          onPressed: () {
                            setState(() {
                              _editMode = true;
                            });
                          },
                          label: "Edit"),
                ],
              ),
        body: SafeArea(
          child: SlidingUpPanel(
              padding: const EdgeInsets.only(top: 30),
              maxHeight: height,
              minHeight: height * .70,
              borderRadius: BorderRadius.circular(30),
              header: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: width * 0.33),
                  Container(
                    height: 3,
                    width: width * 0.35,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              panelBuilder: (sc) => ClubForm(
                    editMode: _editMode || _createMode,
                    formKey: _formKey,
                    scrollController: sc,
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
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    height: height * 0.2,
                    child: GestureDetector(
                      onTap: _getBannerImage,
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
                    left: width / 2 - profileSize / 2 - profileBorder * 2,
                    top: height * 0.1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: profileBorder,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: _clubImgPath != null
                          ? ProfileImageViewer(
                              height: profileSize,
                              enabled: true,
                              imagePath: _clubImgPath,
                              onImageChange: (Uint8List? newImage) {
                                _clubImage = newImage;
                              },
                            )
                          : ProfileImageViewer(
                              height: profileSize,
                              enabled: true,
                              imageData: _clubImage,
                              onImageChange: (Uint8List? newImage) {
                                _clubImage = newImage;
                              },
                            ),
                    ),
                  ),
                ],
              )),
        ),
      ),
      Positioned(
        left: 15,
        top: 35,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: dark,
              child: Icon(
                Icons.close,
                size: height * 0.035,
                color: light,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
