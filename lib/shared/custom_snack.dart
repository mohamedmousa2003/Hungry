import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'custom_text.dart';

void showErrorBanner(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);

  // اخفاء أي Banner قديم
  messenger.hideCurrentMaterialBanner();

  // عرض Banner جديد
  messenger.showMaterialBanner(
    MaterialBanner(
      backgroundColor: Colors.red.shade400,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      leading: const Icon(
        CupertinoIcons.info,
        color: Colors.white,
      ),
      actions: [
        TextButton(
          onPressed: () => messenger.hideCurrentMaterialBanner(),
          child: const Text(
            "Close",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );

  // اغلاق تلقائي بعد 4 ثواني
  Future.delayed(const Duration(seconds: 4), () {
    messenger.hideCurrentMaterialBanner();
  });
}


SnackBar customSnack(errorMsg) {

  return SnackBar(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.red.shade900,
    content: FittedBox(
      child: Row(
        children: [
          const Icon(CupertinoIcons.info, color: Colors.white),
          Gap(14),
          CustomText(
            text: errorMsg,
            color: Colors.white,
            size: 10,
            weight: FontWeight.w600,
          ),
        ],
      ),
    ),
  );
}

/*




  void showErrorBanner(String message) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentMaterialBanner();

    messenger.showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.red.shade400,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        leading: Icon(CupertinoIcons.info,color: Colors.white,),
        actions: [
          TextButton(
            onPressed: () => messenger.hideCurrentMaterialBanner(),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        messenger.hideCurrentMaterialBanner();
      }
    });
  }







  //? when you went to display error bottom
  void showErrorSnack(String message) {
    final messenger = ScaffoldMessenger.of(context);

    // اخفاء أي SnackBar قديم
    messenger.hideCurrentSnackBar();

    // عرض SnackBar جديد
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.red.shade400,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Close',
          onPressed: () {
            messenger.hideCurrentSnackBar();
          },
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    // ❌ لا تحتاج Future.delayed لإنه SnackBar نفسه يغلق بعد المدة اللي حددتها
  }




 */