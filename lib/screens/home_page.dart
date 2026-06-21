import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme.dart';
import 'catalog_screen.dart';
import 'cart_screen.dart';

/// Uygulamanın kök ekranı. Sepet state'i burada tutulur ve
/// BottomNavigationBar ile Katalog / Sepet sekmeleri arasında geçiş yapılır.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Product> _cart = [];

  void _sepeteEkle(Product p) {
    setState(() => _cart.add(p));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${p.name} sepete eklendi'),
          duration: const Duration(milliseconds: 1200),
          backgroundColor: KahveOrmanColors.espresso,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      CatalogScreen(onAddToCart: _sepeteEkle),
      CartScreen(cart: _cart),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        backgroundColor: KahveOrmanColors.surface,
        selectedItemColor: KahveOrmanColors.caramel,
        unselectedItemColor: KahveOrmanColors.muted,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe_outlined),
            activeIcon: Icon(Icons.local_cafe),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: _cart.isEmpty
                ? const Icon(Icons.shopping_bag_outlined)
                : Badge(
                    label: Text('${_cart.length}'),
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
            activeIcon: const Icon(Icons.shopping_bag),
            label: 'Sepet',
          ),
        ],
      ),
    );
  }
}
