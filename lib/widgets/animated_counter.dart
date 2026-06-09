import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final String value;
  final TextStyle style;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.value,
    required this.style,
    this.duration = const Duration(milliseconds: 1400),
  });

  @override
  State<AnimatedCounter> createState() => AnimatedCounterState();
}

class AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  double targetNumber = 0;
  int decimals = 0;
  String suffix = '';
  String prefix = '';

  @override
  void initState() {
    super.initState();
    parseValue();
    controller = AnimationController(vsync: this, duration: widget.duration);
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.forward());
  }

  void parseValue() {
    final match = RegExp(r'(\d+(?:\.\d+)?)').firstMatch(widget.value);
    if (match == null) {
      suffix = widget.value;
      return;
    }
    final numStr = match.group(1)!;
    targetNumber = double.parse(numStr);
    final dotIndex = numStr.indexOf('.');
    decimals = dotIndex == -1 ? 0 : numStr.length - dotIndex - 1;
    prefix = widget.value.substring(0, match.start);
    suffix = widget.value.substring(match.end);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String formatShown(double value) {
    if (decimals == 0) return value.round().toString();
    return value.toStringAsFixed(decimals);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final eased = Curves.easeOutCubic.transform(controller.value);
        final shown = formatShown(targetNumber * eased);
        return Text('$prefix$shown$suffix', style: widget.style);
      },
    );
  }
}
