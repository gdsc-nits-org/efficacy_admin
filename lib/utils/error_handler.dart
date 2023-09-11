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
            "${details.toStringShort()}:\n${details.exception.toString().substring(0, maxSize)}.....";
      }
      showErrorSnackBar(context, errorMessage);
    };
  }

  static void _platformErrorBuilder() {
    Widget error = const Text("Unknown platform error...");
    PlatformDispatcher.instance.onError = (obj, stack) {
      // debugPrint(obj.toString());
      // debugPrintStack(stackTrace: stack);
      error;
      return true;
    };
  }

  static Widget handle(BuildContext context, Widget? child) {
    // Currently commented due to infinite build error
    // TODO: If required fixed it
    // _errorBuilder();
    _flutterErrorBuilder(context);
    _platformErrorBuilder();

    if (child != null) return child;
    throw ('child is null');
  }
}
