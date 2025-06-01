import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seller/res/app_string.dart';

import '../../../model/order_model.dart';
import '../../../res/app_constants.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import 'order_item_widget.dart';

class SellerOrderProductWidget extends StatelessWidget {
  const SellerOrderProductWidget({
    super.key,
    required this.sellerName,
    required this.orderModel,
    required this.sellerId,
  });

  final String sellerName;
  final OrderModel orderModel;
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: RichText(
            text: TextSpan(
              style: AppsTextStyle.mediumBoldText
                  .copyWith(color: Theme.of(context).primaryColor),
              children: [
                const TextSpan(text: "Seller Name:\t"),
                TextSpan(
                  text: AppConstants.sharedPreferences!
                              .getString(AppStrings.prefUserId) ==
                          sellerId
                      ? "My Product"
                      : sellerName,
                  style: AppsTextStyle.mediumBoldText
                      .copyWith(color: AppColors.red),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: ChangeNotifierProvider.value(
            value: orderModel,
            child: OrderItemWidget(
              sellerId: sellerId,
            ),
          ),
        ),
      ],
    );
  }
}
