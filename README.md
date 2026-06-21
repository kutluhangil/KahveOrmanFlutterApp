# KahveOrman

KahveOrman specialty kahve dükkanı için geliştirilmiş Flutter **Mini Katalog** uygulaması.
Ürünler bir ızgara (GridView) içinde listelenir, ürüne dokununca detay sayfası açılır
ve ürünler basit bir sepete eklenebilir.

## Özellikler

- **Katalog ekranı:** `GridView.builder` ile 2 sütunlu ürün kartları
- **Ürün detayı:** `Navigator` ile açılan, ürün bilgisi taşınan detay ekranı
- **Sepet:** `ListView.builder` ile listelenen ürünler ve toplam tutar
- **Veri:** `assets/products.json` dosyasından okunan ürünler (`fromJson` / `toJson`)
- **State:** `setState` ile basit sepet güncelleme
- Sadece `material.dart` ve Dart'ın dahili kütüphaneleri (ek paket yok)

## Kullanılan Flutter sürümü

- Flutter **3.44.1**
- Dart 3.12.1

## Klasör yapısı

```
lib/
  main.dart
  theme.dart                     KahveOrman renk teması
  models/product.dart            Product modeli (fromJson/toJson)
  data/product_repository.dart   products.json okur, List<Product> döndürür
  screens/home_page.dart         BottomNavigationBar + sepet state'i
  screens/catalog_screen.dart    GridView ürün listesi
  screens/detail_screen.dart     ürün detay ekranı
  screens/cart_screen.dart       sepet ekranı
  widgets/product_card.dart      tek ürün kartı
assets/products.json
```

## Çalıştırma adımları

```bash
flutter pub get
flutter run
```

Bir Android emülatörü / iOS simülatörü ya da fiziksel cihaz bağlı olmalıdır.

## Ekran görüntüleri

> Uygulamayı çalıştırdıktan sonra katalog, ürün detayı ve sepet ekranlarının
> görüntülerini buraya ekleyin.
