import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_assets.dart';

/// The video assets are WebM with transparency; unsupported platforms use a
/// static brand asset until a native transparent-video renderer is selected.
class BrandVideo extends StatelessWidget {
  const BrandVideo({super.key, required this.asset, this.loop = false, this.size = 220});
  final String asset;
  final bool loop;
  final double size;
  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: size,
        child: Center(child: SvgPicture.asset(
          loop ? AppAssets.colorLogo : AppAssets.colorNameLogo,
          width: size * .75,
        )),
      );
}
