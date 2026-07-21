import 'package:admin_users/src/common/admin_users_context_x.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class UsersSearchBar extends StatefulWidget {
  const UsersSearchBar({
    required this.onSearch,
    required this.activeSearch,
    super.key,
    this.initialValue,
  });

  final ValueChanged<String> onSearch;
  final String? activeSearch;
  final String? initialValue;

  @override
  State<UsersSearchBar> createState() => _UsersSearchBarState();
}

class _UsersSearchBarState extends State<UsersSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    final search = _controller.text.trim();
    return search.isNotEmpty && search != widget.activeSearch;
  }

  void _submit() {
    if (!_canSubmit) {
      return;
    }
    widget.onSearch(_controller.text);
  }

  void _clear() {
    _controller.clear();
    widget.onSearch('');
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, value, _) {
                final showClear =
                    widget.activeSearch != null || value.text.isNotEmpty;
                return BaseInputField(
                  focusNode: _focusNode,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: l10n.usersSearchHint,
                    prefixIcon: const Icon(Icons.search, size: 18),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                    suffixIcon: showClear
                        ? IconButton(
                            tooltip: l10n.usersClearSearch,
                            onPressed: _clear,
                            icon: const Icon(Icons.clear, size: 18),
                          )
                        : null,
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: DesignSpacingTokens.sm,
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (_) => _submit(),
                );
              },
            ),
          ),
          const SizedBox(width: DesignSpacingTokens.sm),
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, value, _) {
              final disabled =
                  value.text.trim().isEmpty ||
                  value.text.trim() == widget.activeSearch;
              return _SearchBarActionButton(
                onPressed: disabled ? null : _submit,
                label: l10n.usersSearch,
                icon: Icons.search,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SearchBarActionButton extends StatelessWidget {
  const _SearchBarActionButton({
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.designColors;
    return Align(
      child: SizedBox(
        width: 172,
        height: 40,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 18),
          label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: DesignSpacingTokens.sm),
            ),
            foregroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.disabled)
                  ? colorScheme.onSurface.withValues(alpha: 0.38)
                  : colorScheme.primary,
            ),
            backgroundColor: WidgetStatePropertyAll(colorScheme.surface),
            side: WidgetStateProperty.resolveWith(
              (states) => BorderSide(
                color: states.contains(WidgetState.disabled)
                    ? colorScheme.outlineVariant
                    : colorScheme.primary,
              ),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DesignRadiusTokens.md),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
