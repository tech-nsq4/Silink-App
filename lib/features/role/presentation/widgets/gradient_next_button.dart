// import 'package:Silink/core/utils/locale_keys.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// class GradientNextButton extends StatelessWidget {
//   final bool enabled;
//   final VoidCallback onPressed;
//   final String? label;

//   const GradientNextButton({
//     super.key,
//     required this.enabled,
//     required this.onPressed,
//     this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
//         child: SizedBox(
//           width: double.infinity,
//           height: 54,
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14),
//               gradient: enabled
//                   ? const LinearGradient(
//                       colors: [Color(0xFF17B78F), Color(0xFF2F6FED)],
//                       begin: Alignment.centerRight,
//                       end: Alignment.centerLeft,
//                     )
//                   : null,
//               color: enabled ? null : const Color(0xFFE9EBEF),
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(14),
//                 onTap: enabled ? onPressed : null,
//                 child: Center(
//                   child: Text(
//                     label ?? LocaleKeys.onboarding_next.tr(),
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: enabled ? Colors.white : const Color(0xFFB4B8C0),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
