import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key,required this.name,required this.image});
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/image/svg/hungry.svg",color: AppColors.primary,height: 35,),
            Gap(mediaQuery.height*0.01,),
            CustomText(
              text: 'Hello, ${name}',
              color: Colors.grey,
              size: 15,
              weight: FontWeight.w500,
            ),
          ],
        ),
        Spacer(),
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(width: 2, color: AppColors.primary),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            image, // <-- URL from API
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, color: Colors.red);
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),

      ],
    );
  }
}
