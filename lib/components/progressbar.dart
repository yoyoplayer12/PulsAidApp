import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';

class DotProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const DotProgressBar({super.key, required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(totalSteps, (index) {
          return Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index < currentStep ? BrandColors.primaryGreen : null,
              border: Border.all(
                color: index < currentStep ? BrandColors.primaryGreenExtraLight : BrandColors.greyExtraLight.withOpacity(0.48),
                width: 2,
              ),
            ),
          );
        }),
      ),
    );
  }
}
