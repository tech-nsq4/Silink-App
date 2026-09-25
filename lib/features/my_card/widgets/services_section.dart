import 'package:Silink/features/store/widgets/section_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/locale_keys.dart';
import 'dots_indicator.dart';
import 'service_product_card.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key, required this.services});

  final List<Map<String, dynamic>> services;

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  final PageController _controller = PageController();
  int _page = 0;

  int get _pagesCount => (widget.services.length / 2).ceil();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: LocaleKeys.publish_productsAndServices.tr(),
        ),
        12.height,
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.24,
          child: PageView.builder(
            controller: _controller,
            itemCount: _pagesCount,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, pageIndex) {
              final first = pageIndex * 2;
              final second = first + 1;
              return Row(
                children: [
                  Expanded(child: _serviceCard(widget.services[first])),
                  10.width,
                  Expanded(
                    child: second < widget.services.length
                        ? _serviceCard(widget.services[second])
                        : const SizedBox(),
                  ),
                ],
              );
            },
          ),
        ),
        12.height,
        DotsIndicator(count: _pagesCount, current: _page),
      ],
    );
  }

  Widget _serviceCard(Map<String, dynamic> s) => ServiceProductCard(
        name: s['name'] as String,
        icon: s['icon'] as IconData,
        imageGradient: (s['gradient'] as List).cast<Color>(),
        type: s['type'] as String,
        price: s['price'] as String,
      );
}
