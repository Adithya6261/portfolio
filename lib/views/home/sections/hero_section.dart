import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/breakpoints.dart';
import '../../../controllers/home_controller.dart';
import '../../../widgets/fade_in.dart';
import '../../../widgets/section_container.dart';
import 'hero/hero_content_column.dart';
import 'hero/hero_stats_strip.dart';
import 'hero/hero_visual.dart';

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
          mobile: 60,
          tablet: 80,
          desktop: 110,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.isMobile
              ? const HeroStackedLayout()
              : const HeroSplitLayout(),
          const SizedBox(height: 56),
          const FadeInUp(
            delay: Duration(milliseconds: 520),
            child: HeroStatsStrip(),
          ),
        ],
      ),
    );
  }
}

class HeroSplitLayout extends StatelessWidget {
  const HeroSplitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Expanded(
          flex: 6,
          child: FadeInUp(child: HeroContentColumn()),
        ),
        SizedBox(width: 48),
        Expanded(
          flex: 5,
          child: FadeInUp(
            delay: Duration(milliseconds: 200),
            child: HeroVisual(),
          ),
        ),
      ],
    );
  }
}

class HeroStackedLayout extends StatelessWidget {
  const HeroStackedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        FadeInUp(child: HeroContentColumn()),
        SizedBox(height: 48),
        FadeInUp(
          delay: Duration(milliseconds: 200),
          child: SizedBox(
            height: 360,
            child: HeroVisual(),
          ),
        ),
      ],
    );
  }
}
