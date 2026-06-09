import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../controllers/contact_controller.dart';
import '../../../../data/portfolio_data.dart';
import '../../../../models/contact_item.dart';
import '../../../../services/download_helper.dart';
import '../../../../widgets/gradient_button.dart';
import '../../../../widgets/gradient_text.dart';

class ContactInfoColumn extends StatelessWidget {
  const ContactInfoColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactHeadline(theme: theme),
        const SizedBox(height: 28),
        const ContactCardList(),
        const SizedBox(height: 14),
        const AvailabilityCard(),
        const SizedBox(height: 24),
        const ResumeDownloadButton(),
        const SizedBox(height: 22),
        const SocialIconRow(),
      ],
    );
  }
}

class ContactHeadline extends StatelessWidget {
  final ThemeData theme;
  const ContactHeadline({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GET IN TOUCH',
          style: theme.textTheme.labelSmall?.copyWith(
            color: AppColors.brandMid,
            letterSpacing: 2.4,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        RichText(
          text: TextSpan(
            style: theme.textTheme.displaySmall,
            children: [
              const TextSpan(text: "Let's build "),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: GradientText(
                  'something great',
                  style: theme.textTheme.displaySmall,
                  gradient: AppColors.textGradient(),
                ),
              ),
              const TextSpan(text: ' together.'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Hiring, freelance, or just want to chat about mobile architecture? '
          'Drop a message — quickest reply is via email.',
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class ContactCardList extends StatelessWidget {
  const ContactCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < PortfolioData.contactItems.length; i++) ...[
          ContactCard(item: PortfolioData.contactItems[i]),
          if (i < PortfolioData.contactItems.length - 1)
            const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class ContactCard extends StatefulWidget {
  final ContactItem item;
  const ContactCard({super.key, required this.item});

  @override
  State<ContactCard> createState() => ContactCardState();
}

class ContactCardState extends State<ContactCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final contact = Get.find<ContactController>();
    return MouseRegion(
      cursor: widget.item.link != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: () {
          final link = widget.item.link;
          if (link != null) contact.openLink(link);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: context.isDark
                ? AppColors.darkSurface.withValues(alpha: hovered ? 0.95 : 0.8)
                : AppColors.lightSurface
                    .withValues(alpha: hovered ? 1.0 : 0.92),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: hovered
                  ? AppColors.brandMid.withValues(alpha: 0.55)
                  : context.borderColor,
            ),
          ),
          child: Row(
            children: [
              ContactCardIcon(icon: widget.item.icon),
              const SizedBox(width: 14),
              Expanded(child: ContactCardText(item: widget.item)),
              if (widget.item.copyable) CopyButton(item: widget.item),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactCardIcon extends StatelessWidget {
  final IconData icon;
  const ContactCardIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.brandStart.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppColors.brandMid, size: 18),
    );
  }
}

class ContactCardText extends StatelessWidget {
  final ContactItem item;
  const ContactCardText({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: AppTextStyles.mono(context.mutedColor, size: 11)
              .copyWith(letterSpacing: 1.6),
        ),
        const SizedBox(height: 2),
        Text(
          item.value,
          style: TextStyle(
            color: context.textColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class CopyButton extends StatelessWidget {
  final ContactItem item;
  const CopyButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final contact = Get.find<ContactController>();
    return Obx(() {
      final copied = contact.copiedField.value == item.title;
      return IconButton(
        tooltip: copied ? 'Copied!' : 'Copy ${item.title}',
        onPressed: () => contact.copyValue(item.value, item.title),
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, anim) => ScaleTransition(
            scale: anim,
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: Icon(
            copied ? Icons.check_rounded : Icons.copy_rounded,
            key: ValueKey(copied),
            size: 16,
            color: copied ? AppColors.accentEmerald : context.mutedColor,
          ),
        ),
      );
    });
  }
}

class AvailabilityCard extends StatelessWidget {
  const AvailabilityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.accentEmerald.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.accentEmerald.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accentEmerald.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.accentEmerald,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AVAILABILITY',
                  style: AppTextStyles.mono(
                    AppColors.accentEmerald,
                    size: 11,
                  ).copyWith(letterSpacing: 1.6, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  PortfolioData.availabilityLabel,
                  style: TextStyle(
                    color: context.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const PulsingDot(),
        ],
      ),
    );
  }
}

class PulsingDot extends StatefulWidget {
  const PulsingDot({super.key});

  @override
  State<PulsingDot> createState() => PulsingDotState();
}

class PulsingDotState extends State<PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value;
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.accentEmerald,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.accentEmerald.withValues(alpha: 0.5 * (1 - t)),
                blurRadius: 6 + 10 * t,
                spreadRadius: 1 + 4 * t,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ResumeDownloadButton extends StatelessWidget {
  const ResumeDownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      label: 'Download Resume (PDF)',
      icon: Icons.picture_as_pdf_outlined,
      onPressed: () => DownloadHelper.triggerDownload(
        PortfolioData.resumeFileName,
        suggestedName: PortfolioData.resumeFileName,
      ),
    );
  }
}

class SocialIconRow extends StatelessWidget {
  const SocialIconRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SocialIconButton(
          icon: Icons.business_center_outlined,
          label: 'LinkedIn',
          url: PortfolioData.linkedIn,
        ),
        SizedBox(width: 10),
        SocialIconButton(
          icon: Icons.code_rounded,
          label: 'GitHub',
          url: PortfolioData.github,
        ),
      ],
    );
  }
}

class SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<SocialIconButton> createState() => SocialIconButtonState();
}

class SocialIconButtonState extends State<SocialIconButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final contact = Get.find<ContactController>();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: () => contact.openLink(widget.url),
        child: Tooltip(
          message: widget.label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: hovered ? AppColors.brandGradient : null,
              color: hovered
                  ? null
                  : (context.isDark
                      ? Colors.white.withValues(alpha: 0.04)
                      : Colors.black.withValues(alpha: 0.04)),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hovered ? Colors.transparent : context.borderColor,
              ),
            ),
            child: Icon(
              widget.icon,
              size: 18,
              color: hovered ? Colors.white : context.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
