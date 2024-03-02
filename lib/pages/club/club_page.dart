import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/utils/tutorials/tutorials.dart';
import 'package:efficacy_admin/pages/club/utils/create_edit_club_utils.dart';
import 'package:efficacy_admin/pages/club/utils/get_lead_name.dart';
import 'package:efficacy_admin/pages/club/widgets/club_form.dart';
import 'package:efficacy_admin/pages/club/widgets/buttons.dart';
import 'package:efficacy_admin/pages/club/widgets/inivte_overlay/invite_overlay.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'widgets/overlay_search.dart';

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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

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

  // Check for guide
  bool isGuideRunning = false;

  // Global keys for guide
  GlobalKey editClubKey = GlobalKey();
  GlobalKey editClubPositionKey = GlobalKey();
  GlobalKey inviteKey = GlobalKey();
  GlobalKey editImageKey = GlobalKey();
  GlobalKey editBannerKey = GlobalKey();
  GlobalKey createKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initData(widget.club);
    if (!_createMode) {
      if (LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.editClub)) {
        isGuideRunning = true;
        Future.delayed(const Duration(seconds: 0), () {
          showEditClubTutorial(
            context,
            editClubKey,
            editClubPositionKey,
            onFinish: () {
              setState(() {
                isGuideRunning = false;
              });
              if (UserController.clubWithModifyMemberPermission
                      .contains(club) &&
                  LocalDatabase.getAndSetGuideStatus(
                      LocalGuideCheck.clubInvite)) {
                isGuideRunning = true;
                showInviteTutorial(
                  context,
                  inviteKey,
                  onFinish: () {
                    setState(() {
                      isGuideRunning = false;
                    });
                  },
                  onSkip: () {
                    setState(() {
                      isGuideRunning = false;
                    });
                    // Returning true to allow skip
                    return true;
                  },
                );
              }
            },
            onSkip: () {
              setState(() {
                isGuideRunning = false;
              });
              // Returning true to allow skip
              return true;
            },
          );
        });
      } else if (UserController.clubWithModifyMemberPermission.contains(club) &&
          LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.clubInvite)) {
        isGuideRunning = true;
        Future.delayed(const Duration(seconds: 0), () {
          showInviteTutorial(
            context,
            inviteKey,
            onFinish: () {
              setState(() {
                isGuideRunning = false;
              });
            },
            onSkip: () {
              setState(() {
                isGuideRunning = false;
              });
              // Returning true to allow skip
              return true;
            },
          );
        });
      }
    }
    if (_createMode &&
        LocalDatabase.getAndSetGuideStatus(LocalGuideCheck.createClub)) {
      isGuideRunning = true;
      Future.delayed(const Duration(seconds: 0), () {
        showCreateClubTutorial(
          context,
          editImageKey,
          editBannerKey,
          createKey,
          onFinish: () {
            setState(() {
              isGuideRunning = false;
            });
          },
          onSkip: () {
            setState(() {
              isGuideRunning = false;
            });
            // Returning true to allow skip
            return true;
          },
        );
      });
    }
  }

  void initData(ClubModel? clubDetail) {
    emailController.text = UserController.currentUser?.email ?? "";
    phoneNumber = UserController.currentUser?.phoneNumber;
    _createMode = widget.createMode ?? false;
    club = clubDetail;
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
  void _showOverlay(BuildContext context) async {
    dynamic res = await showDialog(
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: OverlaySearch(
              club: club,
            ),
          );
        });
    if (res != null && res is List<String> && res.isNotEmpty && mounted) {
      await showDialog(
          useRootNavigator: false,
          context: context,
          builder: (BuildContext context) {
            return InviteOverlay(
              inviteMode: true,
              club: widget.club,
              users: res,
            );
          });
    }
  }

  Future<void> _refresh() async {
    List<ClubModel> clubUpdatedData =
        (await ClubController.get(id: club?.id, forceGet: true).first);
    if (clubUpdatedData.isNotEmpty) {
      setState(() {
        initData(clubUpdatedData.first);
      });
    }
  }

  void _updateClub() async {
    ClubModel? newClub;
    showLoadingOverlay(
      parentContext: context,
      asyncTask: () async {
        UploadInformation logo = UploadInformation(
          url: club!.clubLogoURL,
          publicID: club!.clubLogoPublicId,
        );
        if (_clubImage != null) {
          logo = await ImageController.uploadImage(
            img: _clubImage!,
            folder: ImageFolder.clubImage,
            publicID: UserController.currentUser?.userPhotoPublicID,
            name: nameController.text,
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
            name: "${nameController.text}_banner",
          );
        }
        newClub = await ClubController.update(club!.copyWith(
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
            clubLogoURL: logo.url ?? club!.clubLogoURL,
            clubLogoPublicId: logo.publicID,
            clubBannerURL: banner.url,
            clubBannerPublicId: banner.publicID));
        await UserController.update();
      },
      onCompleted: () {
        if (mounted && newClub != null) {
          showSnackBar(context, "Club Updated");
          Navigator.pop(context, newClub);
        }
      },
    );
  }

  //form validate function
  void _validateAndCreateClub() async {
    if (_clubImage == null) {
      throw Exception("Club must have an image");
    }
    if (_formKey.currentState!.validate()) {
      String? leadName = await getLeadName(context);
      if (leadName == null) {
        throw Exception("Lead name must be provided");
      }
      if (mounted) {
        ClubModel? newClub;
        showLoadingOverlay(
          parentContext: context,
          asyncTask: () async {
            UploadInformation? bannerImageInfo, clubImageInfo;
            if (_bannerImage != null) {
              bannerImageInfo = await ImageController.uploadImage(
                img: _bannerImage!,
                name: "${nameController.text}_banner",
                folder: ImageFolder.clubBanner,
              );
            }
            if (_clubImage != null) {
              clubImageInfo = await ImageController.uploadImage(
                img: _clubImage!,
                name: nameController.text,
                folder: ImageFolder.clubImage,
              );
            }
            if (clubImageInfo?.url == null) {
              throw Exception("Could not upload image");
            }
            // validation logic
            newClub = ClubModel(
              name: nameController.text.trim(),
              description: descController.text,
              email: emailController.text,
              phoneNumber: phoneNumber,
              clubLogoURL: clubImageInfo!.url!,
              clubStatus: ClubStatus.requested,
              clubLogoPublicId: clubImageInfo.publicID,
              clubBannerURL: bannerImageInfo?.url,
              clubBannerPublicId: bannerImageInfo?.publicID,
              instituteName: instituteName.trim(),
              members: {},
            );
            newClub = await ClubController.create(newClub!);
            if (newClub != null) {
              ClubPositionModel? clubPosition =
                  await ClubPositionController.create(
                ClubPositionModel(
                  clubID: newClub!.id!,
                  position: leadName,
                  permissions: Permissions.values,
                ),
              );
              if (clubPosition != null && clubPosition.id != null) {
                newClub = newClub!.copyWith(
                  members: {
                    clubPosition.id!: [UserController.currentUser!.email],
                  },
                  leadPositionID: clubPosition.id,
                );
                newClub = await ClubController.update(newClub!);
                List<String> clubPositions =
                    UserController.currentUser!.position;
                clubPositions = [...clubPositions, clubPosition.id!];
                UserController.currentUser =
                    UserController.currentUser!.copyWith(
                  position: clubPositions,
                );
                await UserController.update();
              }

              if (mounted && newClub != null) {
                showSnackBar(
                    context, "Club requested for approval from developers.");
                Navigator.pop(context, newClub);
              }
            }
          },
        );
      }
    } else {
      showSnackBar(
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

    Widget child = Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: vMargin),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.25,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(
                        height: height * 0.15,
                        width: width,
                        child: GestureDetector(
                          key: editBannerKey,
                          onTap: (_editMode || _createMode)
                              ? _getBannerImage
                              : () {},
                          child: _bannerImgPath != null
                              ? CachedNetworkImage(
                                  imageUrl: _bannerImgPath!,
                                  fit: BoxFit.cover,
                                  width: width,
                                  errorWidget: (_, __, ___) {
                                    return Image.asset(
                                      "assets/images/media.png",
                                      width: width,
                                      fit: BoxFit.cover,
                                    );
                                  },
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
                        key: editImageKey,
                        left: profileSize / 2 - profileBorder * 2,
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
                                  enabled: _editMode || _createMode,
                                  imagePath: _clubImgPath,
                                  onImageChange: (Uint8List? newImage) {
                                    _clubImage = newImage;
                                  },
                                )
                              : ProfileImageViewer(
                                  pickFromCamera: false,
                                  height: profileSize,
                                  enabled: _editMode || _createMode,
                                  imageData: _clubImage,
                                  onImageChange: (Uint8List? newImage) {
                                    _clubImage = newImage;
                                  },
                                ),
                        ),
                      ),
                      Positioned(
                          right: profileBorder * 2,
                          top: height * 0.12,
                          child: Row(
                            children: [
                              if (UserController.clubWithModifyClubPermission
                                  .contains(club))
                                EditPositionButton(
                                    key: editClubPositionKey,
                                    onPressed: () async {
                                      await showDialog(
                                          context: context,
                                          useRootNavigator: false,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: InviteOverlay(
                                                inviteMode: false,
                                                club: club,
                                              ),
                                            );
                                          });
                                    }),
                              if (UserController.clubWithModifyMemberPermission
                                  .contains(club))
                                InviteButton(
                                    key: inviteKey,
                                    onPressed: () {
                                      _showOverlay(context);
                                    }),
                            ].separate(profileBorder),
                          ))
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
    );

    return PopScope(
      canPop: !isGuideRunning,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        endDrawer: CustomDrawer(
          pageContext: context,
        ),
        appBar: CustomAppBar(
            title: (_createMode) ? "New Club" : nameController.text,
            actions: [
              if (_editMode == false &&
                  _createMode == false &&
                  UserController.clubWithModifyClubPermission.contains(club))
                EditButton(
                  key: editClubKey,
                  onPressed: () {
                    setState(() {
                      _editMode = true;
                    });
                  },
                ),
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: _createMode
            ? CreateButton(key: createKey, onPressed: _validateAndCreateClub)
            : _editMode
                ? SaveButton(onPressed: () {
                    _updateClub();
                    setState(() {
                      _editMode = false;
                    });
                  })
                : null,
        body: _createMode == true
            ? child
            : RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refresh,
                child: child,
              ),
      ),
    );
  }
}
