import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/theme/app_colors.dart';
import '../controllers/home_controller.dart';

class ScrollProgressBar extends StatelessWidget {
  const ScrollProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(
      () => Container(
        height: 3,
        color: Colors.transparent,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: controller.scrollProgress.value,
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.brandGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.brandStart,
                  blurRadius: 8,
                  spreadRadius: -1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
