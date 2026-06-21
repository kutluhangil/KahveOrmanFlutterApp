import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme.dart';

/// Katalog ızgarasında tek bir ürünü gösteren kart.
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: KahveOrmanColors.surface,
      elevation: 1.5,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const _CardImagePlaceholder(loading: true);
                },
                errorBuilder: (context, error, stack) =>
                    const _CardImagePlaceholder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: KahveOrmanColors.espresso,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.tagline,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: KahveOrmanColors.muted,
                      fontSize: 11.5,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₺${product.price}',
                    style: const TextStyle(
                      color: KahveOrmanColors.caramel,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Görsel yüklenirken / yüklenemediğinde gösterilen krem zeminli placeholder.
class _CardImagePlaceholder extends StatelessWidget {
  final bool loading;
  const _CardImagePlaceholder({this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KahveOrmanColors.cream,
      alignment: Alignment.center,
      child: loading
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: KahveOrmanColors.caramel,
              ),
            )
          : const Icon(
              Icons.coffee_rounded,
              color: KahveOrmanColors.muted,
              size: 34,
            ),
    );
  }
}
