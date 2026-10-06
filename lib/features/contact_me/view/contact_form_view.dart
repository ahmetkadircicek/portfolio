import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/padding_constants.dart';
import 'package:portfolio/core/extensions/general_extensions.dart';
import 'package:portfolio/core/init/service/firebase_service.dart';
import 'package:portfolio/features/contact_me/view/contacts_navigation_bar_widget.dart';
import 'package:provider/provider.dart';
import '../viewmodel/contact_form_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ContactFormViewModel>(context);

    return Scaffold(
      body: viewModel.formSubmitted
          ? _buildSuccessContent(context, viewModel)
          : Column(
              children: [
                const ContactsNavigationBarWidget(),
                Expanded(child: _buildForm(context, viewModel)),
              ],
            ),
    );
  }

  Widget _buildSuccessContent(BuildContext context, ContactFormViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Thank You!',
              style: GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.headlineMedium),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Your message has been sent successfully. I will get back to you soon.',
              style: GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.bodyLarge),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.resetForm();
                    _nameController.clear();
                    _emailController.clear();
                    _subjectController.clear();
                    _messageController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Send Another Message',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: context.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, ContactFormViewModel viewModel) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: PaddingConstants.allLarge,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'I\'d love to hear from you',
                    style: GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.headlineSmall),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fill out the form below and I\'ll get back to you as soon as possible.',
                    style: GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.bodyLarge),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Name field
                  _buildInputField(
                    label: 'Name',
                    hintText: 'Your full name',
                    controller: _nameController,
                    validator: viewModel.validateName,
                    onSaved: (value) => viewModel.name = value ?? '',
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),

                  // Email field
                  _buildInputField(
                    label: 'Email',
                    hintText: 'your.email@example.com',
                    controller: _emailController,
                    validator: viewModel.validateEmail,
                    onSaved: (value) => viewModel.email = value ?? '',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 20),

                  // Subject field
                  _buildInputField(
                    label: 'Subject',
                    hintText: 'What is this regarding?',
                    controller: _subjectController,
                    validator: viewModel.validateSubject,
                    onSaved: (value) => viewModel.subject = value ?? '',
                    prefixIcon: Icons.subject,
                  ),
                  const SizedBox(height: 20),

                  // Message field
                  _buildInputField(
                    label: 'Message',
                    hintText: 'Write your message here...',
                    controller: _messageController,
                    validator: viewModel.validateMessage,
                    onSaved: (value) => viewModel.message = value ?? '',
                    maxLines: 1,
                    expandable: true,
                    prefixIcon: Icons.message_outlined,
                  ),
                  const SizedBox(height: 48),
                  if (viewModel.errorMessage != null) ...[
                    Text(
                      viewModel.errorMessage!,
                      style: GoogleFonts.montserrat(fontSize: 14, color: context.error),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                  ] else
                    const SizedBox(height: 16),
                  // Submit button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: viewModel.isSending
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              await viewModel.submitForm();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: viewModel.isSending
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                            )
                          : Text(
                              'Send Message',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: context.primary,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required Function(String?)? onSaved,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool expandable = false,
    IconData? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          cursorColor: context.onPrimary,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: PaddingConstants.allMedium,
            filled: true,
            fillColor: context.secondary,
          ),
          style: GoogleFonts.montserrat(fontSize: 16),
          keyboardType: keyboardType,
          textInputAction: maxLines > 1 ? null : TextInputAction.next,
          maxLines: expandable ? null : maxLines,
          minLines: expandable ? maxLines : null,
          expands: false,
          validator: validator,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
