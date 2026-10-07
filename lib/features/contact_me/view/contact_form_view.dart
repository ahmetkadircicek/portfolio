import 'package:flutter/material.dart';
import 'package:portfolio/core/components/page_frame.dart';
import 'package:portfolio/core/components/primary_button.dart';
import 'package:portfolio/core/components/reveal.dart';
import 'package:portfolio/core/components/section_header.dart';
import 'package:portfolio/core/components/site_header.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/init/service/firebase_service.dart';
import 'package:portfolio/core/theme/app_tokens.dart';
import 'package:provider/provider.dart';
import '../viewmodel/contact_form_view_model.dart';

class ContactFormView extends StatelessWidget {
  const ContactFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactFormViewModel(),
      child: const _ContactForm(),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Firebase (about 1 MB of JavaScript) is only needed here, so it loads
    // when the form opens rather than on every visit.
    FirebaseService().initialize().ignore();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _reset(ContactFormViewModel viewModel) {
    viewModel.resetForm();
    _nameController.clear();
    _emailController.clear();
    _subjectController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ContactFormViewModel>(context);
    final desktop = context.isDesktop;
    final intro = _Intro(sent: viewModel.formSubmitted);
    final body = viewModel.formSubmitted ? _Success(onSendAnother: () => _reset(viewModel)) : _buildForm(viewModel);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SiteHeader(),
            PageFrame(
              child: Padding(
                padding:
                    EdgeInsets.only(top: context.isMobile ? AppSpace.x8 : AppSpace.x16, bottom: context.sectionGap),
                child: desktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppSpace.x24,
                        children: [Expanded(flex: 5, child: intro), Expanded(flex: 6, child: body)],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: AppSpace.x12,
                        children: [intro, body],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(ContactFormViewModel viewModel) {
    return Reveal(
      delay: const Duration(milliseconds: 120),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpace.x6,
          children: [
            _Field(
              label: 'Name',
              hintText: 'Your full name',
              controller: _nameController,
              validator: viewModel.validateName,
              onSaved: (value) => viewModel.name = value ?? '',
              keyboardType: TextInputType.name,
              autofillHints: const [AutofillHints.name],
            ),
            _Field(
              label: 'Email',
              hintText: 'your.email@example.com',
              controller: _emailController,
              validator: viewModel.validateEmail,
              onSaved: (value) => viewModel.email = value ?? '',
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
            ),
            _Field(
              label: 'Subject',
              hintText: 'What is this regarding?',
              controller: _subjectController,
              validator: viewModel.validateSubject,
              onSaved: (value) => viewModel.subject = value ?? '',
            ),
            _Field(
              label: 'Message',
              hintText: 'Write your message here...',
              controller: _messageController,
              validator: viewModel.validateMessage,
              onSaved: (value) => viewModel.message = value ?? '',
              multiline: true,
            ),
            if (viewModel.errorMessage != null)
              Text(viewModel.errorMessage!, style: context.text.bodySmall.copyWith(color: AppColors.error)),
            const SizedBox(height: AppSpace.x2),
            Align(
              alignment: Alignment.centerLeft,
              child: PrimaryButton(
                label: 'Send message',
                loading: viewModel.isSending,
                expand: context.isMobile,
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await viewModel.submitForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  final bool sent;
  const _Intro({required this.sent});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Reveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('Contact'),
          const SizedBox(height: AppSpace.x4),
          Semantics(header: true, child: Text(sent ? 'THANK YOU!' : 'REQUEST A PROJECT', style: text.h1)),
          const SizedBox(height: AppSpace.x6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Text(
              sent
                  ? 'Your message has been sent successfully. I will get back to you soon.'
                  : 'I\'d love to hear from you. Fill out the form and I\'ll get back to you as soon as possible.',
              style: text.bodyLarge.copyWith(color: AppColors.inkMuted),
            ),
          ),
        ],
      ),
    );
  }
}

class _Success extends StatelessWidget {
  final VoidCallback onSendAnother;
  const _Success({required this.onSendAnother});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpace.x8),
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: AppRadius.lgAll),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpace.x6,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.statusReady.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: AppColors.statusReady, size: 28),
          ),
          Text('Message sent', style: context.text.h3),
          PrimaryButton(label: 'Send another message', onPressed: onSendAnother),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextInputType keyboardType;
  final bool multiline;
  final Iterable<String>? autofillHints;

  const _Field({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.validator,
    required this.onSaved,
    this.keyboardType = TextInputType.text,
    this.multiline = false,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    OutlineInputBorder border(Color color, [double width = 1]) => OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: color, width: width),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpace.x2,
      children: [
        Eyebrow(label, color: AppColors.inkMuted),
        TextFormField(
          controller: controller,
          cursorColor: AppColors.ink,
          style: text.body,
          keyboardType: multiline ? TextInputType.multiline : keyboardType,
          textInputAction: multiline ? TextInputAction.newline : TextInputAction.next,
          minLines: multiline ? 5 : 1,
          maxLines: multiline ? null : 1,
          autofillHints: autofillHints,
          validator: validator,
          onSaved: onSaved,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: text.body.copyWith(color: AppColors.inkSubtle),
            errorStyle: text.bodySmall.copyWith(color: AppColors.error, height: 1.4),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.all(AppSpace.x4 + 2),
            border: border(Colors.transparent),
            enabledBorder: border(Colors.transparent),
            focusedBorder: border(AppColors.ink, 1.5),
            errorBorder: border(AppColors.error),
            focusedErrorBorder: border(AppColors.error, 1.5),
          ),
        ),
      ],
    );
  }
}
