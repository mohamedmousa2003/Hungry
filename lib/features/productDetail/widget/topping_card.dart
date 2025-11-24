import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onAdd;
  final Color color;

  const ToppingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onAdd,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 130,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff3C2F2F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Gap(35), // بدل MediaQuery — ثابت وأفضل أداء
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: title,
                        color: Colors.white,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: onAdd,
                      child: CircleAvatar(
                        radius: 15,
                          backgroundColor: AppColors.primary,
                          child: const Icon(CupertinoIcons.add, size: 22,color: Colors.white,)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: -40,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return SizedBox(
                    width: 110,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 110,
                    height: 50,
                    child: Icon(Icons.broken_image, size: 30, color: Colors.red),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
