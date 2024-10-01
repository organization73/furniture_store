import 'package:decordashapp/common/widgets/input_fields/custom_text_form_field.dart';
import 'package:decordashapp/modules/chat/controllers/chat_users_search.dart';
import 'package:decordashapp/modules/chat/widgets/user_item.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class UsersSearchScreen extends StatelessWidget {
  const UsersSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchUsersController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Users',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                controller: controller.searchNaemController,
                hint: 'Search',
                onChanged: (val) => controller.searchUser(val),
                prefixIcon: IconsaxPlusLinear.search_normal,
              ),
              Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.pagePaddingSpace),
                  shrinkWrap: true,
                  itemCount: controller.search.length,
                  itemBuilder: (context, index) =>
                      controller.search[index].id !=
                              FirebaseAuth.instance.currentUser?.uid
                          ? UserItem(user: controller.search[index])
                          : const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
