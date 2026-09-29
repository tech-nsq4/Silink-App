import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/core/widgets/screen_state_layout.dart';
import 'package:Silink/features/my_card/data/models/file_category_model.dart';
import 'package:Silink/features/my_card/data/models/my_file_model.dart';
import 'package:Silink/features/my_card/logic/my_file_cubit.dart';
import 'package:Silink/features/my_card/logic/my_files_cubit.dart';
import 'package:Silink/features/my_card/models/my_card_model.dart';
import 'package:Silink/features/my_card/presentation/widgets/my_file_delete_sheet.dart';
import 'package:Silink/features/my_card/presentation/widgets/my_file_form_sheet.dart';
import 'package:Silink/features/my_card/presentation/widgets/my_files_empty_view.dart';
import 'package:Silink/features/my_card/widgets/card_more_sheet.dart';
import 'package:Silink/features/my_card/widgets/create_new_card_button.dart';
import 'package:Silink/features/my_card/widgets/my_card_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  late final MyFilesCubit _cubit = getIt<MyFilesCubit>()..getFiles();
  late final MyFileCubit _fileCubit = getIt<MyFileCubit>();

  @override
  void dispose() {
    _cubit.close();
    _fileCubit.close();
    super.dispose();
  }

  List<FileCategoryModel> get _categories {
    final state = _cubit.state;
    return state is MyFilesSuccess ? state.categories : const [];
  }

  Future<void> _openForm([MyFileModel? file]) async {
    final saved = await MyFileFormSheet.show(
      context,
      categories: _categories,
      initial: file,
    );
    if (saved && mounted) _cubit.refresh();
  }

  Future<void> _delete(MyFileModel file) async {
    final confirmed = await MyFileDeleteSheet.show(context);
    if (!confirmed || !mounted) return;
    await _fileCubit.deleteFile(file.id);
    if (mounted && _fileCubit.state is MyFileDeleted) _cubit.refresh();
  }

  void _onMore(MyFileModel file, MyCardModel card) {
    showCardMoreSheet(
      context,
      cardName: card.name,
      isPaused: card.status == CardLifecycleStatus.paused,
      onDuplicate: () {},
      onRename: () => _openForm(file),
      onTogglePause: () {},
      onDelete: () => _delete(file),
    );
  }

  Future<void> _onOpenDetails(MyCardModel card) async {
    await NavigationService.push(
      Routes.myCardDetailsScreen,
      arguments: {'card': card},
    );
    if (mounted) _cubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.nav_files.tr(),
            showBack: false,
          ),
          Expanded(
            child: BlocBuilder<MyFilesCubit, MyFilesState>(
              bloc: _cubit,
              builder: (context, state) {
                final files = state is MyFilesSuccess
                    ? state.files
                    : const <MyFileModel>[];
                return CustomScreenStateLayout(
                  isLoading: state is MyFilesLoading || state is MyFilesInitial,
                  error: state is MyFilesError
                      ? ErrorModel(
                          code: ErrorEnum.response,
                          errorMessage: state.message,
                        )
                      : null,
                  onRetry: _cubit.getFiles,
                  isEmpty: files.isEmpty,
                  noDataBuilder: (_) => MyFilesEmptyView(onCreate: _openForm),
                  onRefresh: _cubit.refresh,
                  builder: (_) => ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    itemCount: files.length + 1,
                    separatorBuilder: (_, __) => 12.height,
                    itemBuilder: (context, index) {
                      if (index == files.length) {
                        return CreateNewCardButton(onTap: _openForm);
                      }
                      final file = files[index];
                      final card = MyCardModel.fromFile(file);
                      return MyCardTile(
                        card: card,
                        onTap: () => _onOpenDetails(card),
                        onMoreTap: () => _onMore(file, card),
                        onQrTap: () {},
                        onPreviewTap: () {},
                        onEditTap: () => _openForm(file),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
