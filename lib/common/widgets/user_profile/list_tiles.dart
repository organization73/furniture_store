import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String text;
  final Widget trailingIcon;
  final Function() onTap;
  final Color color;
  const SettingTile(
      {required this.text,
      required this.trailingIcon,
      required this.onTap,
      this.color = Colors.black,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      textColor: color,
      iconColor: color,
      child: ListTile(
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: trailingIcon,
        selected: false,
        onTap: onTap,
      ),
    );
  }
}
