import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const List<Color> kProfileColorPalette = [
  Color(0xFF17B78F),
  Color(0xFF22C55E),
  Color(0xFFF97316),
  Color(0xFFEF4444),
  Color(0xFFA855F7),
  Color(0xFF3B82F6),
  Color(0xFF1E293B),
  Color(0xFFDB2777),
  Color(0xFF2563EB),
];

class ColorSwatchRow extends StatelessWidget {
  const ColorSwatchRow({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final Color selected;
  final ValueChanged<Color> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (final color in kProfileColorPalette)
          InkWell(
            onTap: () => onSelected(color),
            customBorder: const CircleBorder(),
            child: Container(
              width: 34.w,
              height: 34.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: selected == color
                    ? Border.all(color: Colors.black87, width: 2)
                    : null,
              ),
              child: selected == color
                  ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                  : null,
            ),
          ),
      ],
    );
  }
}
