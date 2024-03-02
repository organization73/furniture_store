import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/user_profile/profile_widget.dart';
import 'package:furniture_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Column(
            children: [
              ProfileWidget(
                imagePath: '',
                onClicked: () {},
              ),
              SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const SectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              ProfileMenu(
                title: 'Name',
                value: 'Coding',
                onPress: () {},
              ),
              ProfileMenu(
                title: 'Username',
                value: 'eee',
                onPress: () {},
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const SectionHeading(
                title: 'Account Information',
                showActionButton: false,
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              ProfileMenu(
                title: 'E-mail',
                value: 'Coding@gmail.com',
                onPress: () {},
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: '01022336699',
                onPress: () {},
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
