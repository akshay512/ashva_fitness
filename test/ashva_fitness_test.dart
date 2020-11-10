import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ashva_fitness/ashva_fitness.dart';

void main() {
  const MethodChannel channel = MethodChannel('ashva_fitness');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AshvaFitness.platformVersion, '42');
  });
}
