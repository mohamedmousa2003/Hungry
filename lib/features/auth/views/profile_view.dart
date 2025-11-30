import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_snack.dart';
import '../../../shared/custom_text.dart';
import '../data/auth_repo.dart';
import '../data/user_model.dart';
import '../widget/custom_user_txt_field.dart';
import 'login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();

  bool isGuest = false;
  UserModel? userModel;
  String? selectedImage;
  bool isLoadingUpdate = false;
  bool isLoadingLogout = false;

  final AuthRepo authRepo = AuthRepo();

  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    await loadImageLocally();
    await autoLogin();
    await getProfileData();
  }

  /// Load saved image from SharedPreferences
  Future<void> loadImageLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');
    if (mounted) {
      setState(() {
        selectedImage = imagePath;
      });
    }
  }

  /// Save image path locally
  Future<void> saveImageLocally(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', path);
  }

  /// Remove saved image
  Future<void> removeImageLocally() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image'); // حذف الصورة من الجهاز
    setState(() {
      selectedImage = null;       // حذف الصورة الحالية
      if (userModel != null) {
        userModel!.image = null;  // منع ظهور صورة السيرفر بعد المسح
      }
    });

    // لو عندك API لحذف الصورة من السيرفر، استدعِها هنا
    // try {
    //   await authRepo.deleteProfileImage();
    // } catch (e) {
    //   print('Failed to delete image from server: $e');
    // }
  }

  /// Auto login check
  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    if (!mounted) return;
    setState(() {
      isGuest = authRepo.isGuest;
      if (user != null) userModel = user;
    });
  }

  /// Get profile
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      if (!mounted) return;
      setState(() {
        userModel = user;
        _name.text = userModel?.name ?? '';
        _email.text = userModel?.email ?? '';
        _address.text = userModel?.address ?? '';
      });
    } catch (e) {
      String errorMsg = 'Error in Profile';
      if (e is ApiError) errorMsg = e.message;
      showErrorBanner(context, errorMsg);
    }
  }

  /// Update profile
  Future<void> updateProfileData() async {
    try {
      setState(() => isLoadingUpdate = true);
      final user = await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        imagePath: selectedImage,
        visa: _visa.text.trim(),
      );
      if (!mounted) return;
      setState(() {
        userModel = user;
        isLoadingUpdate = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        customSnack('Profile updated Successfully'),
      );
      if (selectedImage != null) await saveImageLocally(selectedImage!);
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoadingUpdate = false);
      String errorMsg = 'Failed to update profile';
      if (e is ApiError) errorMsg = e.message;
      print(errorMsg);
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      setState(() => isLoadingLogout = true);
      await authRepo.logout();
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => LoginView()),
      );
      setState(() => isLoadingLogout = false);
    } catch (e) {
      setState(() => isLoadingLogout = false);
      print(e.toString());
    }
  }


  /// Pick image
  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null && mounted) {
      setState(() {
        selectedImage = pickedImage.path;
      });
      await saveImageLocally(selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isGuest) {
      return _guestView();
    }
    return _profileView();
  }

  Widget _guestView() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Guest Mode')),
          const Gap(20),
          CustomButton(
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (c) => const LoginView())),
            text: 'Go to Login',
          ),
        ],
      ),
    );
  }

  Widget _profileView() {
    return RefreshIndicator(
      displacement: 40,
      color: Colors.white,
      backgroundColor: AppColors.primary,
      onRefresh: getProfileData,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0.0,
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Skeletonizer(
                enabled: userModel == null,
                containersColor: AppColors.primary.withOpacity(0.3),
                child: Column(
                  children: [
                    const Gap(10),

                    /// Profile image
                    _profileImage(),

                    const Gap(10),

                    /// Upload / Remove buttons
                    _imageButtons(),

                    const Gap(20),

                    /// Form fields
                    CustomUserTxtField(controller: _name, label: 'Name'),
                    const Gap(25),
                    CustomUserTxtField(controller: _email, label: 'Email'),
                    const Gap(25),
                    CustomUserTxtField(controller: _address, label: 'Address'),
                    const Gap(20),
                    const Divider(),
                    const Gap(10),

                    /// Visa card
                    _visaCard(),

                    const Gap(5),

                    /// Buttons Edit / Logout
                    _actionButtons(),

                    const Gap(300),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: Colors.black),
        color: Colors.grey.shade300,
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          padding: const EdgeInsets.all(3),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: AppColors.primary),
              color: Colors.grey.shade100,
            ),
            clipBehavior: Clip.antiAlias,
            child: selectedImage != null
                ? Image.file(File(selectedImage!), fit: BoxFit.cover)
                : (userModel?.image != null && userModel!.image!.isNotEmpty)
                ? Image.network(
              userModel!.image!,
              fit: BoxFit.cover,
              errorBuilder: (context, err, stack) => const Icon(Icons.person),
            )
                : const Icon(Icons.person, size: 60),
          ),
        ),
      ),
    );
  }

  Widget _imageButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: pickImage,
          child: Card(
            elevation: 0.0,
            color: const Color.fromARGB(255, 6, 78, 13),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CustomText(
                      text: 'Upload',
                      weight: FontWeight.w500,
                      color: Colors.white,
                      size: 13),
                  Gap(10),
                  Icon(CupertinoIcons.camera, size: 17, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: removeImageLocally,
          child: Card(
            elevation: 0.0,
            color: const Color.fromARGB(255, 111, 2, 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CustomText(
                      text: 'Remove',
                      weight: FontWeight.w500,
                      color: Colors.white,
                      size: 13),
                  Gap(10),
                  Icon(CupertinoIcons.trash, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _visaCard() {
    if (userModel?.visa == null) {
      return CustomUserTxtField(
          controller: _visa,
          textInputType: TextInputType.number,
          label: 'Add VISA CARD');
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade900,
            Colors.blue.shade900,
            Colors.blue.shade500,
            Colors.blue.shade900
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset('assets/image/icon/visa.png', width: 45, color: Colors.white),
          const Gap(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'Debit Card', color: Colors.white, size: 14),
              CustomText(text: userModel?.visa ?? "**** **** **** 9857",
                  color: Colors.white, size: 12),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration:
            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: CustomText(
                text: 'Default', color: Colors.grey, size: 12, weight: FontWeight.w500),
          ),
          const Gap(8),
          const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.white),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: updateProfileData,
              child: Container(
                height: 50,
                decoration:
                BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                child: isLoadingUpdate
                    ? const CupertinoActivityIndicator(color: Colors.white)
                    : const Center(
                    child: CustomText(
                        text: 'Edit Profile',
                        weight: FontWeight.w600,
                        color: Colors.white,
                        size: 15)),
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: GestureDetector(
              onTap: logout,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: isLoadingLogout
                    ? CupertinoActivityIndicator(color: AppColors.primary)
                    : Center(
                    child: CustomText(
                        text: 'Logout',
                        weight: FontWeight.w600,
                        color: AppColors.primary)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
