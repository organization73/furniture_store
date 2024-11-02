import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/modules/ai/controllers/generative_ai/generative_ai_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
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
  final String apiKey = 'aiAPIKey';
  final ImageAIStyle imageAIStyle = ImageAIStyle.christmas;
  bool run = false;

  Future<Uint8List> _generate(String query) async {
    Uint8List image = await _ai.generateImage(
      apiKey: apiKey,
      imageAIStyle: imageAIStyle,
      prompt: query,
    );
    return image;
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
          ],
        ),
      ),
    );
  }
}
