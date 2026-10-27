import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_assets.dart';
import 'brand_video.dart';

class BrandLoading extends StatelessWidget {
  const BrandLoading({super.key});
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: const BrandVideo(asset: AppAssets.loadingVideo, loop: true, size: 80),
      ),
      const SizedBox(height: 4),
      Text('common_loading'.tr, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
}
