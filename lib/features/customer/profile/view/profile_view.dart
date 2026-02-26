import 'package:e_commerce/features/customer/profile/view_model/profile_view_model.dart';
import 'package:e_commerce/features/customer/profile/widget/profile_section_card.dart';
import 'package:e_commerce/features/customer/profile/widget/user_header_section.dart';
import 'package:e_commerce/features/customer/profile/widget/user_stats_card.dart';
import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Mi Perfil",
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: const Icon(Icons.settings_outlined),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 24),

              const UserHeaderSection(),

              const SizedBox(height: 32),

              const UserStatsCard(),

              const SizedBox(height: 32),

              ...viewModel.sections.map((section) {
                return ProfileSectionCard(
                  section: section,
                  onOptionTap: (option) =>
                      viewModel.onOptionSelected(context, option),
                  onActionTap: (section) =>
                      viewModel.onSectionActionSelected(context, section),
                );
              }),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
