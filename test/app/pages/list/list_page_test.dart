import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:todo_hasura/app/pages/list/list_page.dart';

main() {
  testWidgets('ListPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(ListPage(title: 'List')));
    final titleFinder = find.text('List');
    expect(titleFinder, findsOneWidget);
  });
}
