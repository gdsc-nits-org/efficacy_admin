import 'dart:typed_data';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/profile_page/utils/tutorial.dart';
import 'package:efficacy_admin/pages/profile_page/widgets/buttons.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:efficacy_admin/widgets/custom_drop_down/custom_drop_down.dart';
import 'package:efficacy_admin/widgets/custom_phone_input/custom_phone_input.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_admin/config/config.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../widgets/coach_mark_desc/coach_mark_desc.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/ProfilePage';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final _formKey = GlobalKey<FormState>();

  // Global keys for guide
  GlobalKey editProfileKey = GlobalKey();
  GlobalKey delProfileKey = GlobalKey();

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
    if (LocalDatabase.getGuideStatus(LocalGuideCheck.profile)) {
      Future.delayed(const Duration(seconds: 1), () {
        showProfilePageTutorial(
          context,
          editProfileKey,
          delProfileKey,
          scrollController,
        );
      });
    }
  }

  void init() async {
    _nameController.text = UserController.currentUser!.name;
    _scholarIDController.text = UserController.currentUser!.scholarID;
    _emailController.text = UserController.currentUser!.email;
    selectedDegree = UserController.currentUser!.degree.name;
    selectedBranch = UserController.currentUser!.branch.name;
    phoneNumber = UserController.currentUser!.phoneNumber;
  }

  bool editMode = false;

  //controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _scholarIDController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String selectedDegree = Degree.BTech.name;
  String selectedBranch = Branch.CSE.name;
  Uint8List? image;
  PhoneNumber? phoneNumber;

  void enableEdit() {
    setState(() {
      editMode = true;
    });
  }

  void saveUpdates() async {
    if (_formKey.currentState!.validate()) {
      showLoadingOverlay(
        context: context,
        asyncTask: () async {
          UploadInformation info = UploadInformation(
            url: UserController.currentUser?.userPhoto,
            publicID: UserController.currentUser?.userPhotoPublicID,
          );
          if (image != null) {
            info = await ImageController.uploadImage(
              img: image!,
              folder: ImageFolder.userImage,
              publicID: UserController.currentUser?.userPhotoPublicID,
              name: _nameController.text,
            );
          }
          UserController.currentUser = UserController.currentUser?.copyWith(
            name: _nameController.text,
            scholarID: _scholarIDController.text,
            userPhoto: info.url,
            userPhotoPublicID: info.publicID,
            phoneNumber: phoneNumber,
            branch: Branch.values
                .firstWhere((branch) => branch.name == selectedBranch),
            degree: Degree.values
                .firstWhere((degree) => degree.name == selectedDegree),
          );
          await UserController.update();
        },
        onCompleted: () {
          setState(() {
            editMode = false;
          });
        },
      );
    }
  }

  Future<void> _refresh() async {
    await UserController.loginSilently(forceGet: true).first;
    init();
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
    double vMargin = width * 0.16;

    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: CustomAppBar(title: "Profile", actions: [
        if (editMode == false)
          EditButton(
            key: editProfileKey,
            onPressed: () {
              enableEdit();
            },
          ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: editMode
          ? SaveButton(onPressed: () {
              saveUpdates();
            })
          : null,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: vMargin, horizontal: hMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileImageViewer(
                      enabled: editMode,
                      imagePath: UserController.currentUser?.userPhoto,
                      imageData: image,
                      onImageChange: (Uint8List? newImage) {
                        image = newImage;
                      },
                    ),
                    CustomTextField(
                      controller: _nameController,
                      title: "Name",
                      enabled: editMode,
                      validator: Validator.isNameValid,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      title: "Email",
                      enabled: false,
                      validator: Validator.isEmailValid,
                    ),
                    CustomPhoneField(
                      title: "Phone",
                      initialValue: phoneNumber,
                      onPhoneChanged: (PhoneNumber newPhoneNumber) {
                        phoneNumber = newPhoneNumber;
                      },
                      enabled: editMode,
                    ),
                    CustomTextField(
                      controller: _scholarIDController,
                      title: "ScholarID",
                      enabled: editMode,
                      validator: Validator.isScholarIDValid,
                    ),
                    CustomDropDown(
                      title: "Branch",
                      items:
                          Branch.values.map((branch) => branch.name).toList(),
                      enabled: editMode,
                      value: UserController.currentUser!.branch.name,
                      onChanged: (String? newSelectedBranch) {
                        selectedBranch = newSelectedBranch ??
                            UserController.currentUser!.branch.name;
                      },
                    ),
                    CustomDropDown(
                      title: "Degree",
                      items:
                          Degree.values.map((degree) => degree.name).toList(),
                      enabled: editMode,
                      value: UserController.currentUser!.degree.name,
                      onChanged: (String? newSelectedDegree) {
                        selectedDegree = newSelectedDegree ??
                            UserController.currentUser!.degree.name;
                      },
                    ),
                    DeleteProfileButton(
                      key: delProfileKey,
                    ),
                  ].separate(gap),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
