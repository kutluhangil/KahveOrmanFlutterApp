import 'package:flutter/material.dart';

import '../data/product_repository.dart';
import '../models/product.dart';
import '../theme.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';

/// Ürünlerin GridView ile listelendiği katalog ekranı.
class CatalogScreen extends StatefulWidget {
  final void Function(Product) onAddToCart;

  const CatalogScreen({super.key, required this.onAddToCart});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final ProductRepository _repository = ProductRepository();
  late final Future<List<Product>> _urunlerFuture;

  @override
  void initState() {
    super.initState();
    _urunlerFuture = _repository.urunleriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KahveOrman')),
      body: FutureBuilder<List<Product>>(
        future: _urunlerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: KahveOrmanColors.caramel),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Ürünler yüklenemedi.',
                style: TextStyle(color: KahveOrmanColors.muted),
              ),
            );
          }

          final urunler = snapshot.data ?? const <Product>[];
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.93,
            ),
            itemCount: urunler.length,
            itemBuilder: (context, index) {
              final urun = urunler[index];
              return ProductCard(
                product: urun,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(
                        product: urun,
                        onAddToCart: widget.onAddToCart,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
