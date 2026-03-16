import 'package:flutter/material.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../routes/navigation_helper.dart';
import '../../../../state/models/user_state.dart';

/// Profile header – horizontal layout: avatar on left, info on right.
class ProfileHeader extends StatelessWidget {
  final UserState userState;

  const ProfileHeader({super.key, required this.userState});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 91,
            height: 91,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primaryContainer,
            ),
            child: userState.user?.profileURL != null
                ? ClipOval(
                    child: userState.user!.profileURL!.startsWith('assets/')
                        ? Image.asset(
                            userState.user!.profileURL!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildInitialAvatar(
                                  context,
                                  theme,
                                  colorScheme,
                                ),
                          )
                        : Image.network(
                            userState.user!.profileURL!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildInitialAvatar(
                                  context,
                                  theme,
                                  colorScheme,
                                ),
                          ),
                  )
                : _buildInitialAvatar(context, theme, colorScheme),
          ),

          const SizedBox(width: 16),

          // Name, email and edit button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full name
                Text(
                  userState.userFullName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 2),

                // Email
                Text(
                  userState.user?.email ?? 'DomraTech@gmail.com',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),

                const SizedBox(height: 10),

                // Edit Profile Button
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () => context.goToEditProfile(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.editProfile,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialAvatar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    final initial = userState.user?.firstName?.isNotEmpty == true
        ? userState.user!.firstName![0].toUpperCase()
        : '';

    return Center(
      child: Text(
        initial,
        style: theme.textTheme.headlineMedium?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
