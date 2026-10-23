import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../data/models/static_page_content.dart';
import '../logic/static_page_cubit.dart';

class StaticPageScreen extends StatefulWidget {
  const StaticPageScreen({super.key, required this.type});

  final StaticPageType type;

  @override
  State<StaticPageScreen> createState() => _StaticPageScreenState();
}

class _StaticPageScreenState extends State<StaticPageScreen> {
  late final StaticPageCubit _cubit = getIt<StaticPageCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.load(widget.type.slug);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Widget _paragraph(String text) => AppText(
        text,
        fontSize: 14.sp,
        height: 1.8,
        color: AppColors.textSecondaryColor.themeColor,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaticPageCubit, StaticPageState>(
      bloc: _cubit,
      builder: (context, state) {
        final page = state is StaticPageSuccess ? state.page : null;
        final title = page?.title.trim().isNotEmpty == true
            ? page!.title
            : widget.type.titleKey.tr();
        return Scaffold(
          body: Column(
            children: [
              ScreenHeaderBar(title: title),
              Expanded(
                child: CustomScreenStateLayout(
                  isLoading:
                      state is StaticPageInitial || state is StaticPageLoading,
                  error: state is StaticPageError
                      ? ErrorModel(
                          code: ErrorEnum.otherError,
                          errorMessage: state.message,
                        )
                      : null,
                  isEmpty: state is StaticPageSuccess &&
                      (page == null || page.paragraphs.isEmpty),
                  onRetry: () => _cubit.load(widget.type.slug),
                  builder: (context) => ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 19.w,
                      vertical: 20.h,
                    ),
                    children: [
                      for (final (index, text) in page!.paragraphs.indexed) ...[
                        if (index > 0) 20.height,
                        _paragraph(text),
                      ],
                      24.height,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
