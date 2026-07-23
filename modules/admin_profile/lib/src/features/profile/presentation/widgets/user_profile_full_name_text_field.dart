import 'package:admin_profile/src/common/presentation/extensions/admin_profile_context_x.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserProfileFullNameTextField extends StatelessWidget {
  const UserProfileFullNameTextField({
    required this.controller,
    super.key,
    this.onChanged,
    this.errorText,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return BaseInputField(
      label: context.l10n.profileEditFullNameLabel,
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      autocorrect: false,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(prefixIcon: Icon(Icons.person)),
      errorText: errorText,
    );
  }
}
