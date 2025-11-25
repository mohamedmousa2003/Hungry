import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:untitled/core/constants/app_colors.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
import '../widget/order_details_widget.dart';
class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String selectedMethod = 'Cash';
  @override
  Widget build(BuildContext context) {
    double order = 18;
    double taxes = 30;
    double fees = 31;
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Order summary',
                size: 22,
                weight: FontWeight.bold,
                color: AppColors.primary,
              ),
              Gap(mediaQuery.height * 0.02),
              OrderDetailsWidget(
                order: order,
                taxes: taxes ,
                fees: fees,
              ),
              Gap(mediaQuery.height * 0.03),
              CustomText(
                text: 'Payment methods',
                size: 22,
                weight: FontWeight.bold,
                color: AppColors.primary,
              ),
              Gap(mediaQuery.height * 0.02),

              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Color(0xff3C2F2F),
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                leading: Image.asset('assets/image/icon/cash.png', width: 50),
                title: CustomText(text: 'Cash on Delivery',color: Colors.white),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Cash',
                  groupValue: selectedMethod,
                  onChanged: (v) => setState(() => selectedMethod = v!),
                ),
                onTap: () => setState(() => selectedMethod = "Cash"),
              ),
              Gap(mediaQuery.height * 0.02),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Colors.blue.shade900,
                contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                leading: Image.asset("assets/image/icon/visa.png", width: 50,color: Colors.white,),
                title: CustomText(text: 'Debit card',color: Colors.white),
                subtitle: CustomText(text: '**** ***** 2342',color: Colors.white),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Visa',
                  groupValue: selectedMethod,
                  onChanged: (v) => setState(() => selectedMethod = v!),
                ),
                onTap: () => setState(() => selectedMethod = "Visa"),
              ),
              Gap(mediaQuery.height * 0.02),
              Row(
                children: [
                  Checkbox(
                    activeColor: Color(0xffEF2A39),
                    value: true,
                    onChanged: (v) {},
                  ),
                  CustomText(text: 'Save card details for future payments'),
                ],
              ),
              Gap(mediaQuery.height * 0.2),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Total price',
                    size: 22,
                    weight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  CustomText(
                    text: '\$${(order + taxes + fees).toStringAsFixed(2)}',
                    size: 25,
                    weight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                widget: const Icon(
                  CupertinoIcons.money_dollar,
                  color: Colors.white,
                  size: 30,
                ),
                gap: 10,
                height: 48,
                color: AppColors.primary,
                textColor: Colors.white,
                text: 'Pay Now',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
                          child: Container(
                            width: 300,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade800,
                                  blurRadius: 15,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColors.primary,
                                  child: const Icon(
                                    CupertinoIcons.check_mark,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const Gap(10),
                                CustomText(
                                  text: 'Success!',
                                  weight: FontWeight.bold,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                                const Gap(3),
                                CustomText(
                                  text:
                                  'Your payment was successful. \nA receipt for this purchase \nhas been sent to your email.',
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                const Gap(8),
                                CustomButton(
                                  text: 'Close',
                                  width: 200,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
}
