import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/all_galleries_section.dart';

class AllGalleriesPage extends StatelessWidget {
  const AllGalleriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'All Galleries',
        ),
      ),
      body: SafeArea(
          child: Container(
        width: ScreenUtil().screenWidth,
        decoration: const BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: const BuildGalleriesList(),
      )),
    );
  }
}
