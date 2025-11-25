import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:untitled/core/constants/app_colors.dart';
import 'package:untitled/features/auth/views/signup_view.dart';
import 'package:untitled/root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName="splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));


    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SignUpView()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          children: [
            Gap(mediaQuery.height * 0.25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SvgPicture.asset(
                    "assets/image/svg/hungry.svg",
                    height: 140,
                  ),
                ),
              ),
            ),

            const Spacer(),

            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                "assets/image/png/logo.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
