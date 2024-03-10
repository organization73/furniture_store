import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/headings/section_heading.dart';

class BuildSectionDescription extends StatelessWidget {
  final String sectionName;
  final String sectionDesc;
  const BuildSectionDescription(
      {required this.sectionName, required this.sectionDesc, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeading(
          title: sectionName,
          showActionButton: false,
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          sectionDesc,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
