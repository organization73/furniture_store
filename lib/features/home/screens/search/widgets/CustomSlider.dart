import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double slider = 30;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Cooking Duration",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              "( in minutes )",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "< 10",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.blue),
                  ),
                  Text(
                    "30",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.blue),
                  ),
                  Text(
                    "> 50",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.blue),
                  ),
                ],
              ),
            ),
            Slider(
                divisions: 2,
                activeColor: Colors.blue,
                thumbColor: Colors.blue,
                max: 60,
                min: 10,
                value: slider,
                onChanged: (value) {
                  setState(() {
                    slider = value;
                  });
                })
          ],
        )
      ],
    );
  }
}
