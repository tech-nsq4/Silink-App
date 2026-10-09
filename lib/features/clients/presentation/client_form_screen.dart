import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/field_label.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../data/models/client_category_model.dart';
import '../data/models/client_model.dart';
import '../data/models/client_request.dart';
import '../logic/client_form_cubit.dart';
import 'widgets/client_category_chip.dart';

class ClientFormScreen extends StatefulWidget {
  const ClientFormScreen({
    super.key,
    this.client,
    this.categories = const [],
  });

  final ClientModel? client;
  final List<ClientCategoryModel> categories;

  @override
  State<ClientFormScreen> createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends State<ClientFormScreen> {
  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  final _formKey = GlobalKey<FormState>();
  late final ClientFormCubit _cubit = getIt<ClientFormCubit>();
  late final TextEditingController _nameCtrl =
      TextEditingController(text: widget.client?.name ?? '');
  late final TextEditingController _mobileCtrl =
      TextEditingController(text: _localNumber(widget.client?.mobile));
  late final TextEditingController _whatsappCtrl =
      TextEditingController(text: _localNumber(widget.client?.whatsapp));
  late final TextEditingController _emailCtrl =
      TextEditingController(text: widget.client?.email ?? '');
  late final TextEditingController _noteCtrl =
      TextEditingController(text: widget.client?.note ?? '');
  late final Set<String> _selectedIds = {...?widget.client?.categoryIds};
  String _mobileCode = ClientRequest.defaultCountryCode;
  String _whatsappCode = ClientRequest.defaultCountryCode;

  bool get _isEdit => widget.client != null;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _mobileCtrl.dispose();
    _whatsappCtrl.dispose();
    _emailCtrl.dispose();
    _noteCtrl.dispose();
    _cubit.close();
    super.dispose();
  }

  static String _localNumber(String? value) {
    final trimmed = (value ?? '').trim();
    final code = ClientRequest.defaultCountryCode;
    if (trimmed.startsWith(code)) return trimmed.substring(code.length);
    return trimmed;
  }

  static String _fullNumber(String code, String value) {
    final digits =
        value.replaceAll(RegExp(r'\D'), '').replaceFirst(RegExp(r'^0+'), '');
    return digits.isEmpty ? '' : '$code$digits';
  }

  String? _requiredValidator(String? value) =>
      (value == null || value.trim().isEmpty)
          ? LocaleKeys.validation_required.tr()
          : null;

  String? _emailValidator(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty || _emailPattern.hasMatch(text)) return null;
    return LocaleKeys.validation_invalidEmail.tr();
  }

  void _toggleCategory(String id) => setState(() => _selectedIds.contains(id)
      ? _selectedIds.remove(id)
      : _selectedIds.add(id));

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _cubit.submit(
      ClientRequest(
        name: _nameCtrl.text,
        mobile: _fullNumber(_mobileCode, _mobileCtrl.text),
        whatsapp: _fullNumber(_whatsappCode, _whatsappCtrl.text),
        email: _emailCtrl.text,
        note: _noteCtrl.text,
        categoryIds: [
          for (final category in widget.categories)
            if (_selectedIds.contains(category.id)) category.id,
        ],
      ),
      clientId: widget.client?.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final fieldBorder = AppColors.borderColor.themeColor;
    return BlocListener<ClientFormCubit, ClientFormState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is ClientFormSuccess) {
          Navigator.pop(context, state.client ?? true);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            ScreenHeaderBar(
              title: _isEdit
                  ? LocaleKeys.clients_editClient.tr()
                  : LocaleKeys.clients_addClient.tr(),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
                  children: [
                    FieldLabel(
                        text: LocaleKeys.clients_nameLabel.tr(),
                        required: true),
                    CustomTextField(
                      controller: _nameCtrl,
                      hint: LocaleKeys.clients_nameHint.tr(),
                      validator: _requiredValidator,
                      borderColor: fieldBorder,
                    ),
                    14.height,
                    FieldLabel(
                        text: LocaleKeys.clients_mobileLabel.tr(),
                        required: true),
                    CustomTextFieldPhoneCode(
                      controller: _mobileCtrl,
                      hint: LocaleKeys.clients_mobileHint.tr(),
                      initialCountryCode: 'SA',
                      fillColor: AppColors.fieldFill,
                      borderColor: fieldBorder,
                      onChanged: (phone) => _mobileCode = phone.countryCode,
                    ),
                    14.height,
                    FieldLabel(text: LocaleKeys.clients_whatsappLabel.tr()),
                    CustomTextFieldPhoneCode(
                      controller: _whatsappCtrl,
                      hint: LocaleKeys.clients_whatsappHint.tr(),
                      initialCountryCode: 'SA',
                      isRequired: false,
                      fillColor: AppColors.fieldFill,
                      borderColor: fieldBorder,
                      onChanged: (phone) => _whatsappCode = phone.countryCode,
                    ),
                    14.height,
                    FieldLabel(text: LocaleKeys.clients_emailLabel.tr()),
                    CustomTextField(
                      controller: _emailCtrl,
                      hint: LocaleKeys.clients_emailHint.tr(),
                      keyboardType: TextInputType.emailAddress,
                      validator: _emailValidator,
                      borderColor: fieldBorder,
                    ),
                    14.height,
                    FieldLabel(text: LocaleKeys.clients_noteLabel.tr()),
                    CustomTextField(
                      controller: _noteCtrl,
                      hint: LocaleKeys.clients_noteHint.tr(),
                      maxLines: 4,
                      borderColor: fieldBorder,
                    ),
                    if (widget.categories.isNotEmpty) ...[
                      14.height,
                      FieldLabel(text: LocaleKeys.clients_tags.tr()),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          for (final category in widget.categories)
                            ClientCategoryChip(
                              label: category.name,
                              selected: _selectedIds.contains(category.id),
                              onTap: () => _toggleCategory(category.id),
                            ),
                        ],
                      ),
                    ],
                    28.height,
                    BlocBuilder<ClientFormCubit, ClientFormState>(
                      bloc: _cubit,
                      builder: (context, state) => CustomButton(
                        title: LocaleKeys.clients_save.tr(),
                        loading: state is ClientFormLoading,
                        onTap: _submit,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
