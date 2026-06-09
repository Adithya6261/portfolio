import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/breakpoints.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_theme.dart';
import '../../../controllers/contact_controller.dart';
import '../../../data/portfolio_data.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive<double>(
          mobile: 20,
          tablet: 32,
          desktop: 48,
        ),
        vertical: 36,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.borderColor)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.maxContent),
          child: context.isMobile
              ? const FooterStacked()
              : const FooterRow(),
        ),
      ),
    );
  }
}

class FooterRow extends StatelessWidget {
  const FooterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        FooterCopyright(),
        Spacer(),
        FooterLinks(),
      ],
    );
  }
}

class FooterStacked extends StatelessWidget {
  const FooterStacked({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FooterLinks(),
        SizedBox(height: 16),
        FooterCopyright(),
      ],
    );
  }
}

class FooterCopyright extends StatelessWidget {
  const FooterCopyright({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '© ${DateTime.now().year} ${PortfolioData.name}. '
      'Built with Flutter + GetX.',
      style: AppTextStyles.mono(context.mutedColor, size: 12),
    );
  }
}

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final contact = Get.find<ContactController>();
    return Wrap(
      spacing: 18,
      runSpacing: 8,
      children: [
        FooterLink(
          label: 'Email',
          onTap: () => contact.openLink('mailto:${PortfolioData.email}'),
        ),
        FooterLink(
          label: 'LinkedIn',
          onTap: () => contact.openLink(PortfolioData.linkedIn),
        ),
        FooterLink(
          label: 'GitHub',
          onTap: () => contact.openLink(PortfolioData.github),
        ),
      ],
    );
  }
}

class FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const FooterLink({super.key, required this.label, required this.onTap});

  @override
  State<FooterLink> createState() => FooterLinkState();
}

class FooterLinkState extends State<FooterLink> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: TextStyle(
            color: hovered ? AppColors.brandMid : context.mutedColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
