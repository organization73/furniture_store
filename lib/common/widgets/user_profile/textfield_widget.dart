import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  const TextFieldWidget({
    super.key,
    this.maxLines = 1,
    required this.label,
    required this.onChanged,
    this.controller,
  });

  @override
  TextFieldWidgetState createState() => TextFieldWidgetState();
}

class TextFieldWidgetState extends State<TextFieldWidget> {
  // late final TextEditingController controller;

  // @override
  // void initState() {
  //   super.initState();

  //   controller = TextEditingController(text: widget.text);
  // }

  // @override
  // void dispose() {
  //   controller.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 20.h),
          TextField(
            controller: widget.controller,
            maxLines: widget.maxLines,
          ),
        ],
      );
}
