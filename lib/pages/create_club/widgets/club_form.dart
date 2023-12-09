import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/pages/create_club/utils/create_club_utils.dart';
import 'package:efficacy_admin/pages/create_club/widgets/custom_field.dart';
import 'package:efficacy_admin/pages/create_event/widgets/url_input.dart';
import 'package:efficacy_admin/widgets/custom_phone_input/custom_phone_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClubForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ScrollController scrollController;
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController githubUrlController;
  final TextEditingController fbUrlController;
  final TextEditingController instaController;
  final TextEditingController linkedinController;
  final TextEditingController emailController;
  final TextEditingController instituteController;

  const ClubForm(
      {super.key,
      required this.formKey,
      required this.scrollController,
      required this.nameController,
      required this.descController,
      required this.githubUrlController,
      required this.fbUrlController,
      required this.instaController,
      required this.linkedinController,
      required this.emailController,
      required this.instituteController});

  @override
  State<ClubForm> createState() => _ClubFormState();
}

class _ClubFormState extends State<ClubForm> {
  Future<void> prepareData() async {
    /// User is created
    // print(await UserController.create(
    //   const UserModel(
    //       name: "Rajdristant",
    //       password: "123456",
    //       email: "raj@gmail.com",
    //       scholarID: "2112035",
    //       branch: Branch.CSE,
    //       degree: Degree.BTech),
    // ));
    /// Or User is logged in
    // print(
    //   await UserController.login(
    //     email: "raj@gmail.com",
    //     password: "123456",
    //   ),
    // );

    /// In case user was previously logged in/ signed up
    // print(await UserController.loginSilently().first);
    //

    /// User Creates a club
    // ClubModel? club = await ClubController.create(
    //   ClubModel(
    //     name: "GDSC Test",
    //     instituteName: "NIT Silchar",
    //     description: "Google Developer Student Clubs, NIT Silchar Test",
    //     email: UserController.currentUser!.email,
    //     clubLogoURL:
    //         "https://images.unsplash.com/photo-1682686580922-2e594f8bdaa7?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
    //     members: {},
    //   ),
    // );

    /// User is asked for his position
    /// User is by default taken as the lead and is asked to fill the name of the position of lead
    /// With all the permissions
    // ClubPositionModel? clubPosition = await ClubPositionController.create(
    //   ClubPositionModel(
    //     clubID: club!.id!,
    //     position: "Lead",
    //     permissions: Permissions.values,
    //   ),
    // );
    //
    /// A special invitation is then sent to the user with senderID as the same as itself only for this case
    // InvitationModel? invitation = await InvitationController.create(
    //   InvitationModel(
    //     clubPositionID: clubPosition!.id!,
    //     senderID: UserController.currentUser!.id!,
    //     recipientID: UserController.currentUser!.id!,
    //   ),
    // );

    /// And the invitation in accepted automatically
    // await InvitationController.acceptInvitation(invitation!.id!);
  }

  @override
  Widget build(BuildContext context) {
    // prepareData();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
      child: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: [
              //Name
              CustomField(
                controller: widget.nameController,
                hintText: 'Club Name',
                icon: Icons.title,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              //institute name
              CustomField(
                controller: widget.instituteController,
                hintText: "Institute Name",
                icon: FontAwesomeIcons.institution,
                validator: (name) {
                  if (name!.isEmpty) {
                    return "institute name cannot be empty";
                  }
                  return null;
                },
              ),
              //club description
              CustomField(
                hintText: 'Club Description',
                validator: (value) {
                    if(value!.isEmpty){
                      return "description cannot be empty";
                    }
                    return null;
                },
                icon: FontAwesomeIcons.alignLeft,
                controller: widget.descController,
                maxLines: 6,
              ),
              //phone number
              Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: CustomPhoneField(
                  onPhoneChanged: (phoneNumber) {},
                ),
              ),
              CustomField(
                controller: widget.emailController,
                textInputType: TextInputType.emailAddress,
                hintText: "email address",
                icon: Icons.mail,
                validator: (email) {
                  return null;
                },
              ),
              //facebook link
              UrlInput(
                controller: widget.fbUrlController,
                icon: FontAwesomeIcons.facebook,
                hintText: 'Facebook page URL',
                validator: (value) {
                  return null;
                },
              ),
              //github link
              UrlInput(
                controller: widget.githubUrlController,
                icon: FontAwesomeIcons.github,
                hintText: 'GitHub profile URL',
                validator: (value) {
                  return null;
                },
              ),
              //insta link
              UrlInput(
                controller: widget.instaController,
                icon: FontAwesomeIcons.instagram,
                hintText: 'Instagram page URL',
                validator: (value) {
                  return null;
                },
              ),
              //linked in link
              UrlInput(
                controller: widget.linkedinController,
                icon: FontAwesomeIcons.linkedinIn,
                hintText: 'LinkedIn page URL',
                validator: (value) {
                  return null;
                },
              ),
              //gap at the end
              SizedBox(
                height: endGap,
              )
            ].separate(padding),
          ),
        ),
      ),
    );
  }
}
