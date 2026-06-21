import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme.dart';

/// Ürün detay ekranı. Katalogdan Navigator ile, ürün constructor üzerinden
/// taşınarak açılır.
class DetailScreen extends StatelessWidget {
  final Product product;
  final void Function(Product) onAddToCart;

  const DetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: KahveOrmanColors.cream,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: KahveOrmanColors.caramel,
                    ),
                  );
                },
                errorBuilder: (context, error, stack) => Container(
                  color: KahveOrmanColors.cream,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.coffee_rounded,
                    size: 56,
                    color: KahveOrmanColors.muted,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: KahveOrmanColors.espresso,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₺${product.price}',
                        style: const TextStyle(
                          color: KahveOrmanColors.caramel,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _CategoryChip(label: product.category),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.tagline,
                    style: const TextStyle(
                      color: KahveOrmanColors.caramel,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.description,
                    style: const TextStyle(
                      color: KahveOrmanColors.espresso,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _InfoBox(product: product),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => onAddToCart(product),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Sepete Ekle'),
            ),
          ),
        ),
      ),
    );
  }
}

/// Kategori etiketi.
class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: KahveOrmanColors.caramel.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: KahveOrmanColors.caramel,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Kavrum · köken · gramaj alt bilgisi.
class _InfoBox extends StatelessWidget {
  final Product product;
  const _InfoBox({required this.product});

  @override
  Widget build(BuildContext context) {
    final parts = [product.roast, product.origin, product.weight]
        .where((e) => e.trim().isNotEmpty && e != '-')
        .toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: KahveOrmanColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: KahveOrmanColors.muted.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline,
              size: 18, color: KahveOrmanColors.muted),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              parts.isEmpty ? '—' : parts.join('  ·  '),
              style: const TextStyle(
                color: KahveOrmanColors.muted,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
