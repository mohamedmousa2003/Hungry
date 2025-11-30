import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:untitled/features/cart/data/cart_repo.dart';
import 'package:untitled/features/cart/data/model/GetCardResponse.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_error.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_snack.dart';
import '../../../shared/custom_text.dart';
import '../../checkout/views/order_details.dart';
import '../widget/cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final int itemCount = 5;
  late List<int> quantities;
  late List<bool> isRemoving; // لكل عنصر Remove لوحده

  CartRepo cartRepo = CartRepo();
  GetCardResponse? getResponse;

  @override
  void initState() {
    super.initState();
    getCartData();
    quantities = List.generate(itemCount, (_) => 1);
    isRemoving = [];
  }

  // Get cart
  Future<void> getCartData() async {
    try {
      final res = await cartRepo.getToCart();
      setState(() {
        getResponse = res;

        // Re-create removing list based on number of items
        isRemoving = List.generate(
          res?.data?.items?.length ?? 0,
              (_) => false,
        );
      });
    } catch (e) {
      customSnack(e is ApiError ? e.message : e.toString());
    }
  }

  // Add quantity (UI only)
  void onAdd(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  // Minus quantity (UI only)
  void onMin(int index) {
    if (quantities[index] > 1) {
      setState(() {
        quantities[index]--;
      });
    }
  }

  // REMOVE ONE ITEM ONLY
  Future<void> removeCartItem(int index, int id) async {
    try {
      setState(() => isRemoving[index] = true);

      await cartRepo.removeToCart(id);

      setState(() => isRemoving[index] = false);

      getCartData(); // refresh cart
      customSnack("Item removed");
    } catch (e) {
      setState(() => isRemoving[index] = false);
      customSnack(e is ApiError ? e.message : e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Skeletonizer(
      enabled: getResponse == null,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: List.generate(
                  getResponse?.data?.items?.length ?? 0,
                      (index) {
                    final item = getResponse!.data!.items![index];

                    return CartItem(
                      isLoading: isRemoving[index], // هنا حل المشكلة
                      image: item.image ?? "",
                      text: item.name ?? "",
                      desc: item.price ?? "",
                      number: item.quantity ?? 0,

                      onRemove: () {
                        removeCartItem(index, item.itemId ?? 0);
                      },

                      onAdd: () => onAdd(index),
                      onMin: () => onMin(index),
                    );
                  },
                ),
              ),

              Gap(mediaQuery.height * 0.27),
            ],
          ),
        ),

        // Checkout Bottom Section
        bottomSheet: Container(
          margin: EdgeInsets.only(bottom: mediaQuery.height * 0.1),
          width: double.infinity,
          height: 100,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
            child: Row(
              children: [
                Column(
                  children: [
                    CustomText(
                      text: 'Total',
                      size: 22,
                      weight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    CustomText(
                      text: '\$${getResponse?.data?.totalPrice}',
                      size: 25,
                      weight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                Spacer(),
                CustomButton(
                  widget: Icon(
                    CupertinoIcons.money_dollar,
                    color: Colors.white,
                    size: 30,
                  ),
                  gap: 10,
                  height: 48,
                  color: AppColors.primary,
                  textColor: Colors.white,
                  text: 'Checkout',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderDetails(
                          totalPrice: getResponse?.data?.totalPrice ?? "",
                        ),
                      ),
                    );
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
