import 'dart:math';

import 'package:efficacy_admin/states/authenticator/authenticator.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_admin/config/config.dart';
import 'package:native_flutter_proxy/custom_proxy.dart';
import 'package:native_flutter_proxy/native_proxy_reader.dart';

// Checks for proxy
// Only works for proxy set natively in the android settings and not through external apps like College proxy
void checkProxy(BuildContext context) async {
  bool enabled = false;
  String? host;
  int? port;
  try {
    ProxySetting settings = await NativeProxyReader.proxySetting;
    enabled = settings.enabled;
    host = settings.host;
    port = settings.port;
    // debugPrint("$enabled $host $port");
  } catch (e) {
    debugPrint("$e");
  }
  if (enabled && host != null) {
    final proxy = CustomProxy(ipAddress: host, port: port);
    proxy.enable();
    // debugPrint("proxy enabled");
    showSnackBar(context, "Proxy Enabled\nHost: $host\nPort: $port");
  }
}

// class GoogleSignInButton extends StatelessWidget {
//   const GoogleSignInButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Center(
//       child: SizedBox(
//         width: min(250, size.width * 0.8),
//         child: OutlinedButton(
//           onPressed: () {
//             checkProxy(context);
//             Authenticator.googleSignIn();
//           },
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Image.asset(
//                 Assets.googleLogoImagePath,
//                 height: 40,
//               ),
//               Text(
//                 "Sign In with Google",
//                 style: Theme.of(context).textTheme.labelLarge,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
