import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../app/constants/breakpoints.dart';
import '../../../controllers/home_controller.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/section_container.dart';
import 'hero/hero_content_column.dart';
import 'hero/hero_stats_strip.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    return SectionContainer(
      sectionKey: home.sectionKeys[SectionId.hero],
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive<double>(
          mobile: 20,
          tablet: 32,
          desktop: 48,
        ),
        vertical: context.responsive<double>(
          mobile: 20,
          tablet: 24,
          desktop: 28,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(child: HeroContentColumn()),
          SizedBox(height: 28),
          FadeInUp(
            delay: Duration(milliseconds: 520),
            child: HeroStatsStrip(),
          ),
        ],
      ),
    );
  }
}
