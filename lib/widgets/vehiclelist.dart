import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Vehiclelist extends StatelessWidget {
  const Vehiclelist({super.key});

  @override
  Widget build(BuildContext context) {
    String getEfficiency(Map<String, dynamic> vehicle) {
      final mileage = int.tryParse(vehicle['mileage'].toString()) ?? 0;
      final year = int.tryParse(vehicle['year'].toString()) ?? 0;
      final age = (2023 - year);

      if (mileage >= 15 && age <= 5) {
        return 'Less Pollutant and Fuel Efficient';
      } else if (mileage >= 15 && age > 5) {
        return 'Moderately Pollutant and Fuel Efficient';
      } else {
        return 'Highly Pollutant and Not Fuel Efficient';
      }
    }

    Color getColorCode(Map<String, dynamic> vehicle) {
      final mileage = int.tryParse(vehicle['mileage'].toString()) ?? 0;
      final year = int.tryParse(vehicle['year'].toString()) ?? 0;
      final age = (2023 - year);

      if (mileage >= 15 && age <= 5) {
        return Colors.green;
      } else if (mileage >= 15 && age > 5) {
        return Colors.amber;
      } else {
        return Colors.red;
      }
    }

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final vehicles = snapshot.data!.docs;

          return ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index].data();
                final colorCode = getColorCode(vehicle);
                final efficiency = getEfficiency(vehicle);
                // final imageUrl = vehicles[''];
                final gradient = LinearGradient(
                    colors: [colorCode, colorCode.withOpacity(0.5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight);

                // return Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         gradient: gradient,
                //         borderRadius: BorderRadius.circular(8.0)),
                //     child: ListTile(
                //       leading: Image.network(vehicle['image']),
                //       tileColor: colorCode,
                //       title: Text(vehicle['make'] + vehicle['model']),
                //       subtitle: Text('Year: ' +
                //           vehicle['year'].toString() +
                //           ",Mileage: " +
                //           vehicle['mileage'].toString() +
                //           'kmpl' +
                //           "  " +
                //           efficiency),
                //     ),
                //   ),
                // );
                return Card(
                  color: colorCode.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.all(10),
                  child: Column(children: [
                    Image.network(
                      vehicle['image'],
                      fit: BoxFit.cover,
                      height: 200,
                      width: 400,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      vehicle['make'] + '  ' + vehicle['model'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Year: ' +
                          vehicle['year'].toString() +
                          "  Mileage: " +
                          vehicle['mileage'].toString() +
                          'kmpl',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: Text(efficiency),
                    //   style:
                    //       ElevatedButton.styleFrom(backgroundColor: colorCode),
                    // )
                    Text(
                      efficiency,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ]),
                );
              });
        });
  }
}
