import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:decordash/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/helpers/helper_functions.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(
                backgroungColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              ),
            ),
            Positioned(
              top: 50,
              right: -300,
              child: CircularContainer(
                backgroungColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              ),
            ),
            Positioned(
              top: 50,
              right: 300,
              child: CircularContainer(
                backgroungColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
