import 'package:flutter_test/flutter_test.dart';

import 'package:kahveorman/main.dart';

void main() {
  testWidgets('Alt menü Katalog ve Sepet sekmelerini gösterir',
      (WidgetTester tester) async {
    await tester.pumpWidget(const KahveOrmanApp());

    expect(find.text('Katalog'), findsOneWidget);
    expect(find.text('Sepet'), findsWidgets);
  });
}
