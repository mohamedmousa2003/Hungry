import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:untitled/core/constants/app_colors.dart';
import 'package:untitled/features/auth/views/signup_view.dart';
import 'package:untitled/root.dart';
import 'package:untitled/shared/custom_txtfield.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
import '../widget/custom_btn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String routeName = "login";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: '');
  final passController = TextEditingController(text: '');

  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(size.height * 0.2),
              SvgPicture.asset("assets/image/svg/hungry.svg"),
              Gap(size.height * 0.01),
              const CustomText(
                text: 'Welcome Back Please sing in to continue',
                color: Colors.white70,
                size: 13,
                weight: FontWeight.w500,
              ),
              Gap(size.height * 0.1),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 8,right: 8, top: 45),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Email Field
                        CustomTextField(
                          controller: emailController,
                          hint: 'Email Address',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            }
                            if (!emailRegex.hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),

                        Gap(size.height * 0.03),

                        // Password Field
                        CustomTextField(
                          controller: passController,
                          hint: 'Password',
                          isPassword: true,
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),

                        Gap(size.height * 0.07),

                        // Login Button
                        CustomAuthBtn(
                          text: 'Login',
                          color: AppColors.primary,
                          textColor: Colors.white,
                          onTap: () {
                            Navigator.pushReplacementNamed(context, Root.routeName);
                            // if (formKey.currentState!.validate()) {
                            //   // return Navigator.pushReplacement(context, Root.routeName as Route<Object?>);
                            // }
                          },
                        ),

                        Gap(size.height * 0.05),

                        // Signup Redirect
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Don’t have an account? ",
                              color: Colors.grey.shade700,
                              size: 18,
                              weight: FontWeight.w500,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, SignUpView.routeName);
                              },
                              child: CustomText(
                                text: 'Create Account ',
                                color: AppColors.primary,
                                size: 20,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
