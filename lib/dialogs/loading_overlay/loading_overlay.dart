import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

Future<void> showLoadingOverlay(
    {required BuildContext parentContext,
    ValueNotifier<bool>? isVisible,
    void Function()? onCompleted,
    Future Function()? asyncTask}) async {
  isVisible ??= ValueNotifier(true);
  Navigator.push(
    parentContext,
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black12,
      pageBuilder: (context, _, __) {
        return Theme(
          data: lightTheme,
          child: PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) {
                return;
              }
            },
            child: ValueListenableBuilder<bool>(
                valueListenable: isVisible!,
                builder: (BuildContext context, visible, Widget? child) {
                  if (!visible) {
                    SchedulerBinding.instance
                        .scheduleFrameCallback((_) => Navigator.pop(context));
                  }
                  return const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
          ),
        );
      },
    ),
  ).then((value) {
    if (onCompleted != null) {
      onCompleted();
    }
  });
  if (asyncTask != null) {
    try {
      await asyncTask();
    } catch (e) {
      rethrow;
    } finally {
      isVisible.value = false;
    }
  }
}
