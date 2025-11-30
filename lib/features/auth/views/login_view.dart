import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:untitled/core/constants/app_colors.dart';
import 'package:untitled/features/auth/views/signup_view.dart';
import 'package:untitled/root.dart';
import 'package:untitled/shared/custom_txtfield.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_snack.dart';
import '../../../shared/custom_text.dart';
import '../data/auth_repo.dart';
import '../widget/custom_btn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String routeName = "login";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "hhhh@gmail.com");
  final passController = TextEditingController(text: "123456789");
  final authRepo = AuthRepo();

  // ValueNotifier لتحسين الأداء بدل setState
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  static final RegExp emailRegex =
  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // 🔥 Login
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoadingNotifier.value = true;

    try {
      final user = await authRepo.login(
        emailController.text.trim(),
        passController.text.trim(),
      );

      if (user != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            
            content: Text("Login successfully!",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (c) => const Root()),
        );
      }
    } catch (e) {
      final errorMessage = e is ApiError ? e.message : e.toString();
      showErrorBanner(context, errorMessage);
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    isLoadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: h * 0.2),
              SvgPicture.asset(
                "assets/image/svg/hungry.svg",
                height: h * 0.15,
              ),
              const Gap(8),
              const CustomText(
                text: 'Welcome Back Please sign in to continue',
                color: Colors.white70,
                size: 13,
                weight: FontWeight.w500,
              ),
              SizedBox(height: h * 0.1),
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
                    Gap(h * 0.03),
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
                    Gap(h * 0.07),
                    // Login Button
                    ValueListenableBuilder<bool>(
                      valueListenable: isLoadingNotifier,
                      builder: (_, isLoading, __) => isLoading
                          ? CupertinoActivityIndicator(
                          color: AppColors.primary, radius: 18)
                          : CustomAuthBtn(
                        text: 'Login',
                        color: AppColors.primary,
                        textColor: Colors.white,
                        onTap: login,
                      ),
                    ),
                    Gap(h * 0.05),
                    // Redirect to Signup
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
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
