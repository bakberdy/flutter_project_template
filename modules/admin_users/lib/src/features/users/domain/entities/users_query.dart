import 'package:equatable/equatable.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';

enum UsersSortDirection { ascending, descending }

enum UsersSortField {
  createdAt,
  email,
  role,
  status,
  isVerified,
  fullName,
  phoneNumber,
}

class UsersQuery extends Equatable {
  const UsersQuery({
    this.pageNumber = 1,
    this.limit = 10,
    this.sortDirection = UsersSortDirection.descending,
    this.sortField = UsersSortField.createdAt,
    this.status,
    this.role,
    this.isVerified,
    this.isProfileCompleted,
    this.createdAtFrom,
    this.createdAtTo,
    this.search,
  });

  final int pageNumber;
  final int limit;
  final UsersSortDirection sortDirection;
  final UsersSortField sortField;
  final AdminUserStatus? status;
  final AdminUserRole? role;
  final bool? isVerified;
  final bool? isProfileCompleted;
  final DateTime? createdAtFrom;
  final DateTime? createdAtTo;
  final String? search;

  UsersQuery copyWith({
    int? pageNumber,
    int? limit,
    UsersSortDirection? sortDirection,
    UsersSortField? sortField,
    AdminUserStatus? status,
    AdminUserRole? role,
    bool? isVerified,
    bool? isProfileCompleted,
    DateTime? createdAtFrom,
    DateTime? createdAtTo,
  }) => UsersQuery(
    pageNumber: pageNumber ?? this.pageNumber,
    limit: limit ?? this.limit,
    sortDirection: sortDirection ?? this.sortDirection,
    sortField: sortField ?? this.sortField,
    status: status ?? this.status,
    role: role ?? this.role,
    isVerified: isVerified ?? this.isVerified,
    isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
    createdAtFrom: createdAtFrom ?? this.createdAtFrom,
    createdAtTo: createdAtTo ?? this.createdAtTo,
    search: search,
  );

  UsersQuery copyWithFilters({
    AdminUserStatus? status,
    bool clearStatus = false,
    AdminUserRole? role,
    bool clearRole = false,
    bool? isVerified,
    bool clearIsVerified = false,
    bool? isProfileCompleted,
    bool clearIsProfileCompleted = false,
    DateTime? createdAtFrom,
    bool clearCreatedAtFrom = false,
    DateTime? createdAtTo,
    bool clearCreatedAtTo = false,
  }) => UsersQuery(
    pageNumber: pageNumber,
    limit: limit,
    sortDirection: sortDirection,
    sortField: sortField,
    status: clearStatus ? null : status ?? this.status,
    role: clearRole ? null : role ?? this.role,
    isVerified: clearIsVerified ? null : isVerified ?? this.isVerified,
    isProfileCompleted: clearIsProfileCompleted
        ? null
        : isProfileCompleted ?? this.isProfileCompleted,
    createdAtFrom: clearCreatedAtFrom
        ? null
        : createdAtFrom ?? this.createdAtFrom,
    createdAtTo: clearCreatedAtTo ? null : createdAtTo ?? this.createdAtTo,
    search: search,
  );

  UsersQuery copyWithSearch(String? search) => UsersQuery(
    pageNumber: pageNumber,
    limit: limit,
    sortDirection: sortDirection,
    sortField: sortField,
    status: status,
    role: role,
    isVerified: isVerified,
    isProfileCompleted: isProfileCompleted,
    createdAtFrom: createdAtFrom,
    createdAtTo: createdAtTo,
    search: search,
  );

  bool get hasFilters =>
      status != null ||
      role != null ||
      isVerified != null ||
      isProfileCompleted != null ||
      createdAtFrom != null ||
      createdAtTo != null;

  @override
  List<Object?> get props => [
    pageNumber,
    limit,
    sortDirection,
    sortField,
    status,
    role,
    isVerified,
    isProfileCompleted,
    createdAtFrom,
    createdAtTo,
    search,
  ];
}
