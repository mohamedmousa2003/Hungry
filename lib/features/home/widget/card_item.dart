import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.rate,
  });

  final String image, text, desc, rate;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                image,
                width: 130,
                height: 135,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: 130,
                    height: 135,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },

                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: 130,
                    height: 135,
                    child: const Icon(
                      Icons.broken_image,
                      size: 45,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
            Gap(mediaQuery.height*0.01),
            CustomText(
              text: text,
              weight: FontWeight.bold,
              size: 18,
              color: AppColors.primary,
            ),
            CustomText(
              text: desc,
              size: 14,
              color: Colors.black54,
            ),
            Gap(mediaQuery.height*0.01),
            Row(
              children: [
                Icon(
                  CupertinoIcons.star_fill,
                  size: 20,
                  color: Colors.yellow.shade500,
                ),
                Gap(6),
                CustomText(
                  text: rate,
                  size: 20,
                  weight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                Spacer(),
                Icon(
                  CupertinoIcons.heart,
                  color: AppColors.primary,
                  size: 20,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
