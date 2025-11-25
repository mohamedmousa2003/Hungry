import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:untitled/features/auth/views/login_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_txtfield.dart';
import '../widget/custom_btn.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});
  static const String routeName = "register";

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RegExp nameRegex = RegExp(r"^[a-zA-Z\u0621-\u064A\s]{3,}$");
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void dispose() {
    nameController.dispose();
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(size.height * 0.1),

                SvgPicture.asset("assets/image/svg/hungry.svg"),

                const Gap(8),

                CustomText(
                  text: 'Register now',
                  color: Colors.grey.shade400,
                  size: 18,
                  weight: FontWeight.w500,
                ),

                Gap(size.height * 0.08),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 45),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Name Field
                      CustomTextField(
                        controller: nameController,
                        hint: 'Name',
                        onValidate: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name cannot be empty";
                          }
                          if (!nameRegex.hasMatch(value)) {
                            return "Name must be letters only (min 3 chars)";
                          }
                          return null;
                        },
                      ),

                      Gap(size.height * 0.03),

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

                      // Register Button
                      CustomAuthBtn(
                        text: 'Register',
                        color: AppColors.primary,
                        textColor: Colors.white,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            print("REGISTER SUCCESS");
                          }
                        },
                      ),

                      Gap(size.height * 0.05),

                      // Login Redirect
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Already have an account? ",
                            color: Colors.grey.shade700,
                            size: 20,
                            weight: FontWeight.w500,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginView.routeName);
                            },
                            child: CustomText(
                              text: 'Login',
                              color: AppColors.primary,
                              size: 22,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
