# KahveOrman — Flutter Mini Katalog Uygulaması (Claude Code Brief)

> Bu bir staj ödevidir (TNC Group — Flutter / Mobil modülü). Aşağıdaki kurallara birebir uy. Bu dosyanın tamamını VS Code'daki Claude Code'a yapıştır.

## 0) ÖNCE OKU — Uyulması zorunlu kurallar
- **Sadece bu brief'te isteneni yap.** Yazmayan ekstra ekran, özellik veya "havalı" tasarım EKLEME. Sade, kurs seviyesinde tut.
- **SADECE `material.dart` ve Dart'ın dahili kütüphaneleri kullanılacak** (`dart:convert`, `package:flutter/services.dart` → rootBundle). **HİÇBİR ek paket ekleme** — http, provider, google_fonts, dio vb. KESİNLİKLE YOK. (`pubspec.yaml` dependencies kısmına yeni paket ekleme.)
- **Git ve deploy KULLANICIYA aittir.** `git init/add/commit/push`, `flutter build`, ya da herhangi bir deploy/publish komutu **ÇALIŞTIRMA.** Kullanıcı repoyu kendisi push eder. Sen sadece kodu oluştur ve `flutter pub get` ile çalışır hale getir.
- **Hiçbir yere imza/atıf koyma.** Kod, yorum, commit, README, dosya adı — **hiçbir yerde** "Claude", "AI", "generated", "Co-Authored-By" vb. **geçmesin.** Proje tamamen kullanıcının; nötr ve doğal dursun. Arayüz metinleri ve kod yorumları **Türkçe** olsun.
- **Bu, 4 ödevlik serinin son ödevidir.** Diğer ödevlerle (SQL, JavaScript) ilgili hiçbir şey ekleme; yalnızca bu Flutter uygulamasına odaklan.

## 1) Amaç
KahveOrman adlı specialty kahve dükkanı için Flutter mobil **"Mini Katalog"** uygulaması:
**Ürün listesi (GridView) → Ürün detayı (Navigator) → Sepet (setState + ListView.builder).**

## 2) Kurulum
- Flutter 3.44.1. `flutter create kahveorman` ile başla (proje adı: `kahveorman`).
- Yalnızca `material.dart`.

## 3) Klasör yapısı
```
lib/
  main.dart
  theme.dart                       -> KahveOrman renk teması
  models/product.dart              -> Product modeli (fromJson/toJson)
  data/product_repository.dart     -> assets/products.json okur, List<Product> döndürür
  screens/home_page.dart           -> kök: BottomNavigationBar (Katalog + Sepet), SEPET STATE burada
  screens/catalog_screen.dart      -> GridView ürün listesi
  screens/detail_screen.dart       -> Navigator ile açılır (Product constructor ile gelir)
  screens/cart_screen.dart         -> ListView.builder ile sepet
  widgets/product_card.dart        -> tek ürün kartı
assets/products.json
```

## 4) Veri modeli — `models/product.dart`
`Product` sınıfı; alanlar: `id` (int), `name` (String), `price` (num), `category` (String), `image` (String, görsel URL), `tagline` (String), `description` (String), `roast` (String), `origin` (String), `weight` (String). **`factory Product.fromJson(Map)` ve `Map toJson()`** metotlarını ekle.

## 5) Veri okuma — `data/product_repository.dart`
- `rootBundle.loadString('assets/products.json')` ile JSON'u oku → `jsonDecode` → liste → her eleman için `Product.fromJson` → `Future<List<Product>>` döndür.
- `pubspec.yaml` içinde `flutter:` altına `assets:` olarak `assets/products.json` ekle.

## 6) Ekranlar

### HomePage (kök, StatefulWidget) — `screens/home_page.dart`
- `BottomNavigationBar`: iki sekme → **Katalog** ve **Sepet**.
- State'te `List<Product> _cart` tut. `void _sepeteEkle(Product p)` → `setState(() => _cart.add(p));` + kısa bir `SnackBar` ("Sepete eklendi").
- Katalog sekmesi: `CatalogScreen(onAddToCart: _sepeteEkle)`.
- Sepet sekmesi: `CartScreen(cart: _cart)`.

