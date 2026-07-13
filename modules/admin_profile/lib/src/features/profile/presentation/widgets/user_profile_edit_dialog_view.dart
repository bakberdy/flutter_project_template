import 'package:admin_profile/src/features/profile/presentation/screens/user_profile_edit_screen.dart';
import 'package:flutter/widgets.dart';

class UserProfileEditDialogView extends StatelessWidget {
  const UserProfileEditDialogView({super.key});

  @override
  Widget build(BuildContext context) =>
      const UserProfileEditScreen(showAppBar: false, showLogoutAction: false);
}
