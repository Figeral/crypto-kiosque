import 'package:flutter/material.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';

class SnackBarMessenger {
  stateSnackMessenger(
      {required BuildContext context,
      required String message,
      String? action,
      required String type}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            type == "error" ? Colors.redAccent.shade200 : AppColors.deepPurple,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        action: SnackBarAction(
          label: action ?? "cancel",
          onPressed: () {},
        ),
      ),
    );
  }
}

// enum ActionType { success, pending, error }
