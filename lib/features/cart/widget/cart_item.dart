import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';
class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    this.onAdd,
    this.onMin,
    this.onRemove,
    required this.isLoading,
    required this.number,
  });

  final String image, text, desc;
  final Function()? onAdd;
  final Function()? onMin;
  final Function()? onRemove;
  final int number;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
      child: Card(
        shadowColor: Colors.grey,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الصورة
              SizedBox(
                width: 90,
                height: 90,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),

              const SizedBox(width: 10),

              // النصوص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: text,
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      text: desc,
                      size: 15,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // التحكم بالكمية والازالة
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onAdd,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primary,
                          child: const Icon(CupertinoIcons.add, color: Colors.white, size: 20),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomText(text: number.toString(), weight: FontWeight.bold, size: 22),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: onMin,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primary,
                          child: const Icon(CupertinoIcons.minus, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child:
                        isLoading  ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        ):
                        const CustomText(
                          text: 'Remove',
                          color: Colors.white,
                          size: 21,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
