import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddressTileWidget extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String address;

  const AddressTileWidget({
    super.key,
    this.imageUrl,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrayColor),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: theme.colorScheme.secondary,
            backgroundImage:
                imageUrl != null &&
                    imageUrl!.isNotEmpty &&
                    imageUrl!.startsWith('http')
                ? NetworkImage(imageUrl!)
                : null,
            child:
                imageUrl == null ||
                    imageUrl!.isEmpty ||
                    !imageUrl!.startsWith('http')
                ? const Icon(Icons.person, color: AppColors.lightGrayColor)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.labelMedium?.copyWith(
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.lightGrayColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        address,
                        style: TextStyle(
                          color: AppColors.lightGrayColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
