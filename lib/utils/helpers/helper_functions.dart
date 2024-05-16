import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class THelperFunctions {
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

Future<void> requestAllPermissions(BuildContext context) async {
  // Define the permissions you want to request
  List<Permission> permissions = [
    Permission.camera,
    Permission.location,
    Permission.storage,
    // Add other permissions as needed
  ];

  // Request all permissions
  Map<Permission, PermissionStatus> statuses = await permissions.request();

  // Show a toast message for each permission status
  statuses.forEach((permission, status) {
    String message = ''; // Initialize the message variable

    if (status.isGranted) {
      message = '$permission granted';
    } else if (status.isDenied) {
      message = '$permission denied';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            message,
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
          action: SnackBarAction(
            textColor: Theme.of(context).colorScheme.onError,
            label: 'open settings',
            onPressed: () {
              openAppSettings();
            },
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      message = '$permission permanently denied';
      // You can open the app settings so the user can grant the permission
      openAppSettings();
    } else if (status.isRestricted) {
      message = '$permission restricted';
    }
  });
}
