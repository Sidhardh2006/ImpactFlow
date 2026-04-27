import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:impact_flow/main.dart';
import 'package:impact_flow/providers/need_provider.dart';

void main() {
  testWidgets('ImpactFlow smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NeedProvider()),
        ],
        child: const ImpactFlowApp(),
      ),
    );

    // Verify that the title is present.
    expect(find.text('ImpactFlow'), findsWidgets);
    expect(find.text('Welcome to ImpactFlow'), findsOneWidget);
  });
}
