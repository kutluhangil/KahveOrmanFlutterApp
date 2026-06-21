import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/product.dart';

/// Ürün verisini assets içindeki JSON dosyasından okuyan sınıf.
class ProductRepository {
  /// assets/products.json dosyasını okur ve ürün listesine çevirir.
  Future<List<Product>> urunleriGetir() async {
    final jsonStr = await rootBundle.loadString('assets/products.json');
    final List<dynamic> data = jsonDecode(jsonStr) as List<dynamic>;
    return data
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
