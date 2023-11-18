import 'package:entrance_flutter/app/widgets/nex_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final emailFormKey = GlobalKey<EmailFormFieldState>();
  final passwordFormKey = GlobalKey<PasswordFormFieldState>();
  setUp(() {
    emailFormKey.currentState?.initState();
    passwordFormKey.currentState?.initState();
  });

  setUpAll(() {
    emailFormKey.currentState?.initState();
    passwordFormKey.currentState?.initState();
  });

  testWidgets('EmailFormField validation', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: EmailFormField(
                  key: emailFormKey,
                ),
              ),
            ),
          );
        },
      ),
    );

    final emailFormField = find.byType(EmailFormField);

    // Test case 1: Empty email
    await tester.enterText(emailFormField, '');
    await tester.tap(find.text('Your email'));
    await tester.pump();
    expect(find.text('The email is required'), findsOneWidget);

    // Test case 2: Invalid email format
    await tester.enterText(emailFormField, 'invalidemail');
    await tester.tap(find.text('Your email'));
    await tester.pump();
    expect(find.text('The email is not valid'), findsOneWidget);

    // Test case 3: Valid email
    await tester.enterText(emailFormField, 'valid@email.com');
    await tester.tap(find.text('Your email'));
    await tester.pump();
    expect(find.text('The email is not valid'), findsNothing);
  });

  testWidgets('PasswordFormField validation', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: PasswordFormField(
                  key: passwordFormKey,
                ),
              ),
            ),
          );
        },
      ),
    );

    final passwordFormField = find.byType(PasswordFormField);

    // Test case 1: Empty password
    await tester.enterText(passwordFormField, '');
    await tester.tap(find.text('Your password'));
    await tester.pump();
    expect(find.text('The password is required'), findsOneWidget);

    // Test case 2: Short password
    await tester.enterText(passwordFormField, 'short');
    await tester.tap(find.text('Your password'));
    await tester.pump();
    expect(find.text('Too short'), findsOneWidget);

    // Test case 3: Valid password
    await tester.enterText(passwordFormField, 'validpassword');
    await tester.tap(find.text('Your password'));
    await tester.pump();
    expect(find.text('Too short'), findsNothing);
  });

  testWidgets('PasswordFormField password strength and visibility',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: PasswordFormField(
                  key: passwordFormKey,
                ),
              ),
            ),
          );
        },
      ),
    );

    final passwordFormField = find.byType(PasswordFormField);

    // Test case 1: Toggle password visibility
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pump();
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);

    // Test case 2: Check password strength
    await tester.enterText(passwordFormField, 'strongPassword123');
    await tester.tap(find.text('Your password'));
    await tester.pump();
    expect(find.text('Strong'), findsOneWidget);
  });
}
