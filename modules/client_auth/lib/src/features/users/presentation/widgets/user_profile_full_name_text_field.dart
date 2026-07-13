import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserProfileFullNameTextField extends StatelessWidget {
  const UserProfileFullNameTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.errorText,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      autocorrect: false,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: ClientAuthLocalizations.of(context).profileEditFullNameLabel,
        prefixIcon: const Icon(Icons.person),
        errorText: errorText,
      ),
    );
  }
}
