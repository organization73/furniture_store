import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:furniture_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/helpers/helper_functions.dart';

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
        color: THelperFunctions.isDarkMode(context)
            ? TColors.black
            : TColors.lightContainer,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(
                backgroungColor: THelperFunctions.isDarkMode(context)
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            Positioned(
              top: 50,
              right: -300,
              child: CircularContainer(
                backgroungColor: THelperFunctions.isDarkMode(context)
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            Positioned(
              top: 50,
              right: 300,
              child: CircularContainer(
                backgroungColor: THelperFunctions.isDarkMode(context)
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
