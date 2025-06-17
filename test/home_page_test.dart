import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_example/presentation/home/home_page.dart';
import 'package:test_example/presentation/note/note_page.dart';
import 'package:test_example/presentation/note_edit/note_edit_page.dart';

void main() {
  group('노트 앱 위젯 테스트', () {
    _runPumpTestWidget(WidgetTester tester) => tester.pumpWidget(const ProviderScope(child: MaterialApp(home: HomePage())));

    testWidgets('최초 홈 화면 비어있어야 함.', (WidgetTester tester) async {
      await _runPumpTestWidget(tester);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('홈에서 노트 생성 화면으로 이동', (WidgetTester tester) async {
      await _runPumpTestWidget(tester);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
    });

    testWidgets('노트 생성 화면에서 노트 생성', (WidgetTester tester) async {
      await _runPumpTestWidget(tester);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
      await tester.enterText(find.byKey(const ValueKey('title')), 'hi');
      await tester.enterText(find.byKey(const ValueKey('body')), 'there');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsNothing);

      expect(find.byType(Dismissible), findsNWidgets(1));
    });

    testWidgets('노트를 누르면 노트 페이지로 이동', (WidgetTester tester) async {
      await _runPumpTestWidget(tester);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
      await tester.enterText(find.byKey(const ValueKey('title')), 'hi');
      await tester.enterText(find.byKey(const ValueKey('body')), 'there');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsNothing);

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      expect(find.byType(NoteEditPage), findsOneWidget);
    });

    testWidgets('노트 수정 후 홈 화면에서 변경 확인', (WidgetTester tester) async {
      await _runPumpTestWidget(tester);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
      await tester.enterText(find.byKey(const ValueKey('title')), 'hi');
      await tester.enterText(find.byKey(const ValueKey('body')), 'there');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsNothing);

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      expect(find.byType(NoteEditPage), findsOneWidget);
      await tester.enterText(find.byKey(const ValueKey('editTitle')), 'edit hi');
      await tester.enterText(find.byKey(const ValueKey('editBody')), 'edit there');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(NoteEditPage), findsNothing);
      expect(find.byType(ListTile), findsNWidgets(1));
      expect(find.text('edit hi'), findsOneWidget);
      expect(find.text('edit there'), findsOneWidget);
    });

    testWidgets('노트를 스와이프시 해당 노트 삭제', (WidgetTester tester) async {
      await _runPumpTestWidget(tester);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);
      await tester.enterText(find.byKey(const ValueKey('title')), 'hi');
      await tester.enterText(find.byKey(const ValueKey('body')), 'there');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsNothing);

      expect(find.byType(Dismissible), findsNWidgets(1));
      await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));
      await tester.pumpAndSettle();
      expect(find.byType(Dismissible), findsNothing);
    });
  });
}
