import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:untitled/core/network/api_error.dart';
import 'package:untitled/features/cart/data/cart_repo.dart';
import 'package:untitled/features/cart/data/model/CartModel.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
import '../../home/data/model/topping_model.dart';
import '../../home/data/product_repo.dart';
import '../widget/spicy_slider.dart';
import '../widget/topping_card.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productImage,required this.price,required this.productId});
  final String productImage;
  final int productId;
  final String price;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = 0.5;
bool isLoading= false;
  // الآن يمكن اختيار أكثر من عنصر
  List<int> selectedToppings = [];
  List<int> selectedSides = [];

  List<ToppingModel>? toppings;
  List<ToppingModel>? options;

  ProductRepo productRepo = ProductRepo();

  Future<void> getToppings() async {
    final res = await productRepo.getToppings();
    setState(() {
      toppings = res;
    });
  }

  Future<void> getOptions() async {
    final res = await productRepo.getOptions();
    setState(() {
      options = res;
    });
  }


  //Add to cart
  CartRepo cartRepo =CartRepo();



  @override
  void initState() {
    super.initState();
    getToppings();
    getOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.productImage.isEmpty,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------ Slider ------------------
                SpicySlider(
                  value: value,
                  img: widget.productImage,
                  onChanged: (v) => setState(() => value = v),
                ),

                const Gap(40),

                // ------------------ Toppings ------------------
                CustomText(text: 'Toppings', size: 18),
                const Gap(10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(toppings?.length ?? 0, (index) {
                      final topping = toppings?[index];
                      if (topping == null) return const CupertinoActivityIndicator();

                      final isSelected = selectedToppings.contains(index);

                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ToppingCard(
                          color: isSelected
                              ? Colors.green.withOpacity(0.2)
                              : AppColors.primary.withOpacity(0.1),
                          title: topping.name,
                          imageUrl: topping.image,
                          onAdd: () {
                            setState(() {
                              if (isSelected) {
                                selectedToppings.remove(index);
                              } else {
                                selectedToppings.add(index);
                              }
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),

                const Gap(25),

                // ------------------ Side Options ------------------
                CustomText(text: 'Side Options', size: 18),
                const Gap(10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(options?.length ?? 0, (index) {
                      final option = options?[index];
                      if (option == null) return const CupertinoActivityIndicator();

                      final isSelected = selectedSides.contains(index);

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ToppingCard(
                          color: isSelected
                              ? Colors.green.withOpacity(0.2)
                              : AppColors.primary.withOpacity(0.1),
                          title: option.name,
                          imageUrl: option.image,
                          onAdd: () {
                            setState(() {
                              if (isSelected) {
                                selectedSides.remove(index);
                              } else {
                                selectedSides.add(index);
                              }
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),

                const Gap(200),
              ],
            ),
          ),
        ),

        // ------------------ Bottom Sheet ------------------
        bottomSheet: Container(
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Burger Price :',
                      size: 20,
                      weight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: '\$ ${widget.price}',
                      size: 20,
                      color: Colors.white,
                      weight: FontWeight.w700,
                    ),
                  ],
                ),
                CustomButton(
                  widget: isLoading
                      ? const CupertinoActivityIndicator()
                      : const Icon(CupertinoIcons.cart_badge_plus),
                  gap: 10,
                  height: 48,
                  color: Colors.white,
                  textColor: AppColors.primary,
                  text: 'Add To Cart',
                  onTap: () async {
                    if (isLoading) return; // تمنع الضغط المتكرر أثناء التحميل

                    try {
                      setState(() => isLoading = true); // <-- خلي المؤشر يظهر أول ما تبدأ العملية

                      final cartItem = Items(
                        productId: widget.productId,
                        quantity: 1,
                        sideOptions: selectedSides,
                        spicy: value,
                        toppings: selectedToppings,
                      );

                      await cartRepo.addToCart(CartModel(items: [cartItem]));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Add to cart Successful!")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.toString()}")),
                      );
                    } finally {
                      setState(() => isLoading = false); // <-- رجع الزر لحالته الطبيعية بعد الانتهاء
                    }
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
