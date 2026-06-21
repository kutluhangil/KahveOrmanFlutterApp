import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme.dart';

/// Sepet ekranı. Eklenen ürünler ListView.builder ile listelenir,
/// en altta fiyat toplamı gösterilir.
class CartScreen extends StatelessWidget {
  final List<Product> cart;

  const CartScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sepet')),
      body: cart.isEmpty ? _bosSepet() : _doluSepet(),
    );
  }

  Widget _bosSepet() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_bag_outlined,
              size: 64, color: KahveOrmanColors.muted),
          SizedBox(height: 12),
          Text(
            'Sepetiniz boş',
            style: TextStyle(color: KahveOrmanColors.muted, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _doluSepet() {
    final toplam = cart.fold<num>(0, (sum, p) => sum + p.price);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final urun = cart[index];
              return Card(
                color: KahveOrmanColors.surface,
                elevation: 0.5,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 54,
                      height: 54,
                      child: Image.network(
                        urun.image,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          color: KahveOrmanColors.cream,
                          child: const Icon(Icons.coffee_rounded,
                              color: KahveOrmanColors.muted),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    urun.name,
                    style: const TextStyle(
                      color: KahveOrmanColors.espresso,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    '₺${urun.price}',
                    style: const TextStyle(
                      color: KahveOrmanColors.caramel,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        _toplamBar(toplam),
      ],
    );
  }

  Widget _toplamBar(num toplam) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        color: KahveOrmanColors.surface,
        border: Border(top: BorderSide(color: Color(0x14000000))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Toplam',
            style: TextStyle(color: KahveOrmanColors.muted, fontSize: 16),
          ),
          Text(
            '₺$toplam',
            style: const TextStyle(
              color: KahveOrmanColors.espresso,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
