import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:streamfi/core/themes/color_scheme.dart';


class DrawerItem extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const DrawerItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectedDrawer : null,
          borderRadius: BorderRadius.circular(8)
        ),
        child: ListTile(
          leading: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.white : AppColors.white.withOpacity(0.30),
                BlendMode.srcIn
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.white.withOpacity(0.30),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}