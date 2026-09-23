import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../models/client_model.dart';
import '../widgets/client_tile.dart';
import '../widgets/clients_filter_bar.dart';
class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  ClientStatus _selectedStatus = ClientStatus.all;
  String _query = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  final List<ClientModel> _clients = [
    ClientModel(
      id: '1',
      name: 'أحمد الشمري',
      role: 'مدير المبيعات',
      company: 'مجموعة الأفق',
      email: 'a.shamri@outlook.com',
      message: 'اطلعت على ملفك وأودّ مناقشة فرص التعاون',
      phone: '+966501234567',
      submitDateLabel: '12 يناير 2026',
      submitTimeLabel: '10:45 م',
      tags: [ClientTag.vip.name],
      status: ClientStatus.newClient,
      source: ClientSource.qr,
      hoursAgo: 6,
    ),
    ClientModel(
      id: '2',
      name: 'فارس القحطاني',
      role: 'المدير التنفيذي',
      company: 'النجم للاستثمار',
      phone: '+966509876543',
      email: 'faris@najm.sa',
      message: 'يرغب في عرض توضيحي للفريق قبل نهاية الشهر.',
      submitDateLabel: '9 يناير 2026',
      submitTimeLabel: '2:20 م',
      tags: [ClientTag.potentialConversion.name],
      status: ClientStatus.important,
      source: ClientSource.nfc,
      daysAgo: 3,
    ),
    ClientModel(
      id: '3',
      name: 'مجموعة النفو',
      role: 'مدير المشتريات',
      company: 'مجموعة النفو التجارية',
      phone: '+966501234590',
      email: 'info@nafu.sa',
      message: 'طلب استقبال عرض سعر لعدة بطاقات للشركة.',
      submitDateLabel: '10 يناير 2026',
      submitTimeLabel: '9:10 ص',
      tags: [ClientTag.currentClient.name],
      status: ClientStatus.contacted,
      source: ClientSource.qr,
      daysAgo: 2,
    ),
  ];

  List<ClientModel> get _filteredClients {
    return _clients.where((client) {
      final matchesStatus = _selectedStatus == ClientStatus.all ||
          client.status == _selectedStatus;
      final q = _query.trim();
      final matchesQuery = q.isEmpty ||
          client.name.contains(q) ||
          client.phone.contains(q) ||
          (client.company?.contains(q) ?? false);
      return matchesStatus && matchesQuery;
    }).toList();
  }

  /// عدد العملاء في التاب النشط (بدون البحث) — للـ badge في الـ app bar.
  int get _activeTabCount {
    return _clients.where((client) {
      return _selectedStatus == ClientStatus.all ||
          client.status == _selectedStatus;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.home_potential_clients_title.tr(),
            showBack: false,
            trailing: _ClientsCountBadge(count: _activeTabCount),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(19.w, 14.h, 19.w, 0),
            child: CustomTextField(
              controller: _searchController,
              hint: LocaleKeys.clients_searchHint.tr(),
              onChanged: (value) => setState(() => _query = value),
              prefixIcon: Icon(
                Icons.search,
                size: 22.sp,
                color: AppColors.textSecondaryColor.themeColor,
              ),
              suffixIcon: _query.isEmpty
                  ? null
                  : GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                      child: Icon(
                        Icons.close,
                        size: 20.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    ),
              borderRadius: 14.r,
              borderColor: AppColors.borderColor.themeColor,
              focusedBorderColor: AppColors.mint.themeColor,
            ),
          ),
          12.height,
          ClientsFilterBar(
            selected: _selectedStatus,
            onSelected: (status) => setState(() => _selectedStatus = status),
          ),
          Expanded(
            child: _filteredClients.isEmpty
                ? Center(
                    child: AppText(
                      LocaleKeys.clients_empty.tr(),
                      fontSize: 13.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  )
                : ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 19.w, vertical: 14.h),
                    itemCount: _filteredClients.length,
                    separatorBuilder: (_, __) => 12.height,
                    itemBuilder: (context, index) => ClientTile(
                      client: _filteredClients[index],
                      onTap: () => NavigationService.push(
                        Routes.clientDetailsScreen,
                        arguments: {'client': _filteredClients[index]},
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ClientsCountBadge extends StatelessWidget {
  const _ClientsCountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText('$count', fontSize: 12.sp, fontWeight: FontWeight.w700),
    );
  }
}
