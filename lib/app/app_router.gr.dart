// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [EquipmentMenuPage]
class EquipmentMenuRoute extends PageRouteInfo<EquipmentMenuRouteArgs> {
  EquipmentMenuRoute({
    Key? key,
    required String equipmentId,
    List<PageRouteInfo>? children,
  }) : super(
         EquipmentMenuRoute.name,
         args: EquipmentMenuRouteArgs(key: key, equipmentId: equipmentId),
         rawPathParams: {'equipmentId': equipmentId},
         initialChildren: children,
       );

  static const String name = 'EquipmentMenuRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EquipmentMenuRouteArgs>(
        orElse: () => EquipmentMenuRouteArgs(
          equipmentId: pathParams.getString('equipmentId'),
        ),
      );
      return EquipmentMenuPage(key: args.key, equipmentId: args.equipmentId);
    },
  );
}

class EquipmentMenuRouteArgs {
  const EquipmentMenuRouteArgs({this.key, required this.equipmentId});

  final Key? key;

  final String equipmentId;

  @override
  String toString() {
    return 'EquipmentMenuRouteArgs{key: $key, equipmentId: $equipmentId}';
  }
}

/// generated route for
/// [EquipmentPage]
class EquipmentRoute extends PageRouteInfo<EquipmentRouteArgs> {
  EquipmentRoute({
    Key? key,
    required String equipmentId,
    List<PageRouteInfo>? children,
  }) : super(
         EquipmentRoute.name,
         args: EquipmentRouteArgs(key: key, equipmentId: equipmentId),
         rawPathParams: {'equipmentId': equipmentId},
         initialChildren: children,
       );

  static const String name = 'EquipmentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EquipmentRouteArgs>(
        orElse: () => EquipmentRouteArgs(
          equipmentId: pathParams.getString('equipmentId'),
        ),
      );
      return EquipmentPage(key: args.key, equipmentId: args.equipmentId);
    },
  );
}

class EquipmentRouteArgs {
  const EquipmentRouteArgs({this.key, required this.equipmentId});

  final Key? key;

  final String equipmentId;

  @override
  String toString() {
    return 'EquipmentRouteArgs{key: $key, equipmentId: $equipmentId}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [InventoryPage]
class InventoryRoute extends PageRouteInfo<void> {
  const InventoryRoute({List<PageRouteInfo>? children})
    : super(InventoryRoute.name, initialChildren: children);

  static const String name = 'InventoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InventoryPage();
    },
  );
}
