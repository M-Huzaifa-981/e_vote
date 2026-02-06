import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppCard extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Widget child;

  const AppCard({
    Key? key,
    this.padding = const EdgeInsets.all(16),
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: padding,
      child: child,
    );
  }
}
