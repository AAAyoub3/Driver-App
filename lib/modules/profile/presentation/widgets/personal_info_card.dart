import 'package:flowery/modules/profile/domain/entities/my_profile_entity.dart';
import 'package:flutter/material.dart';

class PersonalInfoCard extends StatelessWidget {
  final MyProfileEntity data;
  const PersonalInfoCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(data.photo),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.fullName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(data.email,
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 2),
                  Text(data.phone,
                      style: TextStyle(color: Colors.grey[600])),
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