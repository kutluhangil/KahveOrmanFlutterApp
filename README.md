<div align="center">

<img src="docs/media/hero.svg" alt="KahveOrman — a Flutter mini catalogue for a specialty coffee shop" width="100%">

<p>
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-material.dart-c47a45?style=for-the-badge&labelColor=120c08">
  <img alt="Dart" src="https://img.shields.io/badge/Dart-no%20extra%20packages-e8c39e?style=for-the-badge&labelColor=120c08">
  <img alt="Platforms" src="https://img.shields.io/badge/Android%20%2B%20iOS-mobile-7a9b76?style=for-the-badge&labelColor=120c08">
  <img alt="Course" src="https://img.shields.io/badge/course-final%20project-c47a45?style=for-the-badge&labelColor=120c08">
</p>

<p><em>A mini catalogue app for a specialty coffee shop: product list, product detail and a cart,<br>
written with nothing but Flutter's material library and Dart's built-ins.</em></p>

</div>

<img src="docs/media/divider.svg" width="100%" alt="">

## What it is

The Flutter edition of KahveOrman, built as the final project of a mobile development (Android / iOS) course. The goal was to show the core of Flutter cleanly: a grid of products, navigation to a detail page with data passed through the constructor, and a simple cart.

| | |
|---|---|
| **Catalogue** | A two-column `GridView.builder` of cards with image, name, short description and price. |
| **Product detail** | Opened with `Navigator.push`; the product is passed through the constructor. |
| **Cart** | Add products and see the running total. |
| **No dependencies** | Only `material.dart` and Dart's own libraries. |

```mermaid
flowchart LR
  G[Catalogue · GridView] -- Navigator.push --> D[Product detail]
  D -- add --> C[Cart · total]
  G --> C
```

<img src="docs/media/divider.svg" width="100%" alt="">

## Türkçe özet

**KahveOrman Flutter**, bir specialty kahve dükkânı için geliştirilmiş Flutter mini katalog uygulaması; mobil uygulama geliştirme (Android / iOS) eğitiminin proje ödevi. Ürün listesi, ürün detayı ve sepet akışı var. Uygulama yalnızca `material.dart` ve Dart'ın dahili kütüphaneleriyle yazıldı.

<img src="docs/media/divider.svg" width="100%" alt="">

## Running it

```sh
flutter pub get
flutter run
flutter test
```

<div align="center">
<br>
<a href="https://github.com/kutluhangil"><img src="docs/media/signature.svg" width="100%" alt="Built by kutluhangil"></a>
<sub>Course project · see also the web version, KahveOrman.</sub>
</div>
