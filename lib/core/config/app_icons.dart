import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  //Navigation bar

  static const homeOutline = 'assets/icons/nav_home_outline.svg';
  static const homeFilled = 'assets/icons/nav_home_fill.svg';

  static const favoriteOutline = 'assets/icons/nav_fav_outline.svg';
  static const favoriteFill = 'assets/icons/nav_fav_fill.svg';

  static const contributeOutline = 'assets/icons/nav_contribute_outline.svg';
  static const contributeFill = 'assets/icons/nav_contribute_fill.svg';

  static const profileOutline = 'assets/icons/nav_profile_outline.svg';
  static const profileFill = 'assets/icons/nav_profile_fill.svg';
}

//widget that we use for icon
class AppIcon extends StatelessWidget {
  final String asset;
  final double size;
  final Color color;

  const AppIcon(this.asset, {super.key, this.size = 24, required this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(asset, width: size, height: size, colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
  }
}
