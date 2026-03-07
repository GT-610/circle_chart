import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders example app', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Circle chart Demo'), findsOneWidget);
  });
}
