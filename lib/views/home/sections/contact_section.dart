import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../app/constants/breakpoints.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_theme.dart';
import '../../../controllers/contact_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/section_container.dart';
import 'contact/contact_info_column.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return SectionContainer(
      sectionKey: home.sectionKeys[SectionId.contact],
      child: RevealOnScroll(
        child: GlassCard(
          padding: EdgeInsets.all(
            context.responsive<double>(mobile: 24, tablet: 36, desktop: 48),
          ),
          child: context.isDesktop
              ? buildDesktop(context)
              : buildStacked(context),
        ),
      ),
    );
  }

  Widget buildDesktop(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: ContactInfoColumn()),
        SizedBox(width: 48),
        Expanded(flex: 6, child: ContactForm()),
      ],
    );
  }

  Widget buildStacked(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactInfoColumn(),
        SizedBox(height: 36),
        ContactForm(),
      ],
    );
  }
}

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    final contact = Get.find<ContactController>();
    return Form(
      key: contact.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabeledField(
            label: 'Your name',
            child: TextFormField(
              controller: contact.nameController,
              validator: contact.validateName,
              style: TextStyle(color: context.textColor),
              decoration: inputDecoration(context, hint: 'e.g. John Doe'),
            ),
          ),
          const SizedBox(height: 18),
          LabeledField(
            label: 'Your email',
            child: TextFormField(
              controller: contact.emailController,
              validator: contact.validateEmail,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: context.textColor),
              decoration:
                  inputDecoration(context, hint: 'e.g. you@company.com'),
            ),
          ),
          const SizedBox(height: 18),
          LabeledField(
            label: 'Subject',
            child: TextFormField(
              controller: contact.subjectController,
              validator: contact.validateSubject,
              style: TextStyle(color: context.textColor),
              decoration: inputDecoration(context, hint: 'e.g. Job opportunity'),
            ),
          ),
          const SizedBox(height: 18),
          LabeledField(
            label: 'Message',
            child: TextFormField(
              controller: contact.messageController,
              validator: contact.validateMessage,
              maxLines: 5,
              style: TextStyle(color: context.textColor),
              decoration: inputDecoration(
                context,
                hint: 'Tell me about the role or project...',
              ),
            ),
          ),
          const SizedBox(height: 22),
          Obx(
            () => GradientButton(
              label: resolveLabel(contact),
              icon: resolveIcon(contact),
              onPressed: contact.submit,
            ),
          ),
        ],
      ),
    );
  }

  String resolveLabel(ContactController contact) {
    if (contact.isSent.value) return 'Message sent — I will reply soon';
    if (contact.isSubmitting.value) return 'Sending...';
    return 'Send message';
  }

  IconData resolveIcon(ContactController contact) {
    if (contact.isSent.value) return Icons.check_rounded;
    if (contact.isSubmitting.value) return Icons.hourglass_top_rounded;
    return Icons.send_rounded;
  }

  InputDecoration inputDecoration(
    BuildContext context, {
    required String hint,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: context.borderColor),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: context.mutedColor),
      filled: true,
      fillColor: context.isDark
          ? Colors.white.withValues(alpha: 0.03)
          : Colors.black.withValues(alpha: 0.025),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.brandMid, width: 1.5),
      ),
    );
  }
}

class LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const LabeledField({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.mono(context.mutedColor, size: 12)
              .copyWith(letterSpacing: 1.6),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
