import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EquipmentMenuPage extends StatelessWidget {
  final String equipmentId;
  
  const EquipmentMenuPage({
    super.key,
    @PathParam('equipmentId') required this.equipmentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Equipment Menu: $equipmentId')),
      body: Center(child: Text('Equipment Menu Page: $equipmentId')),
    );
  }
}
