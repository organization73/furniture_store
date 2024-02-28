import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/images/circular_image.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:iconsax/iconsax.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.onPress,
  });
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircularImage(
        imageUrl: TImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        'data',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Text(
        'data@gmail.com',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: IconButton(onPressed: onPress, icon: const Icon(Iconsax.edit)),
    );
  }
}
