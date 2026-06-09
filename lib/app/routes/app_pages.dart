import 'package:get/get.dart';
import '../../views/home/home_view.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/contact_controller.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(HomeController.new);
        Get.lazyPut<ContactController>(ContactController.new);
      }),
    ),
  ];
}
