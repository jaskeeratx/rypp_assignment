import 'package:flutter/material.dart';
import '../core/widgets/skeleton_loader.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, index) => const BikeCardSkeleton(),
    );
  }
}
