import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/image/custom_image.dart';

class MyFileThumb extends StatelessWidget {
  const MyFileThumb({
    super.key,
    required this.initials,
    required this.width,
    required this.height,
    required this.radius,
    this.imageUrl,
    this.localFile,
  });

  final String initials;
  final double width;
  final double height;
  final double radius;
  final String? imageUrl;
  final File? localFile;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim() ?? '';
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: localFile != null
            ? Image.file(localFile!, fit: BoxFit.cover)
            : url.isNotEmpty
                ? CustomImage(image: url, width: width, height: height)
                : ColoredBox(
                    color: AppColors.mint.themeColor,
                    child: Center(
                      child: AppText(
                        initials,
                        fontSize: height * 0.38,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
      ),
    );
  }
}
