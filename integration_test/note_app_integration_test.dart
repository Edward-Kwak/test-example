import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:test_example/main.dart' as app;
import 'package:test_example/presentation/note/note_page.dart';
import 'package:test_example/presentation/note_edit/note_edit_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('노트앱 통합 테스트', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('노트 생성, 수정, 삭제, 조회 테스트', (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      // 처음 빈 화면
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNothing);

      // 노트 생성 페이지 이동 후 노트 생성
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsOneWidget);

      await tester.enterText(find.byKey(const ValueKey('title')), 'hi');
      await tester.enterText(find.byKey(const ValueKey('body')), 'there');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(NotePage), findsNothing);
      expect(find.text('hi'), findsOneWidget);
      expect(find.text('there'), findsOneWidget);

      // 수정 페이지 이동 후 노트 수정
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

      // 노트 삭제
      expect(find.byType(ListTile), findsNWidgets(1));
      await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNothing);
    });
  });
}
