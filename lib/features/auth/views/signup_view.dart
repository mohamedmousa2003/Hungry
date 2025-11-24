import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_txtfield.dart';
import '../widget/custom_btn.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                  text: 'Welcome to our Food App',
                  color: Colors.white70,
                  size: 13,
                  weight: FontWeight.w500,
                ),
                Gap(mediaQuery.height*0.2),
                CustomTextFormField(
                  controller: nameController,
                  hint: 'Name',
                  isPassword: false,
                ),
                Gap(mediaQuery.height*0.03),
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
                CustomAuthBtn(
                  text: 'Register',
                  color: Colors.transparent,
                  textColor: Colors.white,
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
