
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_user/presentation/pages/search_page/search_page.dart';
import 'package:mockito/mockito.dart';

void main () {

  Widget createWidgetForTesting({required Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('should contain a text-field', (WidgetTester tester) async {

    await tester.pumpWidget(createWidgetForTesting(child: SearchPage()));
    expect(find.byType(TextField), equals(findsOneWidget));

  });

}