import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_button.dart';
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

  @override
  void initState() {
    quantities = List.generate(itemCount, (_) => 1);
    super.initState();
  }
  void onAdd (int index) {
    setState(() {
      quantities[index]++;
    });
  }
  void onMin(int index) {
    setState(() {
      if(quantities[index] > 1)
      {
        quantities[index]--;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: List.generate(3,
                  (index) {
                    return CartItem(
                      image: 'assets/image/png/logo.png',
                      text: 'Hamburger ',
                      desc: 'Veggie Burger',
                      number: quantities[index],
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
      bottomSheet: Container(
        margin: EdgeInsets.only(bottom:mediaQuery.height * 0.1),
        width: double.infinity,
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3),
          child: Row(
            children: [
              Column(
                children: [
                  CustomText(text: 'Total',size: 22,weight: FontWeight.bold,color: AppColors.primary),
                  CustomText(text: '\$18',size: 25,weight: FontWeight.bold,color: AppColors.primary,),
                ],
              ),
              Spacer(),
              CustomButton(
                widget:  Icon(
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
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return OrderDetails();
                      },
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );

  }
}
