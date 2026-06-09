import 'package:flutter/material.dart';
import '../app/constants/breakpoints.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Key? sectionKey;

  const SectionContainer({
    super.key,
    required this.child,
    this.padding,
    this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    final horizontal = context.responsive<double>(
      mobile: 20,
      tablet: 32,
      desktop: 48,
    );
    final vertical = context.responsive<double>(
      mobile: 64,
      tablet: 80,
      desktop: 112,
    );
    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: padding ??
          EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.maxContent),
          child: child,
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final TextAlign align;

  const SectionTitle({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.align = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final crossAlign =
        align == TextAlign.center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        Text(
          eyebrow.toUpperCase(),
          textAlign: align,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.primary,
            letterSpacing: 2.4,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        Text(title, textAlign: align, style: theme.textTheme.displaySmall),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              subtitle!,
              textAlign: align,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ],
    );
  }
}
