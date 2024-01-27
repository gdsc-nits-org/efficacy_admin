import 'package:efficacy_admin/config/configurations/assets/assets.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget> actions;
  final GlobalKey? drawerKey;
  const CustomAppBar({
    super.key,
    this.title,
    this.actions = const [],
    this.drawerKey,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late bool pendingInvites = false;
  late String _displayedTitle;

  Future<void> init() async {
    pendingInvites = await InvitationController.anyPendingInvitation();
    if (pendingInvites) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
    _displayedTitle = widget.title ?? 'Efficacy';
    // _Button = widget.actionButton ?? const SizedBox.shrink();
  }

  void updateAppBar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //screen height and width
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    //size constants
    final double avatarRadius = width * 0.25;
    const double pad = 8.0;

    return AppBar(
      surfaceTintColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(pad),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          radius: avatarRadius,
          child: Image.asset(Assets.efficacyAdminLogoImagePath),
        ),
      ),
      title: Text(
        _displayedTitle,
        style: const TextStyle(
          color: Color(0xFF05354C),
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      // Removing the default back button
      automaticallyImplyLeading: false,
      // Editing the back button (back button not responsive on all pages due to navigation)
      // leading: const BackButton(
      //     style:
      //         ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent),)),
      actions: [
        ...widget.actions,
        Stack(
          key: widget.drawerKey,
          children: [
            // App drawer button
            IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
            ),
            // Notification bubble
            pendingInvites
                ? Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                    ),
                  )
                : Container()
          ],
        )
      ],
    );
  }
}
