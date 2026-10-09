import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspacePairGrid extends StatelessWidget {
  const WorkspacePairGrid({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var start = 0; start < children.length; start += 2)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: children[start]),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: start + 1 < children.length
                        ? children[start + 1]
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
