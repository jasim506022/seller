import 'package:flutter/material.dart';

import '../../res/app_function.dart';
import '../../widget/default_shimmer_widget.dart';

/// A horizontal list of shimmer placeholders representing loading similar items.
///
/// This widget shows 5 horizontally scrollable shimmer cards, each simulating
/// a loading UI with image and text placeholders.

class LoadingSimilarWidget extends StatelessWidget {
  const LoadingSimilarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return DefaultShimmerWidget(
          height: 140,
          width: 120,
          widget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Placeholder for image
                AppsFunction.shimmerPlaceholder(height: 90),
                AppsFunction.verticalSpacing(10),
                // Placeholder for title
                AppsFunction.shimmerPlaceholder(height: 10),
                AppsFunction.verticalSpacing(10),
                // Placeholder for subtitle or price
                AppsFunction.shimmerPlaceholder(height: 10)
              ],
            ),
          ),
        );
      },
    );
  }
}
