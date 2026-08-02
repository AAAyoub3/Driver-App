import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/my_profiel_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/my_profile_event.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/get_profile_data_state.dart';
import 'package:flowery/modules/profile/presentation/widgets/personal_info_card.dart';
import 'package:flowery/modules/profile/presentation/widgets/settings_tile.dart';
import 'package:flowery/modules/profile/presentation/widgets/vehicle_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyProfielViewModel>().doEvent(GetMyprofileData());
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(localizations.profile),
        actions: [Icon(Icons.notifications_none)],
      ),
      body: BlocBuilder<MyProfielViewModel, GetProfileDataState>(
        builder: (context, state) {
          if (state.isLoadingData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }
          final data = state.data;
          if (data == null) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                PersonalInfoCard(data: data),
                const SizedBox(height: 16),
                VehicleInfoCard(data: data),
                SettingsTile(
                  icon: Icons.language,
                  title: localizations.language,
                  trailing: Text(
                    localizations.english,
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    // Change language
                  },
                ),
                SettingsTile(
                  icon: Icons.logout,
                  title: "Logout",
                  trailing: const Icon(Icons.logout_outlined),
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => const loginScreen()),
                    // );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