### CatalogScreen — `screens/catalog_screen.dart`
- `AppBar` başlık: "KahveOrman".
- `FutureBuilder<List<Product>>` ile repository'den ürünleri yükle. Yüklenirken `CircularProgressIndicator`, hata olursa kısa bir hata metni.
- `GridView.builder` (2 sütun) → her ürün için `ProductCard`. Karta tıklayınca:
  `Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(product: p, onAddToCart: onAddToCart)));`

### DetailScreen — `screens/detail_screen.dart`
- Constructor: `final Product product; final void Function(Product) onAddToCart;` (route arguments bu şekilde, constructor ile taşınıyor).
- İçerik: geri butonlu `AppBar`; büyük `Image.network` (görsel), ürün adı, fiyat ("₺240" formatı, karamel), kategori etiketi, açıklama (`description`) ve alt bilgi (`roast` · `origin` · `weight`).
- Altta tam genişlik **"Sepete Ekle"** butonu → `onAddToCart(product)` çağırır + SnackBar.

### CartScreen — `screens/cart_screen.dart`
- `cart` boşsa ortada "Sepetiniz boş" mesajı (ve küçük bir sepet ikonu).
- Doluysa `ListView.builder`: her satır → küçük görsel + ürün adı + fiyat. En altta **Toplam: ₺X** (fiyatların toplamı).

### ProductCard — `widgets/product_card.dart`
- `Card` (yuvarlatılmış köşe, hafif gölge). Üstte `Image.network` (16:10), altında ürün adı (espresso) ve fiyat (karamel).
- Görselde **mutlaka** `errorBuilder` ve `loadingBuilder` olsun: yüklenemezse krem zeminli, ortasında kahve ikonu olan bir placeholder göster (kırık görsel/boşluk OLMASIN).

## 7) Tema — `theme.dart`
KahveOrman renkleri:
```
cream   = Color(0xFFFAF4EC)   // scaffold arka plan
surface = Color(0xFFFFFFFF)   // kart
espresso= Color(0xFF2C211B)   // metin
muted   = Color(0xFF81756F)   // soluk metin
caramel = Color(0xFFBB6A3C)   // primary / CTA
```
- `ThemeData(useMaterial3: true, ...)`: `scaffoldBackgroundColor: cream`; `colorScheme` karamel tabanlı; `AppBar` krem zemin + espresso yazı, gölgesiz; `ElevatedButton` karamel zemin + beyaz yazı, yuvarlatılmış.
- Font: Flutter varsayılanı (ek paket yok). Inter istenirse asset font olarak eklenebilir; şart değil.

## 8) Görseller
- `Image.network` kullan; URL'ler `assets/products.json` içinde. Görsel URL'leri Unsplash kahve fotoğraflarıdır; bir tanesi yüklenmezse `errorBuilder` placeholder gösterir, ayrıca o URL daha sonra başka bir kahve görseliyle değiştirilebilir.

## 9) Teslim (NOT: bunları KULLANICI yapacak — komut çalıştırma)
- `README.md` hazırla: **Proje adı** (KahveOrman), **kısa açıklama**, **Kullanılan Flutter sürümü: 3.44.1**, **çalıştırma adımları** (`flutter pub get`, `flutter run`). README'de AI/Claude ibaresi olmasın.
- Kullanıcı emülatör/simülatörde çalıştırıp ekran görüntüleri alacak.
- Kullanıcı public GitHub repo'ya (`kahveorman-flutter`) kendisi push edecek. (Bu ödevde web deploy istenmiyor; sadece repo + README + screenshots.)

