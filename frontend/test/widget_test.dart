import 'package:asalkenyang/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App boots into the splash screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: AsalKenyangApp()));
    await tester.pump();

    expect(find.text('AsalKenyang'), findsOneWidget);
    expect(find.text('Siapin bahan, atur dompet...'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 801));
  });
}
