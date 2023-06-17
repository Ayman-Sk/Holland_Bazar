import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class AppLocaleImage extends StatelessWidget {
  final String path;
  final bool isSvg;
  final double? width;
  final double? height;
  const AppLocaleImage({super.key, required this.path, required this.isSvg, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height, child: isSvg ? SvgPicture.asset(path) : Image.asset(path));
  }
}
