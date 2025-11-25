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
    required this.number,
  });
  final String image , text , desc;
  final Function() ? onAdd;
  final Function() ? onMin;
  final Function() ? onRemove;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 13),
      child: Card(
        shadowColor: Colors.grey,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          )
        ),
        // clipBehavior: Clip.none,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(15),
            color: Colors.white
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(image, width: 90),
                  CustomText(text: text,weight: FontWeight.bold, size: 18,),
                  CustomText(text: desc, size: 15,weight: FontWeight.w500),
                ],
              ),

              Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onAdd,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primary,
                          child: Icon(CupertinoIcons.add, color: Colors.white, size: 20),
                        ),
                      ),
                      Gap(20),
                      CustomText(text: number.toString() ,weight: FontWeight.bold,size: 22),
                      Gap(20),
                      GestureDetector(
                        onTap: onMin,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primary,
                          child: Icon(CupertinoIcons.minus, color: Colors.white, size: 20,),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 22,vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: CustomText(text: 'Remove',color: Colors.white,size: 21,weight: FontWeight.bold,)),
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