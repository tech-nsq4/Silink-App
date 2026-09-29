import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_constants.dart';
import '../../cart/data/models/cart_item.dart';
import 'models/city_model.dart';
import 'models/order_model.dart';
import 'models/payment_method.dart';
import 'models/shipping_address.dart';

class CheckoutRepo {
  CheckoutRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<List<CityModel>> getCities() async {
    try {
      final response = await _dio.get(ApiEndpoints.cities);
      final data = response.data['data'];
      return data is List
          ? data
              .whereType<Map<String, dynamic>>()
              .map(CityModel.fromJson)
              .toList(growable: false)
          : const [];
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<OrderModel> createOrder({
    required ShippingAddress address,
    required PaymentMethod paymentMethod,
    required List<CartItem> items,
    required double subtotal,
    required double shipping,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.meOrders,
        data: {
          ...address.toJson(),
          'paymentType': paymentMethod.value,
          'products': [
            for (final item in items)
              {'productId': item.productId, 'quantity': item.quantity},
          ],
        },
      );
      final data = response.data['data'];
      final json = data is Map<String, dynamic>
          ? (data['order'] is Map<String, dynamic>
              ? data['order'] as Map<String, dynamic>
              : data)
          : const <String, dynamic>{};
      final now = DateTime.now();

      return OrderModel.fromJson(
        json,
        fallbackCreatedAt: now,
        fallbackExpectedDeliveryAt:
            now.add(const Duration(days: AppConstants.maxDeliveryDays)),
        paymentMethod: paymentMethod,
        address: address,
        items: items,
        subtotal: subtotal,
        shipping: shipping,
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
