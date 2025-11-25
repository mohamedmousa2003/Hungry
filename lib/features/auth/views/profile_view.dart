import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:untitled/features/auth/views/login_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../root.dart';
import '../../../shared/custom_text.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.9),
                  builder: (_) {
                    return GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Center(
                        child: InteractiveViewer(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              "assets/image/mohamed.jpg",
                              fit: BoxFit.cover,
                              height: 300,
                              width: 300,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(width: 2, color: AppColors.primary),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  "assets/image/mohamed.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),


            // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: Container(
                //     padding: EdgeInsets.all(6),
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: AppColors.primary,
                //     ),
                //     child: Icon(
                //       Icons.edit,
                //       color: Colors.white,
                //       size: 18,
                //     ),
                //   ),
                // ),


            Gap(mediaQuery.height * 0.01),

            // ---------------------- Name + Email ----------------------


            CustomText(
              text: "Mohamed Mousa",
              color: AppColors.primary,
              size: 22,
              weight: FontWeight.bold,
            ),
            Gap(mediaQuery.height * 0.001),
            CustomText(
              text:  "mohamed@gmail.com",
              color:Colors.grey.shade600,
              size: 18,
              weight: FontWeight.w500,
            ),

            Gap(mediaQuery.height * 0.02),

            ProfileCard(
              icon: Icons.person_outline,
              title: "Edit Profile",
              onTap: () {},
            ),

            // ProfileCard(
            //   icon: Icons.shopping_bag_outlined,
            //   title: "My Orders",
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, Root.routeName);
            //   },
            // ),

            ProfileCard(
              icon: Icons.notifications_none,
              title: "Notifications",
              onTap: () {},
            ),

            ProfileCard(
              icon: Icons.logout,
              title: "Logout",
              iconColor: Colors.red,
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              },
            ),

            Gap(mediaQuery.height * 0.15),
          ],
        ),
      ),
    );
  }
}

// ---------------------- Reusable Profile Card ----------------------
class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;
  final VoidCallback onTap;

  const ProfileCard({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 26, color: iconColor ?? AppColors.primary),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
