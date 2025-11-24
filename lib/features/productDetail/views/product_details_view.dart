import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:untitled/core/constants/app_colors.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
import '../widget/spicy_slider.dart';
import '../widget/topping_card.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double valueResult = 0;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(mediaQuery.height * 0.05),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                  child: Icon(CupertinoIcons.arrow_left)),
              Gap(mediaQuery.height * 0.01),
              SpicySlider(
                value: valueResult,
                onChanged: (double value) {
                  valueResult = value;
                  setState(() {});
                },
              ),
              Gap(mediaQuery.height * 0.08),
              CustomText(text: 'Toppings', size: 20, color: AppColors.primary),
              Gap(mediaQuery.height * 0.08),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ToppingCard(
                        imageUrl:
                            "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&auto=format&fit=crop&q=60",
                        title: 'Tomato',
                        onAdd: () {
                          print("add");
                        },
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
              Gap(mediaQuery.height * 0.05),
              CustomText(
                text: 'Side options',
                size: 20,
                color: AppColors.primary,
              ),
              Gap(mediaQuery.height * 0.08),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ToppingCard(
                        imageUrl:
                            "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&auto=format&fit=crop&q=60",
                        title: 'Tomato',
                        onAdd: () {
                          print("add");
                        },
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
              Gap(mediaQuery.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomText(text: 'Burger Price',size: 22,weight: FontWeight.bold,color: AppColors.primary),
                      CustomText(text: '\$ 18',size: 25,weight: FontWeight.bold,color: AppColors.primary,),
                    ],
                  ),
                  Spacer(),
                  CustomButton(
                    widget:  Icon(
                        CupertinoIcons.cart_badge_plus,
                      color: Colors.white,
                      size: 30,
                    ),
                    gap: 10,
                    height: 48,
                    color: AppColors.primary,
                    textColor: Colors.white,
                    text: 'Add To Cart',
                    onTap: () {},
                  ),
                ],
              ),
              Gap(mediaQuery.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
