import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:admin_users/src/features/users/presentation/extensions/admin_user_localization_x.dart';
import 'package:admin_users/src/common/admin_users_context_x.dart';

class UsersFiltersMenuButton extends StatelessWidget {
  const UsersFiltersMenuButton({
    super.key,
    required this.query,
    required this.onChanged,
    this.enabled = true,
  });

  final UsersQuery query;
  final ValueChanged<UsersQuery> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final active = query.hasFilters;
    final colorScheme = context.designColors;
    final borderColor = !enabled
        ? colorScheme.outlineVariant
        : active
        ? colorScheme.primary
        : colorScheme.outlineVariant;
    final foregroundColor = !enabled
        ? colorScheme.onSurface.withValues(alpha: 0.38)
        : active
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;
    final backgroundColor = !enabled || !active
        ? colorScheme.surface
        : colorScheme.primaryContainer.withValues(alpha: 0.24);
    final borderRadius = BorderRadius.circular(DesignRadii.md);

    return InkWell(
      borderRadius: borderRadius,
      onTap: enabled ? () => _showFiltersDialog(context) : null,
      child: Container(
        width: 172,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: DesignSpacing.sm),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Icon(Icons.filter_list, size: 18, color: foregroundColor),
            const SizedBox(width: DesignSpacing.xs),
            Expanded(
              child: Text(
                l10n.usersFiltersLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.designTextTheme.bodyMedium?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: DesignSpacing.xs),
            Icon(Icons.tune, size: 18, color: foregroundColor),
          ],
        ),
      ),
    );
  }

  Future<void> _showFiltersDialog(BuildContext context) async {
    final draft = _UsersFilterDraft.fromQuery(query);
    final materialL10n = MaterialLocalizations.of(context);
    var applied = false;
    await BaseDialog.show<void>(
      context,
      title: context.l10n.usersFiltersLabel,
      width: 560,
      primaryLabel: materialL10n.okButtonLabel,
      secondaryLabel: materialL10n.cancelButtonLabel,
      onPrimary: () {
        applied = true;
      },
      body: StatefulBuilder(
        builder: (context, setState) {
          final l10n = context.l10n;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => setState(draft.clear),
                  icon: const Icon(Icons.close),
                  label: Text(l10n.usersFiltersClearAll),
                ),
              ),
              const SizedBox(height: DesignSpacing.sm),
              _FilterDropdown<AdminUserStatus>(
                label: l10n.usersStatusFilterLabel,
                value: draft.status,
                allLabel: l10n.usersStatusFilterAll,
                options: AdminUserStatus.values
                    .map(
                      (status) => _FilterOption(
                        value: status,
                        label: status.localizedName(l10n),
                      ),
                    )
                    .toList(),
                onChanged: (status) => setState(() => draft.status = status),
              ),
              const SizedBox(height: DesignSpacing.md),
              _FilterDropdown<AdminUserRole>(
                label: l10n.usersRoleFilterLabel,
                value: draft.role,
                allLabel: l10n.usersRoleFilterAll,
                options: AdminUserRole.values
                    .map(
                      (role) => _FilterOption(
                        value: role,
                        label: role.localizedName(l10n),
                      ),
                    )
                    .toList(),
                onChanged: (role) => setState(() => draft.role = role),
              ),
              const SizedBox(height: DesignSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _FilterDropdown<bool>(
                      label: l10n.usersVerifiedFilterLabel,
                      value: draft.isVerified,
                      allLabel: l10n.usersVerifiedFilterAll,
                      options: [
                        _FilterOption(value: true, label: l10n.usersYes),
                        _FilterOption(value: false, label: l10n.usersNo),
                      ],
                      onChanged: (value) =>
                          setState(() => draft.isVerified = value),
                    ),
                  ),
                  const SizedBox(width: DesignSpacing.md),
                  Expanded(
                    child: _FilterDropdown<bool>(
                      label: l10n.usersProfileCompletedFilterLabel,
                      value: draft.isProfileCompleted,
                      allLabel: l10n.usersProfileCompletedFilterAll,
                      options: [
                        _FilterOption(value: true, label: l10n.usersYes),
                        _FilterOption(value: false, label: l10n.usersNo),
                      ],
                      onChanged: (value) =>
                          setState(() => draft.isProfileCompleted = value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: DesignSpacing.md),
              _CreatedAtRangeTile(
                from: draft.createdAtFrom,
                to: draft.createdAtTo,
                allLabel: l10n.usersCreatedAtFilterAll,
                label: l10n.usersColumnCreatedAt,
                onChanged: (from, to) => setState(() {
                  draft.createdAtFrom = from;
                  draft.createdAtTo = to;
                }),
              ),
            ],
          );
        },
      ),
    );
    if (applied && context.mounted) {
      onChanged(draft.toQuery(query));
    }
  }
}

