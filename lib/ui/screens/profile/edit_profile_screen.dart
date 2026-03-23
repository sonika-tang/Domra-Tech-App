import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../routes/navigation_helper.dart';
import '../../../state/models/user_state.dart';
import '../../../state/provider/auth_provider.dart';
import 'widgets/profile_form.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   late TextEditingController firstNameController;
//   late TextEditingController lastNameController;
//   late TextEditingController emailController;
//   late TextEditingController genderController;
//   late TextEditingController dobController;

//   @override
//   void initState() {
//     super.initState();
//     // final userState = context.read<UserNotifier>().state;
//     // firstNameController = TextEditingController(text: userState.user?.firstName ?? 'oeng'); // dummy mockup default if empty
//     // lastNameController = TextEditingController(text: userState.user?.lastName ?? 'Gechty');
//     // emailController = TextEditingController(text: userState.user?.email ?? 'gechtyoeng@gmail.com');
//     // genderController = TextEditingController(text: 'female');
//     // dobController = TextEditingController(text: '2025/07/07');
//     final userState = context.read<UserNotifier>().state;
//     firstNameController = TextEditingController(
//       text: userState.user?.firstName ?? '',
//     );
//     lastNameController = TextEditingController(
//       text: userState.user?.lastName ?? '',
//     );
//     emailController = TextEditingController(text: userState.user?.email ?? '');
//     genderController = TextEditingController(
//       text: userState.user?.gender ?? '',
//     );
//     dobController = TextEditingController(
//       text: userState.user?.dateOfBirth ?? '',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final t = AppLocalizations.of(context)!;
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           t.editProfile,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_ios, size: 20),
//         ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//         elevation: 0,
//         backgroundColor: colorScheme.primary,
//       ),
//       body: Consumer<UserNotifier>(
//         builder: (context, userProvider, child) {
//           final userState = userProvider.state;

