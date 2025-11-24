import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final double value;
  final ValueChanged<double> onChanged;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/image/detail/sandwitch_detail.png",
          height: 160,
        ),

        const SizedBox(width: 15), // يمنع Overflow

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                const CustomText(
                  text: "Customize Your Burger\nTo Your Tastes\nUltimate Experience",
                ),

                const SizedBox(height: 12),

                Slider(
                  max: 100,
                  min: 0,
                  activeColor: AppColors.primary,
                  inactiveColor: Colors.grey,
                  value: widget.value,
                  onChanged: widget.onChanged,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      const CustomText(
                        text: 'Cold 🥶',
                        weight: FontWeight.bold,
                        size: 15,
                      ),
                      const Spacer(),
                      CustomText(
                        text: "${widget.value.toStringAsFixed(0)}",
                        weight: FontWeight.bold,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const Spacer(),
                      const CustomText(
                        text: '🌶️ Hot',
                        weight: FontWeight.bold,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
