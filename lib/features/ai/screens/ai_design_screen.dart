import 'dart:typed_data';

import 'package:decordash/common/widgets/buttons/cta_button.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/utils/constants/api_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/features/ai/widgets/ai_banner.dart';
import 'package:decordash/common/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:decordash/features/ai/controllers/generative_ai/generative_ai_controller.dart';
import 'package:decordash/features/ai/widgets/generative_image.dart';
import 'package:decordash/features/ai/model/generative_ai/balance_model.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final StabilityAI _ai = StabilityAI();
  final String apiKey = aiAPIKey; // Replace with your actual API key
  final ImageAIStyle imageAIStyle = ImageAIStyle.christmas;
  bool run = false;
  Map<String, String> imageData = {};

  Uint8List? _imageBytes; // Variable to hold the image bytes
  Future<Uint8List> _generate(String query) async {
    Uint8List image = await _ai.generateImage(
      apiKey: apiKey,
      imageAIStyle: imageAIStyle,
      prompt: query,
    );
    // Upload the image to Firebase Storage
    const String imageName =
        'image.jpg'; // Replace with your desired image name
    final Reference storageRef =
        FirebaseStorage.instance.ref().child(imageName);
    final UploadTask uploadTask = storageRef.putData(image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    // Get the image URL
    query = query.substring(0, 7);
    query = query[0].toUpperCase();
    imageData['prompt'] = query;
    imageData['imageUrl'] = await taskSnapshot.ref.getDownloadURL();
    return image;
  }

  late TextEditingController aiDescriptionController;
  final BalanceModel balanceModel = BalanceModel();

  // Define the options for each dropdown
  final List<String> _classes = [
    'Seating',
    'Tables',
    'Storage',
    'Beds',
    'Desks'
  ];
  final Map<String, List<String>> _subClasses = {
    'Seating': ['Sofas', 'Chairs', 'Benches'],
    'Tables': ['Dining Tables', 'Coffee Tables', 'Side Tables'],
    'Storage': ['Cabinets', 'Shelves', 'Wardrobes'],
    'Beds': ['Single Beds', 'Double Beds', 'Bunk Beds'],
    'Desks': ['Office Desks', 'Writing Desks', 'Standing Desks'],
  };

  final Map<String, List<String>> _objects = {
    'Sofas': ['Sectional Sofa', 'Sleeper Sofa', 'Reclining Sofa'],
    'Chairs': ['Regular Chair', 'Swivel Chair', 'Lounge Chair'],
    'Benches': ['Storage Bench', 'Entryway Bench', 'Upholstered Bench'],
    'Dining Tables': [
      'Round Dining Table',
      'Rectangular Dining Table',
      'Extendable Dining Table'
    ],
    'Coffee Tables': [
      'Lift-Top Coffee Table',
      'Nesting Coffee Table',
      'Ottoman Coffee Table'
    ],
    'Side Tables': ['End Table', 'C-Shaped Table', 'Tray Table'],
    'Cabinets': ['Display Cabinet', 'Storage Cabinet', 'Media Cabinet'],
    'Shelves': ['Wall Shelf', 'Bookcase', 'Floating Shelf'],
    'Wardrobes': ['Freestanding Wardrobe', 'Built-In Wardrobe', 'Armoire'],
    'Single Beds': ['Twin Bed', 'Daybed', 'Loft Bed'],
    'Double Beds': ['Queen Bed', 'King Bed', 'Double Bed'],
    'Bunk Beds': [
      'Twin over Twin Bunk Bed',
      'Twin over Full Bunk Bed',
      'Triple Bunk Bed'
    ],
    'Office Desks': ['Executive Desk', 'Computer Desk', 'L-Shaped Desk'],
    'Writing Desks': ['Secretary Desk', 'Roll-Top Desk', 'Writing Table'],
    'Standing Desks': [
      'Adjustable Standing Desk',
      'Fixed Standing Desk',
      'Treadmill Desk'
    ],
  };

  final List<String> _colors = [
    'Red',
    'Blue',
    'Green',
    'Black',
    'White',
    'Yellow',
    'Purple',
    'Orange',
    'Pink',
    'Brown',
    'Gray',
    'Cyan',
    'Teal',
    'Maroon',
  ];

  final List<String> _sizes = [
    'Classic',
    'Modern',
    'Contemporary',
    'Industrial',
    'Scandinavian',
    'Rustic',
  ];
  final List<String> _materials = [
    'Wood',
    'Metal',
    'Glass',
    'Plastic',
    'Fabric'
  ];

  String? _selectedClass;
  String? _selectedSubClass;
  String? _selectedObject;
  String? _selectedColor;
  String? _selectedSize;
  String? _selectedMaterial;

  @override
  void initState() {
    super.initState();
    aiDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    aiDescriptionController.dispose();
    super.dispose();
  }

  // Generates the prompt based on current selections
  String _generatePrompt() {
    final classText = _selectedClass ?? '';
    final subClassText = _selectedSubClass ?? '';
    final objectText = _selectedObject ?? '';
    final colorText = _selectedColor ?? '';
    final sizeText = _selectedSize ?? '';
    final materialText = _selectedMaterial ?? '';
    return 'Create a $sizeText $colorText $materialText $objectText for $subClassText under the $classText category.';
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BalanceController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'aiDesigns'.tr,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AiInfoCard(
                  title: 'myPoints'.tr,
                  onMoreTap: () {},
                  subIcon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 59, 111, 255),
                          Color(0xff3F6FEA)
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Icon(
                      Iconsax.buy_crypto_copy,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                // Display the class options as circular chips
                const Text(
                  'Class',
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 8.0,
                  children: _classes.map((className) {
                    return ChoiceChip(
                      label: Text(className),
                      selected: _selectedClass == className,
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey[300],
                      labelStyle: TextStyle(
                        color: _selectedClass == className
                            ? Colors.white
                            : Colors.black,
                      ),
                      onSelected: (isSelected) {
                        if (isSelected) {
                          setState(() {
                            _selectedClass = className;
                            _selectedSubClass = _subClasses[className]?.first;
                            _selectedObject = null;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                // Display the sub-class options as circular chips
                const Text(
                  'Sub-Class',
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 8.0,
                  children: _selectedClass != null
                      ? (_subClasses[_selectedClass!] ?? [])
                          .map((subClassName) {
                          return ChoiceChip(
                            label: Text(subClassName),
                            selected: _selectedSubClass == subClassName,
                            selectedColor: Colors.blue,
                            backgroundColor: Colors.grey[300],
                            labelStyle: TextStyle(
                              color: _selectedSubClass == subClassName
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            onSelected: (isSelected) {
                              if (isSelected) {
                                setState(() {
                                  _selectedSubClass = subClassName;
                                  _selectedObject = null;
                                });
                              }
                            },
                          );
                        }).toList()
                      : [],
                ),
                SizedBox(
                  height: 20.h,
                ),
                // Display the object options as circular chips
                const Text(
                  'Object',
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 8.0,
                  children: _selectedSubClass != null
                      ? (_objects[_selectedSubClass!] ?? []).map((objectName) {
                          return ChoiceChip(
                            label: Text(objectName),
                            selected: _selectedObject == objectName,
                            selectedColor: Colors.blue,
                            backgroundColor: Colors.grey[300],
                            labelStyle: TextStyle(
                              color: _selectedObject == objectName
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            onSelected: (isSelected) {
                              if (isSelected) {
                                setState(() {
                                  _selectedObject = objectName;
                                });
                              }
                            },
                          );
                        }).toList()
                      : [],
                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                BuildDropDown(
                  title: "Color",
                  items: _colors,
                  onItemSelected: (selectedColor) {
                    setState(() {
                      _selectedColor = selectedColor;
                    });
                  },
                  hintText: 'Select Color',
                  isColorDropDown: true,
                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                BuildDropDown(
                  title: "Style",
                  items: _sizes,
                  onItemSelected: (selectedSize) {
                    setState(() {
                      _selectedSize = selectedSize;
                    });
                  },
                  hintText: 'Select Style',
                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                BuildDropDown(
                  title: "Material",
                  items: _materials,
                  onItemSelected: (selectedMaterial) {
                    setState(() {
                      _selectedMaterial = selectedMaterial;
                    });
                  },
                  hintText: 'Select Material',
                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                SizedBox(
                  child: run
                      ? SizedBox(
                          width: 400.w,
                          height: 400.w,
                          child: Center(
                            child: FutureBuilder<Uint8List>(
                              future: _generate(_generatePrompt()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  run = false;
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium);
                                } else if (snapshot.hasData) {
                                  _imageBytes = snapshot.data!;
                                  BalanceController.instance.fetchBalance();

                                  return Image.memory(snapshot.data!);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                        )
                      : Center(
                          child: Text('promptDesc'.tr,
                              style: Theme.of(context).textTheme.labelMedium),
                        ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                BuildCTAButton(
                  text: 'createDesign'.tr,
                  onPressed: () {
                    if (_selectedClass == null ||
                        _selectedSubClass == null ||
                        _selectedObject == null ||
                        _selectedColor == null ||
                        _selectedSize == null ||
                        _selectedMaterial == null) {
                      TLoaders.warningSnackBar(
                          title: "All fields are required");
                      return;
                    }
                    // Continue with the rest of the code

                    print(_generatePrompt());
                    String query = _generatePrompt();
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
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                BuildCTAButton(
                  text: "Add to manufacturing orders",
                  onPressed: () {
                    if (imageData['imageUrl'] == null ||
                        imageData['prompt'] == null) {
                      TLoaders.warningSnackBar(title: "Create Design First");
                      return;
                    }
                  },
                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildDropDown extends StatelessWidget {
  final String title;
  final List<String> items;
  final void Function(String) onItemSelected;
  final String hintText;
  final bool isColorDropDown; // Added flag for color dropdown

  const BuildDropDown({
    super.key,
    required this.title,
    required this.items,
    required this.onItemSelected,
    required this.hintText,
    this.isColorDropDown = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) {
        final color = isColorDropDown ? _getColor(item) : Colors.transparent;
        return DropdownMenuItem<String>(
          value: item,
          child: isColorDropDown
              ? Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(item),
                  ],
                )
              : Text(item),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onItemSelected(value);
        }
      },
      hint: Text(hintText),
    );
  }

  Color _getColor(String colorName) {
    switch (colorName) {
      case 'Red':
        return Colors.red;
      case 'Blue':
        return Colors.blue;
      case 'Green':
        return Colors.green;
      case 'Black':
        return Colors.black;
      case 'White':
        return Colors.white;
      case 'Yellow':
        return Colors.yellow;
      case 'Purple':
        return Colors.purple;
      case 'Orange':
        return Colors.orange;
      case 'Pink':
        return Colors.pink;
      case 'Brown':
        return Colors.brown;
      case 'Gray':
        return Colors.grey;
      case 'Cyan':
        return Colors.cyan;
      case 'Teal':
        return Colors.teal;
      case 'Maroon':
        return const Color.fromARGB(255, 97, 7, 0);
      default:
        return Colors.black;
    }
  }
}
