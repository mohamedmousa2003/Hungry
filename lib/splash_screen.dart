import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:untitled/core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
   var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          children: [
            Gap(mediaQuery.height*0.3,),
            SvgPicture.asset("assets/image/svg/hungry.svg"),
            Spacer(),
            Image.asset("assets/image/png/logo.png"),
          ],
        ),
      ),
    );
  }
}
