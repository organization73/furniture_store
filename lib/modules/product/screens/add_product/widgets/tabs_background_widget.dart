import 'package:decordashapp/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:flutter/material.dart';

class TabBackground extends StatelessWidget {
  const TabBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Stack(
        children: [
          Positioned(
            top: -150,
            right: -250,
            child: CircularContainer(
              backgroungColor:
                  Theme.of(context).colorScheme.surfaceDim.withOpacity(0.4),
            ),
          ),
          Positioned(
            top: 50,
            right: -300,
            child: CircularContainer(
              backgroungColor:
                  Theme.of(context).colorScheme.surfaceDim.withOpacity(0.4),
            ),
          ),
          Positioned(
            top: 50,
            right: 300,
            child: CircularContainer(
              backgroungColor:
                  Theme.of(context).colorScheme.surfaceDim.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
