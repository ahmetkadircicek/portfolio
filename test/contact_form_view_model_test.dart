import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/init/service/firebase_service.dart';
import 'package:portfolio/features/contact_me/viewmodel/contact_form_view_model.dart';

class _FakeFirebaseService extends IFirebaseService {
  final bool fail;
  final sent = <Map<String, String>>[];

  _FakeFirebaseService({this.fail = false});

  @override
  Future<void> initialize() async {}

  @override
  Future<void> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    if (fail) throw Exception('offline');
    sent.add({'name': name, 'email': email, 'subject': subject, 'message': message});
  }
}

/// Pumps a form bound to [viewModel] with the given field values.
Future<void> _pumpForm(WidgetTester tester, ContactFormViewModel viewModel, Map<String, String> values) async {
  await tester.pumpWidget(MaterialApp(
    home: Material(
      child: Form(
        key: viewModel.formKey,
        child: Column(children: [
          TextFormField(initialValue: values['name'], validator: viewModel.validateName, onSaved: (v) => viewModel.name = v ?? ''),
          TextFormField(initialValue: values['email'], validator: viewModel.validateEmail, onSaved: (v) => viewModel.email = v ?? ''),
          TextFormField(initialValue: values['subject'], validator: viewModel.validateSubject, onSaved: (v) => viewModel.subject = v ?? ''),
          TextFormField(initialValue: values['message'], validator: viewModel.validateMessage, onSaved: (v) => viewModel.message = v ?? ''),
        ]),
      ),
    ),
  ));
}

const _valid = {
  'name': '  Ada Lovelace ',
  'email': 'ada@example.agency',
  'subject': 'Project',
  'message': 'I would like an app built.',
};

void main() {
  group('validators', () {
    final viewModel = ContactFormViewModel(firebaseService: _FakeFirebaseService());

    test('email accepts long TLDs and rejects malformed addresses', () {
      expect(viewModel.validateEmail('ada@example.agency'), isNull);
      expect(viewModel.validateEmail('ada@sub.example.com.tr'), isNull);
      expect(viewModel.validateEmail('ada@example'), isNotNull);
      expect(viewModel.validateEmail('ada example@x.com'), isNotNull);
      expect(viewModel.validateEmail('a' * 200 + '@x.com'), isNotNull);
    });

    test('blank and oversized fields are rejected', () {
      expect(viewModel.validateName('   '), isNotNull);
      expect(viewModel.validateName('a' * (ContactFormViewModel.maxNameLength + 1)), isNotNull);
      expect(viewModel.validateSubject(''), isNotNull);
      expect(viewModel.validateMessage('too short'), isNotNull);
      expect(viewModel.validateMessage('         x'), isNotNull);
      expect(viewModel.validateMessage('a' * (ContactFormViewModel.maxMessageLength + 1)), isNotNull);
      expect(viewModel.validateMessage('long enough message'), isNull);
    });
  });

  testWidgets('a valid form is sent trimmed and marked submitted', (tester) async {
    final service = _FakeFirebaseService();
    final viewModel = ContactFormViewModel(firebaseService: service);
    await _pumpForm(tester, viewModel, _valid);

    expect(await viewModel.submitForm(), isTrue);
    expect(viewModel.formSubmitted, isTrue);
    expect(viewModel.errorMessage, isNull);
    expect(service.sent.single['name'], 'Ada Lovelace');
  });

  testWidgets('a failed send shows an error and allows retrying', (tester) async {
    final viewModel = ContactFormViewModel(firebaseService: _FakeFirebaseService(fail: true));
    await _pumpForm(tester, viewModel, _valid);

    expect(await viewModel.submitForm(), isFalse);
    expect(viewModel.formSubmitted, isFalse);
    expect(viewModel.isSending, isFalse);
    expect(viewModel.errorMessage, isNotNull);
  });

  testWidgets('an invalid form is not sent', (tester) async {
    final service = _FakeFirebaseService();
    final viewModel = ContactFormViewModel(firebaseService: service);
    await _pumpForm(tester, viewModel, {..._valid, 'email': 'nope'});

    expect(await viewModel.submitForm(), isFalse);
    expect(service.sent, isEmpty);
  });
}
