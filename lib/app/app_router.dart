import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/inventory/presentation/pages/inventory_page.dart';
import '../features/equipment/presentation/pages/equipment_page.dart';
import '../features/equipment/presentation/pages/equipment_menu_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      initial: true,
    ),
    AutoRoute(
      page: InventoryRoute.page,
      path: '/inventory',
    ),
    AutoRoute(
      page: EquipmentRoute.page,
      path: '/equipment/:equipmentId',
    ),
    AutoRoute(
      page: EquipmentMenuRoute.page,
      path: '/equipment/menu/:equipmentId',
    ),
  ];
}