## 10) Yapma
- Ek paket ekleme (http, provider, google_fonts vb.) — sadece material.dart + dahili Dart.
- Gereksiz ekran/özellik ekleme.
- Git / commit / push / build / deploy çalıştırma.
- Hiçbir yere Claude / AI imzası koyma.

---

## EK — `assets/products.json` (KahveOrman ürünleri)
```json
[
  { "id": 1, "name": "Ethiopia Yirgacheffe", "price": 240, "category": "Single Origin", "image": "https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=600&q=80", "tagline": "Çiçeksi, bergamot ve limon notaları", "description": "Çiçeksi aromalı, açık kavrumlu tek kökenli kahve. El ile demleme için ideal.", "roast": "Açık", "origin": "Etiyopya", "weight": "250g" },
  { "id": 2, "name": "Colombia Huila", "price": 220, "category": "Single Origin", "image": "https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=600&q=80", "tagline": "Karamel ve kakao notaları", "description": "Dengeli gövdeli, karamel tatlılığında, orta kavrumlu Kolombiya kahvesi.", "roast": "Orta", "origin": "Kolombiya", "weight": "250g" },
  { "id": 3, "name": "Kenya AA", "price": 260, "category": "Single Origin", "image": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=600&q=80", "tagline": "Canlı asidite, böğürtlen", "description": "Parlak asiditesi ve meyvemsi karakteriyle öne çıkan tek kökenli kahve.", "roast": "Açık-Orta", "origin": "Kenya", "weight": "250g" },
  { "id": 4, "name": "House Blend", "price": 200, "category": "Blend", "image": "https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=600&q=80", "tagline": "Dengeli, günlük içim", "description": "Her demleme yöntemine uygun, dengeli ve yumuşak günlük harman.", "roast": "Orta", "origin": "Harman", "weight": "250g" },
  { "id": 5, "name": "Espresso Blend", "price": 210, "category": "Blend", "image": "https://images.unsplash.com/photo-1510707577719-ae7c14805e3a?w=600&q=80", "tagline": "Yoğun crema, çikolata", "description": "Espresso için tasarlanmış, çikolatamsı ve yoğun gövdeli harman.", "roast": "Koyu", "origin": "Harman", "weight": "250g" },
  { "id": 6, "name": "Cold Brew Klasik", "price": 180, "category": "Cold Brew", "image": "https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=600&q=80", "tagline": "Yumuşak, düşük asit", "description": "Soğuk demlenmiş, pürüzsüz ve düşük asitli içime hazır kahve.", "roast": "Orta", "origin": "Harman", "weight": "330ml" },
  { "id": 7, "name": "V60 Dripper", "price": 260, "category": "Equipment", "image": "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=600&q=80", "tagline": "Seramik el demleme aparatı", "description": "Filtre kahve için klasik konik seramik dripper. Temiz ve dengeli demleme.", "roast": "-", "origin": "-", "weight": "1 adet" },
  { "id": 8, "name": "Filtre Kagidi 100lu", "price": 90, "category": "Accessories", "image": "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600&q=80", "tagline": "V60 uyumlu filtre kağıdı", "description": "Konik dripper'lar için 100'lü paket filtre kağıdı.", "roast": "-", "origin": "-", "weight": "100 adet" }
]
```

## EK — Resmi Ödev Yönergesi (özet)
- "Mini Katalog Uygulaması": ürün liste ekranı + ürün detay ekranı + sepet.
- Kullanılacaklar: **GridView** (ürün kartları), **Navigator** (sayfa geçişleri) + **Route Arguments** (detaya veri taşıma), **JSON + fromJson/toJson** (model), **ListView.builder**, **asset yönetimi (JSON)**, **basit state güncelleme** (setState), sadece **material.dart**.
- Teslim: public GitHub repo URL'i + `README.md` (proje adı, kısa açıklama, kullanılan Flutter sürümü, çalıştırma adımları) + uygulama ekran görüntüleri. GitHub URL'i veya ekran görüntüleri eksik projeler teslim sayılmaz.