//           return SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Avatar with Camera Icon
//                 InkWell(
//                   onTap: () => _handleImageSelection(context),
//                   borderRadius: BorderRadius.circular(60),
//                   child: Stack(
//                     alignment: Alignment.bottomRight,
//                     children: [
//                       Container(
//                         width: 120,
//                         height: 120,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.grey[400],
//                           border: Border.all(
//                             color: colorScheme.primary,
//                             width: 2,
//                           ),
//                           // If there's an actual profileURL:
//                           // image: (userState.user?.profileURL != null)
//                           // ? DecorationImage(image: NetworkImage(userState.user!.profileURL!), fit: BoxFit.cover) : null,
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 4,
//                         right: 4,
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: const BoxDecoration(
//                             color: Colors
//                                 .transparent, // Background transparent per mockup
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.camera_alt_outlined,
//                             color: colorScheme.primary,
//                             size: 28,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 32),

//                 // Form Fields
//                 ProfileForm(
//                   firstNameController: firstNameController,
//                   lastNameController: lastNameController,
//                   emailController: emailController,
//                   genderController: genderController,
//                   dobController: dobController,
//                   onGenderTap: () => _handleGenderSelection(context),
//                   onDobTap: () => _handleDobSelection(context),
//                 ),

//                 const SizedBox(height: 48),

//                 // Error Message if any
//                 if (userState.error != null) ...[
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: colorScheme.error.withValues(alpha: 0.1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       userState.error!,
//                       style: theme.textTheme.bodySmall?.copyWith(
//                         color: colorScheme.error,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],

//                 // Save change Button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: userState.isLoading
//                         ? null
//                         : () => _handleSaveProfile(context, userProvider),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: colorScheme.secondary,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       elevation: 0,
//                     ),
//                     child: userState.isLoading
//                         ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                         : Text(
//                             t.saveChange,
//                             style: theme.textTheme.bodyMedium?.copyWith(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<void> _handleSaveProfile(
//     BuildContext context,
//     UserNotifier userProvider,
//   ) async {
//     final token =
//         await context.read<AuthProvider>().getIdToken() ??
//         'mock_fallback_token';

//     final success = await userProvider.updateUserProfile({
//       'firstName': firstNameController.text,
//       'lastName': lastNameController.text,
//       'gender': genderController.text,
//       'dateOfBirth': dobController.text,
//     }, token);

//     if (success && context.mounted) {
//       final t = AppLocalizations.of(context)!;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(t.profileUpdatedSuccessfully),
//           backgroundColor: AppColors.success,
//         ),
//       );
//       context.goBack();
//     }
//   }

//   void _handleGenderSelection(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         final t = AppLocalizations.of(context)!;
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: Text(t.female),
//                 onTap: () {
//                   setState(() => genderController.text = 'female');
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: Text(t.male),
//                 onTap: () {
//                   setState(() => genderController.text = 'male');
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: Text(t.other),
//                 onTap: () {
//                   setState(() => genderController.text = 'other');
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _handleDobSelection(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: Theme.of(context).colorScheme.copyWith(
//               primary: const Color(0xFF3F51B5), // Match mockup color
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null) {
//       setState(() {
//         // Format YYYY / MM / DD
//         final year = picked.year;
//         final month = picked.month.toString().padLeft(2, '0');
//         final day = picked.day.toString().padLeft(2, '0');
//         dobController.text = '$year / $month / $day';
//       });
//     }
//   }

//   void _handleImageSelection(BuildContext context) {
//     // Since image_picker isn't natively listed in pubspec, we'll implement a fallback mock dialog
//     // that invokes the uploadProfilePicture on the provider.
//     showDialog(
//       context: context,
//       builder: (context) {
//         final t = AppLocalizations.of(context)!;
//         return AlertDialog(
//           title: Text(t.changeProfilePicture),
//           content: Text(t.selectNewImage),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(t.cancel),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 Navigator.pop(context);

//                 final token = await context.read<AuthProvider>().getIdToken();
//                 if (token != null) {
//                   final success = await context
//                       .read<UserNotifier>()
//                       .uploadProfilePicture(
//                         'assets/imgs/simulated_new_avatar.png',
//                         token,
//                       );
//                   if (success && context.mounted) {
//                     final t2 = AppLocalizations.of(context)!;
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(t2.profilePictureUpdated),
//                         backgroundColor: AppColors.success,
//                       ),
//                     );
//                   }
//                 }
//               },
//               child: Text(t.simulateGalleryPick),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     firstNameController.dispose();
//     lastNameController.dispose();
//     emailController.dispose();
//     genderController.dispose();
//     dobController.dispose();
//     super.dispose();
//   }
// }

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController genderController;
  late TextEditingController dobController;

  @override
  void initState() {
    super.initState();
    final userState = context.read<UserNotifier>().state;
    firstNameController = TextEditingController(
      text: userState.user?.firstName ?? '',
    );
    lastNameController = TextEditingController(
      text: userState.user?.lastName ?? '',
    );
    emailController = TextEditingController(text: userState.user?.email ?? '');
    genderController = TextEditingController(
      text: userState.user?.gender ?? '',
    );
    dobController = TextEditingController(
      text: userState.user?.dateOfBirth ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          t.editProfile,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: colorScheme.primary,
      ),
      body: Consumer<UserNotifier>(
        builder: (context, userProvider, child) {
          final userState = userProvider.state;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                // Avatar with Camera Icon
                InkWell(
                  onTap: () => _handleImageSelection(context),
                  borderRadius: BorderRadius.circular(60),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: userState.user?.profileURL != null
                            ? NetworkImage(userState.user!.profileURL!)
                            : null,
                        child: userState.user?.profileURL == null
                            ? const Icon(Icons.person, size: 60)
                            : null,
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: colorScheme.primary,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Form Fields
                ProfileForm(
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                  emailController: emailController,
                  genderController: genderController,
                  dobController: dobController,
                  onGenderTap: () => _handleGenderSelection(context),
                  onDobTap: () => _handleDobSelection(context),
                ),

                const SizedBox(height: 48),

                if (userState.error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      userState.error!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: userState.isLoading
                        ? null
                        : () => _handleSaveProfile(context, userProvider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: userState.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            t.saveChange,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleSaveProfile(
    BuildContext context,
    UserNotifier userProvider,
  ) async {
    final jwt = context.read<AuthProvider>().jwt;
    if (jwt == null) return;

    final success = await userProvider.updateUserProfile({
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'gender': genderController.text,
      'dateOfBirth': dobController.text,
    }, jwt);

    if (success && context.mounted) {
      final t = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.profileUpdatedSuccessfully),
          backgroundColor: AppColors.success,
        ),
      );
      context.goBack();
    }
  }

  void _handleGenderSelection(BuildContext context) {
    // bottom sheet for gender selection
  }

  Future<void> _handleDobSelection(BuildContext context) async {
    // date picker for DOB
  }

  void _handleImageSelection(BuildContext context) async {
    final jwt = context.read<AuthProvider>().jwt;
    if (jwt != null) {
      final success = await context.read<UserNotifier>().uploadProfilePicture(
        'assets/imgs/simulated_new_avatar.png',
        jwt,
      );
      if (success && context.mounted) {
        final t = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.profilePictureUpdated),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    dobController.dispose();
    super.dispose();
  }
}
