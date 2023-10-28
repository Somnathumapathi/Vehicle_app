import 'package:flutter/material.dart';
import 'package:vehicleapp/views/vehiclePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //     options: FirebaseOptions(
      //   apiKey: "AIzaSyAqtOi7tui-aFiKqIqpB5wKcgOPqV2dP4Y",
      //   appId: "1092970803803",
      //   messagingSenderId: "",
      //   projectId: "vehicleinfozyl",
      // ),
      );
  runApp(const VehicleApp());
}

class VehicleApp extends StatelessWidget {
  const VehicleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VehiclePage(),
    );
  }
}
