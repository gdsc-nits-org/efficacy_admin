import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Efficacy",
        style: TextStyle(
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
        Stack(
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
            // TODO : Integrate with backend
            true
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

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
