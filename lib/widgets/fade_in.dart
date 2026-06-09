import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class FadeInUp extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;

  const FadeInUp({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 700),
    this.offset = 28,
  });

  @override
  State<FadeInUp> createState() => FadeInUpState();
}

class FadeInUpState extends State<FadeInUp>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    Future.delayed(widget.delay, () {
      if (mounted) controller.forward();
    });
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
      builder: (context, child) {
        final eased = Curves.easeOutCubic.transform(controller.value);
        return Opacity(
          opacity: eased,
          child: Transform.translate(
            offset: Offset(0, widget.offset * (1 - eased)),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.offset = 36,
  });

  @override
  State<RevealOnScroll> createState() => RevealOnScrollState();
}

class RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final GlobalKey targetKey = GlobalKey();
  Worker? progressWorker;
  bool revealed = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkVisible();
      if (revealed) return;
      final home = Get.find<HomeController>();
      progressWorker = ever<double>(home.scrollProgress, (_) => checkVisible());
    });
  }

  void checkVisible() {
    if (revealed || !mounted) return;
    final ctx = targetKey.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject();
    if (box is! RenderBox || !box.attached) return;
    final position = box.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.sizeOf(context).height;
    if (position.dy < screenHeight * 0.92) {
      revealed = true;
      controller.forward();
      progressWorker?.dispose();
    }
  }

  @override
  void dispose() {
    progressWorker?.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final eased = Curves.easeOutCubic.transform(controller.value);
        return Opacity(
          opacity: revealed ? eased : 0,
          child: Transform.translate(
            offset: Offset(0, widget.offset * (1 - eased)),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(key: targetKey, child: widget.child),
    );
  }
}
