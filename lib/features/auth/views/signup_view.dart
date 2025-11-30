import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:untitled/features/auth/views/login_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../root.dart';
import '../../../shared/custom_snack.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_txtfield.dart';
import '../data/auth_repo.dart';
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

  static final RegExp nameRegex = RegExp(r"^[a-zA-Z\u0621-\u064A\s]{3,}$");
  static final RegExp emailRegex =
  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final AuthRepo authRepo = AuthRepo();
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  Future<void> signup() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoadingNotifier.value = true;
      log("Attempting signup with: ${nameController.text}, ${emailController.text}");
      final user = await authRepo.signup(
        nameController.text.trim(),
        emailController.text.trim(),
        passController.text.trim(),
      );
      log("Signup response: $user");

      if (user != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registered successfully!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (c) => const Root()),
        );
      }

    } catch (e) {
      final errMsg = e is ApiError ? e.message : 'Error in Register';
      if (mounted) showErrorBanner(context, errMsg);
      log("Signup error: $e");
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    isLoadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    // Precompute gaps
    final double gapSmall = h * 0.03;
    final double gapMedium = h * 0.07;
    final double gapLarge = h * 0.08;
    final double gapTop = h * 0.1;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: gapTop),
              SvgPicture.asset(
                "assets/image/svg/hungry.svg",
                width: 100,
                height: 100,
                allowDrawingOutsideViewBox: true,
              ),
              const Gap(8),
              CustomText(
                text: 'Register now',
                color: Colors.grey.shade400,
                size: 18,
                weight: FontWeight.w500,
              ),
              SizedBox(height: gapLarge),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 45),
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
                    SizedBox(height: gapSmall),
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
                    SizedBox(height: gapSmall),
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
                    SizedBox(height: gapMedium),
                    ValueListenableBuilder<bool>(
                      valueListenable: isLoadingNotifier,
                      builder: (_, isLoading, __) => isLoading
                          ? CupertinoActivityIndicator(
                          color: AppColors.primary, radius: 18)
                          : CustomAuthBtn(
                        text: 'Register',
                        color: AppColors.primary,
                        textColor: Colors.white,
                        onTap: signup,
                      ),
                    ),
                    SizedBox(height: gapMedium * 0.7),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
