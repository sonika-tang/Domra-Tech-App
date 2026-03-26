import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/navigation_helper.dart';
import '../../../state/models/user_state.dart';
import '../../../state/provider/auth_provider.dart';
import '../../widgets/actions/primary_button.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = context.read<AuthProvider>();
      final jwt = authProvider.jwt;
      if (jwt != null) {
        context.read<UserNotifier>().fetchUserProfile(jwt);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.navProfile,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer2<UserNotifier, AuthProvider>(
        builder: (context, userProvider, authProvider, child) {
          final userState = userProvider.state;

          if (userState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userState.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userState.error!,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: t.returnHome,
                    onPressed: () => context.goToHome(),
                  ),
                ],
              ),
            );
          }

          // final user = userState.user;

          return RefreshIndicator(
            onRefresh: () async {
              final jwt = authProvider.jwt;
              if (jwt != null) {
                await userProvider.refresh(jwt);
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ProfileHeader(userState: userState),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ProfileMenuItem(
                          icon: Icons.language,
                          label: t.language,
                          onPressed: () => context.goToChangeLanguage(),
                        ),
                        const SizedBox(height: 12),
                        ProfileMenuItem(
                          icon: Icons.history,
                          label: t.viewHistory,
                          onPressed: () => context.goToHistoryAll(),
                        ),
                        const SizedBox(height: 12),
                        ProfileMenuItem(
                          icon: Icons.lock,
                          label: t.changePassword,
                          onPressed: () => context.goToChangePassword(),
                        ),
                        const SizedBox(height: 12),
                        ProfileMenuItem(
                          icon: Icons.info_outline,
                          label: t.termOfCondition,
                          onPressed: () => context.goToTermsAndConditions(),
                        ),
                        const SizedBox(height: 12),
                        ProfileMenuItem(
                          icon: Icons.shopping_cart_outlined,
                          label: t.subscriptionPlans,
                          onPressed: () => context.goToSubscriptionPlans(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      color: colorScheme.outline.withValues(alpha: 0.2),
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildLogoutButton(context, authProvider, theme),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogoutButton(
    BuildContext context,
    AuthProvider authProvider,
    ThemeData theme,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showLogoutConfirmation(context, authProvider),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Icon(Icons.exit_to_app, color: AppColors.error, size: 22),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.logout,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(
    BuildContext context,
    AuthProvider authProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.logout),
        content: Text(
          'Are you sure you want to logout?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.confirm,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              authProvider.logout();
              context.read<UserNotifier>().clearUserData();
              context.logoutAndGoToWelcome();
            },
            child: Text(
              AppLocalizations.of(context)!.logout,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
