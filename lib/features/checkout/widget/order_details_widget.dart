import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/custom_text.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.fees,
  });

  /// قيم الأسعار
  final double order;
  final double taxes;
  final double fees;

  /// حساب التوتال تلقائيًا
  double get total => order + taxes + fees;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CheckoutRow(title: 'Order', value: order),
        const Gap(8),
        _CheckoutRow(title: 'Taxes', value: taxes),
        const Gap(8),
        _CheckoutRow(title: 'Delivery fees', value: fees),
        const Gap(12),
        const Divider(),
        const Gap(12),
        _CheckoutRow(title: 'Total:', value: total, isBold: true,isSmall: false,),
        const Gap(12),
        const _CheckoutRow(
          title: 'Estimated delivery time:',
          value: 0,
          customText: '15 - 30 min',
          isBold: true,
        ),
      ],
    );
  }
}

class _CheckoutRow extends StatelessWidget {
  const _CheckoutRow({
    required this.title,
    required this.value,
    this.customText,
    this.isBold = false,
    this.isSmall = true,
  });

  final String title;
  final double value;       // قيمة رقمية
  final String? customText; // في حالة النصوص غير الرقمية
  final bool isBold;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final displayValue = customText ?? "\$${value.toStringAsFixed(2)}";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          size: isSmall ? 18 : 21,
          weight: isBold ? FontWeight.bold : FontWeight.w400,
          color: isBold ? Colors.black : Colors.grey.shade600,
        ),
        CustomText(
          text: displayValue,
          size: isSmall ? 18 : 21,
          weight: isBold ? FontWeight.bold : FontWeight.w400,
          color: isBold ? Colors.black : Colors.grey.shade600,
        ),
      ],
    );
  }
}
