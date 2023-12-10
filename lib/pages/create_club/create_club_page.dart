import 'dart:typed_data';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/pages/create_club/utils/create_club_utils.dart';
import 'package:efficacy_admin/pages/create_club/widgets/club_form.dart';
import 'package:efficacy_admin/pages/create_club/widgets/create_button.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CreateClub extends StatefulWidget {
  //route
  static const String routeName = '/CreateClubPage';

  const CreateClub({super.key});

  @override
  State<CreateClub> createState() => _CreateClubState();
}

class _CreateClubState extends State<CreateClub> {
  //form variables
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController githubUrlController = TextEditingController();
  TextEditingController fbUrlController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController instituteController = TextEditingController();

  //form validate function
  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      // validation logic
      ClubModel club = ClubModel(
        name: nameController.text,
        description: descController.text,
        email: emailController.text,
        clubLogoURL: "",
        instituteName: instituteController.text,
        members: Map(),
      );
      ClubController.create(club);
    } else {
      showErrorSnackBar(
          context, "Create failed. Please enter valid credentials");
    }
  }

  //image variables
  Uint8List? _bannerImage;
  Uint8List? _profileImage;

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

    return Stack(children: [
      Scaffold(
        floatingActionButton: CreateButton(onPressed: _validateForm),
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
              formKey: _formKey,
              scrollController: sc,
              nameController: nameController,
              descController: descController,
              githubUrlController: githubUrlController,
              fbUrlController: fbUrlController,
              instaController: instaController,
              linkedinController: linkedinController,
              emailController: emailController,
              instituteController: instituteController,
            ),
            body: _bannerImage == null
                ? Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset(
                        "assets/images/media.png",
                        width: width,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: width / 3),
                        child: SizedBox(
                          height: buttonHeight,
                          width: buttonWidth,
                          child: ElevatedButton(
                            onPressed: () => _getBannerImage(),
                            child: const Text("Pick Banner"),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 20,
                          top: height * 0.08,
                          child: ProfileImageViewer(
                            height: 100,
                            enabled: true,
                            imageData: _profileImage,
                            onImageChange: (Uint8List? newImage) {
                              _profileImage = newImage;
                            },
                          )),
                    ],
                  )
                : Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () => _getBannerImage(),
                          child: Image.memory(
                            _bannerImage!,
                            width: width,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                            left: 20,
                            top: height * 0.08,
                            child: ProfileImageViewer(
                              height: 100,
                              enabled: true,
                              imageData: _profileImage,
                              onImageChange: (Uint8List? newImage) {
                                _profileImage = newImage;
                              },
                            )),
                      ],
                    ),
                  ),
          ),
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