class _UsersFilterDraft {
  _UsersFilterDraft({
    this.status,
    this.role,
    this.isVerified,
    this.isProfileCompleted,
    this.createdAtFrom,
    this.createdAtTo,
  });

  AdminUserStatus? status;
  AdminUserRole? role;
  bool? isVerified;
  bool? isProfileCompleted;
  DateTime? createdAtFrom;
  DateTime? createdAtTo;

  factory _UsersFilterDraft.fromQuery(UsersQuery query) => _UsersFilterDraft(
    status: query.status,
    role: query.role,
    isVerified: query.isVerified,
    isProfileCompleted: query.isProfileCompleted,
    createdAtFrom: query.createdAtFrom,
    createdAtTo: query.createdAtTo,
  );

  void clear() {
    status = null;
    role = null;
    isVerified = null;
    isProfileCompleted = null;
    createdAtFrom = null;
    createdAtTo = null;
  }

  UsersQuery toQuery(UsersQuery source) => source.copyWithFilters(
    status: status,
    clearStatus: status == null,
    role: role,
    clearRole: role == null,
    isVerified: isVerified,
    clearIsVerified: isVerified == null,
    isProfileCompleted: isProfileCompleted,
    clearIsProfileCompleted: isProfileCompleted == null,
    createdAtFrom: createdAtFrom,
    clearCreatedAtFrom: createdAtFrom == null,
    createdAtTo: createdAtTo,
    clearCreatedAtTo: createdAtTo == null,
  );
}

class _FilterOption<T extends Object> {
  const _FilterOption({required this.value, required this.label});

  final T value;
  final String label;
}

class _FilterDropdown<T extends Object> extends StatelessWidget {
  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.allLabel,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final T? value;
  final String allLabel;
  final List<_FilterOption<T>> options;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T?>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        DropdownMenuItem<T?>(value: null, child: Text(allLabel)),
        ...options.map(
          (option) => DropdownMenuItem<T?>(
            value: option.value,
            child: Text(option.label),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}

class _CreatedAtRangeTile extends StatelessWidget {
  const _CreatedAtRangeTile({
    required this.from,
    required this.to,
    required this.label,
    required this.allLabel,
    required this.onChanged,
  });

  final DateTime? from;
  final DateTime? to;
  final String label;
  final String allLabel;
  final void Function(DateTime? from, DateTime? to) onChanged;

  @override
  Widget build(BuildContext context) {
    final active = from != null || to != null;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.designColors.outlineVariant),
        borderRadius: BorderRadius.circular(DesignRadii.md),
      ),
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text(label),
        subtitle: Text(_selectedLabel(context)),
        trailing: active
            ? IconButton(
                tooltip: allLabel,
                icon: const Icon(Icons.close),
                onPressed: () => onChanged(null, null),
              )
            : const Icon(Icons.chevron_right),
        onTap: () => _selectRange(context),
      ),
    );
  }

  Future<void> _selectRange(BuildContext context) async {
    final now = DateTime.now();
    final initialStart =
        from?.toLocal() ?? now.subtract(const Duration(days: 7));
    final initialEnd = to?.toLocal() ?? now;
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: now,
      initialDateRange: DateTimeRange(start: initialStart, end: initialEnd),
    );
    if (range == null) {
      return;
    }
    onChanged(_startOfDay(range.start), _endOfDay(range.end));
  }

  String _selectedLabel(BuildContext context) {
    if (from == null && to == null) {
      return allLabel;
    }
    final format = DateFormat.yMd(Localizations.localeOf(context).toString());
    final start = from == null ? '' : format.format(from!.toLocal());
    final end = to == null ? '' : format.format(to!.toLocal());
    return '$start - $end';
  }

  DateTime _startOfDay(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  DateTime _endOfDay(DateTime value) =>
      DateTime(value.year, value.month, value.day, 23, 59, 59, 999);
}
