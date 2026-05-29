import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';

final groceryRemoteSourceProvider = Provider<GroceryRemoteSource>((ref) {
  return GroceryRemoteSource(ref.watch(dioProvider));
});

class GroceryRemoteSource {
  const GroceryRemoteSource(this._dio);
  final Dio _dio;

  Future<void> toggleCheck(String bahanKey, bool isChecked) async {
    await _dio.put('/grocery', data: {
      'bahanKey': bahanKey,
      'isChecked': isChecked,
    });
  }
}
