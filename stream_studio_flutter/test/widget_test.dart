import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_studio_flutter/views/camera_studio_view.dart';
import 'package:stream_studio_flutter/views/companion_studio_view.dart';
import 'package:stream_studio_client/stream_studio_client.dart';

class FakeClient extends Client {
  FakeClient() : super('http://localhost:8080/');
}

void main() {
  testWidgets('CameraStudioView compiles and displays initial loading UI', (tester) async {
    final client = FakeClient();
    await tester.pumpWidget(
      MaterialApp(
        home: CameraStudioView(
          client: client,
          streamId: 'test_stream',
        ),
      ),
    );

    expect(find.byType(CameraStudioView), findsOneWidget);
  });

  testWidgets('CompanionStudioView compiles and displays dashboard layout', (tester) async {
    final client = FakeClient();
    await tester.pumpWidget(
      MaterialApp(
        home: CompanionStudioView(
          client: client,
          streamId: 'test_stream',
        ),
      ),
    );

    expect(find.text('StreamStudio Dashboard (test_stream)'), findsOneWidget);
    expect(find.text('Overlay & Lower-Third Editor'), findsOneWidget);
    expect(find.text('Remote Camera & Audio Controls'), findsOneWidget);
  });
}
