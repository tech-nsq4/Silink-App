import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/flow_top_bar.dart';
import '../../../core/widgets/screen_state_layout.dart';
import '../data/client_contact_saver.dart';
import '../data/models/client_model.dart';
import '../data/models/client_request.dart';
import '../logic/client_details_cubit.dart';
import 'widgets/client_categories_card.dart';
import 'widgets/client_contact_card.dart';
import 'widgets/client_delete_dialog.dart';
import 'widgets/client_header_actions.dart';
import 'widgets/client_follow_up_card.dart';
import 'widgets/client_notes_card.dart';
import 'widgets/client_quick_actions.dart';

class ClientDetailsScreen extends StatefulWidget {
  const ClientDetailsScreen({super.key, required this.client});

  final ClientModel client;

  @override
  State<ClientDetailsScreen> createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  late final ClientDetailsCubit _cubit = getIt<ClientDetailsCubit>()
    ..getClient(widget.client.id, initial: widget.client);

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _close() => Navigator.pop(context, _cubit.hasChanges);

  Future<void> _open(Uri uri) async {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication)
        .catchError((_) => false);
    if (!opened) {
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  void _call(ClientModel client) => _open(
      Uri(scheme: 'tel', path: ClientRequest.withCountryCode(client.mobile)));

  void _whatsapp(ClientModel client) {
    final number = ClientRequest.withCountryCode(client.whatsappOrMobile)
        .replaceAll(RegExp(r'\D'), '');
    _open(Uri.parse('https://wa.me/$number'));
  }

  void _email(ClientModel client) =>
      _open(Uri(scheme: 'mailto', path: client.email.trim()));

  Future<void> _saveContact(ClientModel client) async {
    try {
      await const ClientContactSaver().save(client);
    } catch (_) {
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  Future<void> _edit(ClientDetailsSuccess state) async {
    final result = await NavigationService.push(
      Routes.clientFormScreen,
      arguments: {'client': state.client, 'categories': state.categories},
    );
    if (!mounted) return;
    if (result is ClientModel) {
      _cubit.replaceClient(result);
    } else if (result != null) {
      _cubit.getClient(state.client.id, initial: state.client);
    }
  }

  Future<void> _delete() async {
    final confirmed = await ClientDeleteDialog.show(context);
    if (confirmed && mounted) _cubit.deleteClient();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _close();
      },
      child: BlocConsumer<ClientDetailsCubit, ClientDetailsState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ClientDetailsDeleted) _close();
        },
        builder: (context, state) {
          final success = state is ClientDetailsSuccess ? state : null;
          return Scaffold(
            backgroundColor: AppColors.backgroundColor.themeColor,
            body: Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: FlowTopBar(
                    title: LocaleKeys.clients_detailsTitle.tr(),
                    onBack: _close,
                    action: success == null
                        ? null
                        : ClientHeaderActions(
                            onEdit: success.isUpdating
                                ? null
                                : () => _edit(success),
                            onDelete: success.isUpdating ? null : _delete,
                          ),
                  ),
                ),
                Expanded(
                  child: CustomScreenStateLayout(
                    isLoading: success == null && state is! ClientDetailsError,
                    error: state is ClientDetailsError
                        ? ErrorModel(
                            code: ErrorEnum.otherError,
                            errorMessage: state.message,
                          )
                        : null,
                    onRetry: () => _cubit.getClient(widget.client.id),
                    builder: (context) {
                      final client = success!.client;
                      final hasEmail = client.email.trim().isNotEmpty;
                      return RefreshIndicator(
                        onRefresh: () =>
                            _cubit.getClient(client.id, initial: client),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(22.w, 6.h, 22.w, 28.h),
                          children: [
                            ClientContactCard(client: client),
                            12.height,
                            ClientQuickActions(
                              onCall: () => _call(client),
                              onWhatsapp: () => _whatsapp(client),
                              onEmail: hasEmail ? () => _email(client) : null,
                              onSaveContact: () => _saveContact(client),
                            ),
                            12.height,
                            ClientCategoriesCard(
                              categories: success.categories,
                              selectedIds: client.categoryIds,
                              isUpdating: success.isUpdating,
                              onToggle: _cubit.toggleCategory,
                            ),
                            12.height,
                            ClientFollowUpCard(
                              followUp: success.followUp,
                              onSave: _cubit.saveFollowUp,
                            ),
                            12.height,
                            ClientNotesCard(
                              notes: success.notes,
                              onAdd: _cubit.addNote,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
