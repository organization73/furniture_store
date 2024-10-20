import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AddRoomScreen extends StatelessWidget {
  const AddRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: EdgeInsets.all(TSizes.pagePaddingSpace),
          child: Text('room'),
        ),
        SizedBox(
          height: 10,
        )
      ]),
    );
  }
}
