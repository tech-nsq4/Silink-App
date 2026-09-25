import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../widgets/nfc_step_activating.dart';
import '../widgets/nfc_step_confirm.dart';
import '../widgets/nfc_step_done.dart';
import '../widgets/nfc_step_intro.dart';
import '../widgets/nfc_step_select.dart';
import '../widgets/nfc_step_serial.dart';
import '../widgets/nfc_step_status.dart';

class NfcScreen extends StatefulWidget {
  const NfcScreen({super.key});

  @override
  State<NfcScreen> createState() => _NfcScreenState();
}

enum _NfcStep { intro, serial, validating, select, confirm, activating, done }

class _NfcScreenState extends State<NfcScreen> {
  _NfcStep _step = _NfcStep.intro;
  final _serialCtrl = TextEditingController();
  String? _error;
  double _progress = 0;
  String _activatedAt = '';

  @override
  void dispose() {
    _serialCtrl.dispose();
    super.dispose();
  }

  // Both branches of the original switch returned the same key, so this is
  // just a plain translated title now.
  String get _title => LocaleKeys.company_nfc_page_title.tr();

  Future<void> _verify() async {
    final serial = _serialCtrl.text.trim();
    if (serial.length < 4) {
      setState(() => _error = LocaleKeys.company_serial_error.tr());
      return;
    }
    setState(() {
      _error = null;
      _step = _NfcStep.validating;
    });
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _step = _NfcStep.select);
  }

  Future<void> _activate() async {
    setState(() => _step = _NfcStep.activating);
    for (var p = 0; p <= 100; p += 10) {
      await Future<void>.delayed(const Duration(milliseconds: 150));
      if (!mounted) return;
      setState(() => _progress = p.toDouble());
    }
    if (!mounted) return;
    setState(() {
      _activatedAt = DateTime.now().toIso8601String().split('T').first;
      _step = _NfcStep.done;
    });
  }

  void _onBack() {
    switch (_step) {
      case _NfcStep.intro:
      case _NfcStep.done:
        Navigator.of(context).maybePop();
      case _NfcStep.serial:
      case _NfcStep.validating:
        setState(() => _step = _NfcStep.intro);
      case _NfcStep.select:
        setState(() => _step = _NfcStep.serial);
      case _NfcStep.confirm:
        setState(() => _step = _NfcStep.select);
      case _NfcStep.activating:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: _title, onBack: _onBack),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: switch (_step) {
                _NfcStep.intro => NfcStepIntro(
                    onEnterSerial: () =>
                        setState(() => _step = _NfcStep.serial),
                    onScanQr: () => setState(() {
                      _serialCtrl.text = 'SLK-2024-DEMO';
                      _step = _NfcStep.serial;
                    }),
                  ),
                _NfcStep.serial => NfcStepSerial(
                    controller: _serialCtrl,
                    error: _error,
                    onChanged: (_) => setState(() => _error = null),
                    onVerify: _verify,
                  ),
                _NfcStep.validating => NfcStepStatus(
                    title: LocaleKeys.company_verifying.tr(),
                    description: LocaleKeys.company_verifying_desc.tr(),
                  ),
                _NfcStep.select => NfcStepSelect(
                    onConfirm: () => setState(() => _step = _NfcStep.confirm),
                  ),
                _NfcStep.confirm => NfcStepConfirm(
                    serial: _serialCtrl.text,
                    onActivate: _activate,
                    onBack: () => setState(() => _step = _NfcStep.select),
                  ),
                _NfcStep.activating => NfcStepActivating(progress: _progress),
                _NfcStep.done => NfcStepDone(
                    activatedAt: _activatedAt,
                    onBackHome: () => Navigator.of(context).maybePop(),
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }
}