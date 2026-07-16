import 'dart:io';

import 'package:flowery/modules/profile/presentation/view_models/cubit/uplaod_profile_photo_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/upload_profile_photo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarPicker extends StatelessWidget {
  final String fallbackPhotoUrl;
  final VoidCallback onTap;

  const AvatarPicker({required this.fallbackPhotoUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UplaodProfilePhotoViewModel, UploadProfilePhotoState>(
      builder: (context, state) {
        final File? pickedFile = state.pickedFile;
        final String photoUrl = fallbackPhotoUrl;

        return Center(
          child: GestureDetector(
            onTap: onTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: pickedFile != null
                      ? FileImage(pickedFile)
                      : (photoUrl.isNotEmpty
                            ? NetworkImage(photoUrl) as ImageProvider
                            : null),
                  child: (pickedFile == null && photoUrl.isEmpty)
                      ? const Icon(Icons.person, size: 40, color: Colors.grey)
                      : null,
                ),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
