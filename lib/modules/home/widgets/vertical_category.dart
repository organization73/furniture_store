import 'package:decordashapp/common/widgets/images/rounded_image.dart';
import 'package:decordashapp/modules/rooms/models/rooms_model.dart';
import 'package:flutter/material.dart';

class RoomCategoryCard extends StatelessWidget {
  const RoomCategoryCard({super.key, required this.room});
  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Stack(children: [
        RoundedImage(
          imageUrl: room.image,
          isNetworkImage: true,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(room.name,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryFixed,
                  )),
        ),
      ]),
    );
  }
}
