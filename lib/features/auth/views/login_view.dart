import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:untitled/core/constants/app_colors.dart';
import 'package:untitled/shared/custom_txtfield.dart';

import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'Sonic3@gmail.com');
  final passController = TextEditingController(text: '123456789');
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(mediaQuery.height*0.1),
                SvgPicture.asset("assets/image/svg/hungry.svg"),
                Gap(mediaQuery.height*0.01),
                const CustomText(
                  text: 'Welcome Back, Discover The Fast Food',
                  color: Colors.white70,
                  size: 13,
                  weight: FontWeight.w500,
                ),
                Gap(mediaQuery.height*0.2),
                CustomTextFormField(
                  controller: emailController,
                  hint: 'Email Address',
                  isPassword: false,
                ),
                Gap(mediaQuery.height*0.03),
                CustomTextFormField(
                  controller: passController,
                  hint: 'Password',
                  isPassword: true,
                ),
                Gap(mediaQuery.height*0.07),
                CustomButton(
                  height: 45,
                  gap: 10,
                  text: 'Login',
                  color: Colors.white.withOpacity(0.9),
                  textColor: AppColors.primary,
                  onTap: (){
                    if(formKey.currentState!.validate()){

                      print("LOGIN");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
