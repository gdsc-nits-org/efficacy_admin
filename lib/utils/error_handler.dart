import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';

class ErrorHandler {
  const ErrorHandler._();

  static void _errorBuilder() {
    Widget error = const Text("Unknown build error...");
    ErrorWidget.builder = (errorDetails) {
      // debugPrint(errorDetails.toString());
      return Material(
        child: Scaffold(
          body: Center(
            child: error,
          ),
        ),
      );
    };
  }

  static void _flutterErrorBuilder(BuildContext context) {
    FlutterError.onError = (FlutterErrorDetails details) {
      // debugPrint(details.exception.toString());

      /// TODO: Improvise required
      /// The message should not always render what it gets as sometimes it might be too large
      /// Added a maximum size for error message after which it will be truncated
      String errorMessage = details.exception.toString();
      int maxSize = 100;
      if (errorMessage.length > maxSize) {
        errorMessage =
            "${details.toStringShort()}:\nPlease contact us if error continues.....";
      }
      showErrorSnackBar(context, errorMessage);
    };
  }

  static void _platformErrorBuilder(BuildContext context) {
    // Widget error = const Text("Unknown platform error...");
    PlatformDispatcher.instance.onError = (obj, stack) {
      // debugPrint(obj.toString());
      // debugPrintStack(stackTrace: stack);

      late String errorMessage;
      if (Platform.isAndroid) {
        errorMessage = 'This feature is not available on Android.';
      } else if (Platform.isIOS) {
        errorMessage = 'This feature is not available on iOS.';
      } else if (Platform.isMacOS) {
        errorMessage = 'This feature is not available on macOS.';
      } else if (Platform.isWindows) {
        errorMessage = 'This feature is not available on Windows.';
      } else if (Platform.isLinux) {
        errorMessage = 'This feature is not available on Linux.';
      } else {
        errorMessage = 'This feature is not supported on your platform.';
      }
      if (obj.toString().isNotEmpty) {
        if (obj.toString().contains("network_error")) {
          errorMessage = "Network Error";
        } else if (obj.toString().contains("sign_in_failed")) {
          errorMessage = "Sign in Failed";
        } else if (obj.toString().contains("Exception: Couldn't sign in")) {
          errorMessage = "Couldn't sign in";
        }
      }
      showErrorSnackBar(context, errorMessage);
      // error;
      return true;
    };
  }

  static Widget handle(BuildContext context, Widget? child) {
    // Currently commented due to infinite build error
    // TODO: If required fixed it
    // _errorBuilder();
    _flutterErrorBuilder(context);
    _platformErrorBuilder(context);

    if (child != null) return child;
    throw ('child is null');
  }
}
