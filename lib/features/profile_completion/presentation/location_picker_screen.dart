import 'dart:async';

import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/custom_loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationPickerResult {
  final double lat;
  final double lng;
  final String address;

  const LocationPickerResult({
    required this.lat,
    required this.lng,
    required this.address,
  });
}

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  static const LatLng _fallbackCenter = LatLng(24.7136, 46.6753);

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final MapController _mapController = MapController();
  Timer? _debounce;

  LatLng _center = LocationPickerScreen._fallbackCenter;
  String? _address;
  bool _resolving = false;
  bool _locating = true;

  @override
  void initState() {
    super.initState();
    _locateAndCenter();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _locateAndCenter() async {
    setState(() => _locating = true);
    final position = await _determinePosition();
    if (!mounted) return;
    if (position != null) {
      final center = LatLng(position.latitude, position.longitude);
      setState(() {
        _center = center;
        _locating = false;
      });
      _mapController.move(center, 16);
      _resolveAddress(center);
    } else {
      setState(() => _locating = false);
      _resolveAddress(_center);
    }
  }

  Future<Position?> _determinePosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      return await Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }

  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    if (!hasGesture) return;
    _center = camera.center;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      _resolveAddress(_center);
    });
  }

  Future<void> _resolveAddress(LatLng center) async {
    setState(() => _resolving = true);
    try {
      final placemarks = await placemarkFromCoordinates(
        center.latitude,
        center.longitude,
      );
      if (!mounted) return;
      final address = placemarks.isNotEmpty
          ? _formatPlacemark(placemarks.first)
          : null;
      setState(() {
        _address = address;
        _resolving = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _address = null;
        _resolving = false;
      });
    }
  }

  String? _formatPlacemark(Placemark placemark) {
    final parts = [
      placemark.subLocality,
      placemark.locality,
      placemark.administrativeArea,
      placemark.country,
    ].where((part) => part != null && part.trim().isNotEmpty).toList();
    return parts.isEmpty ? null : parts.join('، ');
  }

  void _confirm() {
    final address = _address ??
        LocaleKeys.location_picker_address_unavailable.tr();
    Navigator.of(context).pop(
      LocationPickerResult(
        lat: _center.latitude,
        lng: _center.longitude,
        address: address,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          LocaleKeys.location_picker_title.tr(),
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        backgroundColor: AppColors.white.themeColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15,
              onPositionChanged: _onPositionChanged,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.silink.app',
              ),
            ],
          ),
          IgnorePointer(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 36.h),
                child: Icon(
                  Icons.location_on,
                  size: 42.sp,
                  color: AppColors.successColor.themeColor,
                ),
              ),
            ),
          ),
          if (_locating)
            ColoredBox(
              color: Colors.black.withValues(alpha: 0.15),
              child: CustomLoadingWidget(
                color: AppColors.successColor.themeColor,
              ),
            ),
          Positioned(
            right: 16.w,
            bottom: 150.h,
            child: FloatingActionButton.small(
              heroTag: 'locate_me',
              backgroundColor: AppColors.white.themeColor,
              onPressed: _locateAndCenter,
              child: Icon(
                Icons.my_location,
                color: AppColors.successColor.themeColor,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 20.h),
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 18.sp,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                      8.width,
                      Expanded(
                        child: AppText(
                          _resolving
                              ? LocaleKeys.location_picker_resolving.tr()
                              : (_address ??
                                  LocaleKeys.location_picker_address_unavailable
                                      .tr()),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  14.height,
                  CustomButton(
                    title: LocaleKeys.location_picker_confirm.tr(),
                    onTap: _confirm,
                    height: 50,
                    radius: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
