import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';

class ErrorHandler {
  const ErrorHandler._();

  static void _errorBuilder() {
    Widget error = const Text("Unknown error...");
    ErrorWidget.builder = (errorDetails) => error;
  }

  static void _flutterErrorBuilder(BuildContext context) {
    FlutterError.onError = (FlutterErrorDetails details) {
      /// TODO: Improvise required
      /// The message should not always render what it gets as sometimes it might be too large
      final errorMessage = details.exception.toString();

      showErrorSnackBar(context, errorMessage);
    };
  }

  static void _platformErrorBuilder() {
    Widget error = const Text("Unknown platform error...");
    PlatformDispatcher.instance.onError = (_, stack) {
      error;
      return true;
    };
  }

  static Widget handle(BuildContext context, Widget? child) {
    _errorBuilder();
    _flutterErrorBuilder(context);
    _platformErrorBuilder();

    if (child != null) return child;
    throw ('child is null');
  }
}
