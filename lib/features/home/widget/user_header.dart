import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

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
            const CustomText(
              text: 'Hello, Mohamed Mousa',
              color: Colors.grey,
              size: 15,
              weight: FontWeight.w500,
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(radius: 38,child: Icon(
          CupertinoIcons.person,
          size: 40,
          color: Colors.white,
        ),
          backgroundColor: AppColors.primary,
        ),
      ],
    );
  }
}
