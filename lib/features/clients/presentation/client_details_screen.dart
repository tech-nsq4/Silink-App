import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/clients/models/client_model.dart';
import 'package:Silink/features/clients/widgets/client_details_models.dart';
import 'package:Silink/features/clients/widgets/client_follow_up_card.dart';
import 'package:Silink/features/clients/widgets/client_notes_card.dart';
import 'package:Silink/features/clients/widgets/client_submission_card.dart';
import 'package:Silink/features/clients/widgets/client_tags_card.dart';
import 'package:Silink/features/clients/widgets/contact_card.dart';
import 'package:Silink/features/clients/widgets/quick_actions.dart';
import 'package:Silink/features/clients/widgets/status_badge.dart';
import 'package:Silink/features/clients/widgets/client_status_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientDetailsScreen extends StatefulWidget {
  const ClientDetailsScreen({super.key, required this.client});

  final ClientModel client;

  @override
  State<ClientDetailsScreen> createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  late ClientStatus _status = widget.client.status;

  late final Set<ClientTag> _selectedTags = {
    for (final tag in ClientTag.values)
      if (widget.client.tags.contains(tag.name) ||
          widget.client.tags.contains(tag.tagLabel))
        tag,
  };

  // ── المتابعة ──
  bool _addingFollowUp = false;
  DateTime? _followUpDate;
  TimeOfDay? _followUpTime;
  final TextEditingController _followUpReasonController =
      TextEditingController();
  FollowUpData? _followUp;

  // ── الملاحظات ──
  bool _addingNote = false;
  final TextEditingController _noteController = TextEditingController();
  final List<ClientNote> _notes = [];

  @override
  void dispose() {
    _followUpReasonController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _changeStatus() {
    showClientStatusSheet(
      context,
      current: _status,
      onSelected: (status) => setState(() => _status = status),
    );
  }

  void _toggleTag(ClientTag tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  Future<void> _pickFollowUpDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _followUpDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _followUpDate = picked);
  }

  Future<void> _pickFollowUpTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _followUpTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _followUpTime = picked);
  }

  void _showValidationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(LocaleKeys.validation_required.tr())),
    );
  }

  void _saveFollowUp() {
    final date = _followUpDate;
    if (date == null) {
      _showValidationError();
      return;
    }
    setState(() {
      _followUp = FollowUpData(
        date: date,
        time: _followUpTime,
        reason: _followUpReasonController.text.trim(),
      );
      _addingFollowUp = false;
      _followUpDate = null;
      _followUpTime = null;
      _followUpReasonController.clear();
    });
  }

  void _cancelFollowUp() {
    setState(() {
      _addingFollowUp = false;
      _followUpDate = null;
      _followUpTime = null;
      _followUpReasonController.clear();
    });
  }

  void _deleteFollowUp() => setState(() => _followUp = null);

  void _addNote() {
    final text = _noteController.text.trim();
    if (text.isEmpty) {
      _showValidationError();
      return;
    }
    setState(() {
      _notes.insert(0, ClientNote(text: text, createdAt: DateTime.now()));
      _addingNote = false;
      _noteController.clear();
    });
  }

  void _cancelNote() {
    setState(() {
      _addingNote = false;
      _noteController.clear();
    });
  }

  void _deleteNote(int index) => setState(() => _notes.removeAt(index));

  Future<void> _open(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // TODO: اعرض رسالة خطأ عند تعذّر فتح الرابط.
    }
  }

  void _call() => _open(Uri(scheme: 'tel', path: widget.client.phone));

  void _whatsapp() {
    final number = widget.client.phone.replaceAll(RegExp(r'[^0-9]'), '');
    _open(Uri.parse('https://wa.me/$number'));
  }

  void _email() {
    final email = widget.client.email;
    if (email == null || email.trim().isEmpty) return;
    _open(Uri(scheme: 'mailto', path: email.trim()));
  }

  void _saveContact() {}

  @override
  Widget build(BuildContext context) {
    final client = widget.client;
    final hasEmail = (client.email ?? '').trim().isNotEmpty;
    final submitValue = client.submitDateLabel == null
        ? client.timeLabel
        : client.submitTimeLabel == null
            ? client.submitDateLabel!
            : '${client.submitDateLabel!} • ${client.submitTimeLabel!}';

    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.clients_detailsTitle.tr(),
            trailing: StatusBadge(status: _status, onTap: _changeStatus),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 14.h),
              children: [
                ContactCard(client: client),
                12.height,
                QuickActions(
                  hasEmail: hasEmail,
                  onCall: _call,
                  onWhatsapp: _whatsapp,
                  onEmail: _email,
                  onSaveContact: _saveContact,
                ),
                12.height,
                ClientSubmissionCard(client: client, submitValue: submitValue),
                12.height,
                ClientTagsCard(
                    selectedTags: _selectedTags, onToggleTag: _toggleTag),
                12.height,
                ClientFollowUpCard(
                  followUp: _followUp,
                  isAdding: _addingFollowUp,
                  onToggleAdding: () =>
                      setState(() => _addingFollowUp = !_addingFollowUp),
                  date: _followUpDate,
                  time: _followUpTime,
                  reasonController: _followUpReasonController,
                  onPickDate: _pickFollowUpDate,
                  onPickTime: _pickFollowUpTime,
                  onSave: _saveFollowUp,
                  onCancel: _cancelFollowUp,
                  onDelete: _deleteFollowUp,
                ),
                12.height,
                ClientNotesCard(
                  notes: _notes,
                  isAdding: _addingNote,
                  onToggleAdding: () =>
                      setState(() => _addingNote = !_addingNote),
                  controller: _noteController,
                  onAdd: _addNote,
                  onCancel: _cancelNote,
                  onDelete: _deleteNote,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
