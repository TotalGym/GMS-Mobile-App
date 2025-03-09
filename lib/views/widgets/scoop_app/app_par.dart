import 'package:flutter/material.dart';
import 'package:gmn/values/colors.dart';

class TopBar extends AppBar {
  final String screenTitle;

  TopBar({
    required this.screenTitle,
    super.key,
  });

  @override
  double? get elevation => 0;

  @override
  Color? get backgroundColor => Colors.transparent;

  @override
  Widget? get title => Title(
        title: screenTitle,
        color: AppColors.theme1,
        child: Text(
          screenTitle,
          style: const TextStyle(color: AppColors.theme1),
        ),
      );

  @override
  IconThemeData? get iconTheme => const IconThemeData(
      color: AppColors.theme1, // Change the color of the drawer button icon
      size: 32);
}
