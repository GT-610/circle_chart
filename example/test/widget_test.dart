import 'package:circle_chart/circle_chart.dart';
import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CircleChart renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(CircleChart), findsOneWidget);
  });
}
