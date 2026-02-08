import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EquipmentPage extends StatelessWidget {
  final String equipmentId;
  
  const EquipmentPage({
    super.key,
    @PathParam('equipmentId') required this.equipmentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Equipment: $equipmentId')),
      body: Center(child: Text('Equipment Page: $equipmentId')),
    );
  }
}
