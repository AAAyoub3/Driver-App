import 'package:flowery/modules/profile/domain/entities/my_profile_entity.dart';
import 'package:flutter/material.dart';

class VehicleInfoCard extends StatelessWidget {
  final MyProfileEntity data;
  const VehicleInfoCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Vehicle info',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  Text(data.vehicleType,
                      style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(height: 2),
                  Text(data.vehicleNumber,
                      style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}