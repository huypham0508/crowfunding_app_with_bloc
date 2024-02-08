import 'package:crowfunding_app_with_bloc/app/modules/auth/views/auth_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test auth page', (widgetTester) async {
    await widgetTester.pumpWidget(const AuthView());
    expect(2 + 2, 4);
  });
}
