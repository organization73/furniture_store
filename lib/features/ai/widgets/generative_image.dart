import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/features/ai/controllers/generative_ai/generative_ai_controller.dart';
import 'package:decordashapp/utils/constants/api_constants.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:stability_image_generation/stability_image_generation.dart';

class ImageGenerator extends StatefulWidget {
  final TextEditingController descriptionController;
  const ImageGenerator({
    super.key,
    required this.descriptionController,
  });

  @override
  ImageGeneratorState createState() => ImageGeneratorState();
}

class ImageGeneratorState extends State<ImageGenerator> {
  final StabilityAI _ai = StabilityAI();
  final String apiKey = aiAPIKey; // Replace with your actual API key
  final ImageAIStyle imageAIStyle = ImageAIStyle.christmas;
  bool run = false;
  Uint8List? _imageBytes; // Variable to hold the image bytes

  Future<Uint8List> _generate(String query) async {
    Uint8List image = await _ai.generateImage(
      apiKey: apiKey,
      imageAIStyle: imageAIStyle,
      prompt: query,
    );
    return image;
  }

  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> ff(Uint8List imageBytes) async {
    if (await requestStoragePermission()) {
      // Proceed with downloading the image
      downloadImage(_imageBytes!);
    } else {
      if (mounted) {
        // Show a dialog explaining why the permission is needed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permission Required'),
            content: const Text(
                'This app requires storage permission to download images. Please enable it from the app settings.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings(); // Open the app settings page
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
      }
    }
  }

// TODO handle imahe download
  Future<void> downloadImage(Uint8List imageBytes) async {
    // // Request storage permissions
    // Map<Permission, PermissionStatus> statuses = await [
    //   Permission.storage,
    // ].request();

    // // Check if granted
    // if (statuses[Permission.storage]!.isGranted) {
    //   // Get the external storage directory
    //   Directory? externalDirectory = await getExternalStorageDirectory();
    //   if (externalDirectory != null) {
    //     // Create the Downloads directory if it doesn't exist
    //     Directory downloadsDirectory =
    //         Directory('${externalDirectory.path}/Download');
    //     if (!await downloadsDirectory.exists()) {
    //       await downloadsDirectory.create(recursive: true);
    //     }

    //     // Generate a unique filename
    //     String fileName =
    //         'GeneratedImage_${DateTime.now().millisecondsSinceEpoch}.png';

    //     // Write the image bytes to a file
    //     File imageFile = File('${downloadsDirectory.path}/$fileName');
    //     await imageFile.writeAsBytes(imageBytes);

    //     // Check if the widget is still mounted before showing a success message
    //     if (mounted) {
    //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //         content: Text('Image saved to Downloads folder.'),
    //         duration: Duration(seconds: 2),
    //       ));
    //     }
    //   } else {
    //     // Check if the widget is still mounted before showing an error message
    //     if (mounted) {
    //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //         content: Text('Unable to access external storage.'),
    //         duration: Duration(seconds: 2),
    //       ));
    //     }
    //   }
    // } else {
    //   // Check if the widget is still mounted before showing an error message
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text('Permission to access storage was denied.'),
    //       duration: Duration(seconds: 2),
    //     ));
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: run
                  ? FutureBuilder<Uint8List>(
                      future: _generate(widget.descriptionController.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}',
                              style: Theme.of(context).textTheme.labelMedium);
                        } else if (snapshot.hasData) {
                          _imageBytes = snapshot.data!;
                          BalanceController.instance.fetchBalance();

                          return Image.memory(snapshot.data!);
                        } else {
                          return Container();
                        }
                      },
                    )
                  : Center(
                      child: Text('promptDesc'.tr,
                          style: Theme.of(context).textTheme.labelMedium),
                    ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            BuildCTAButton(
              text: 'createDesign'.tr,
              onPressed: () {
                String query = widget.descriptionController.text;
                if (query.isNotEmpty) {
                  setState(() {
                    run = true;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    content: Text(
                      'promptVal'.tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onError),
                    ),
                    duration: const Duration(milliseconds: 2500),
                  ));
                }
              },
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            BuildCTAButton(
              text: 'downloadImage'.tr,
              onPressed: () {
                if (_imageBytes != null) {
                  // Call the downloadImage function with the stored image bytes
                  ff(_imageBytes!);
                } else {
                  // Show a message if there is no image to download
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('No image to download.'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
