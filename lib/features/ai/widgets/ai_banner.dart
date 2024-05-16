import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/features/ai/controllers/generative_ai/generative_ai_controller.dart';

import 'package:get/get.dart';

class AiInfoCard extends StatelessWidget {
  final String title;
  final Function() onMoreTap;

  final Widget subIcon;

  const AiInfoCard(
      {required this.title,
      required this.onMoreTap,
      required this.subIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              offset: const Offset(0, 10),
              blurRadius: 40,
              spreadRadius: 2,
            )
          ],
          gradient: const LinearGradient(
            colors: [Color.fromARGB(255, 59, 111, 255), Color(0xff3F6FEA)],
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Row(
                  children: [
                    subIcon,
                    SizedBox(width: 10.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${BalanceController.instance.balance.value.toInt()}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
