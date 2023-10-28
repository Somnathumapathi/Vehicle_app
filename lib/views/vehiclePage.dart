import 'package:flutter/material.dart';
import 'package:vehicleapp/widgets/vehiclelist.dart';
import 'package:vehicleapp/widgets/vehiclelist.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle List'),
        leading: const Icon(
          Icons.car_repair_outlined,
        ),
        backgroundColor: const Color.fromARGB(255, 6, 87, 8),
      ),
      body: const Vehiclelist(),
      backgroundColor: Color.fromARGB(255, 189, 190, 190),
    );
  }
}
