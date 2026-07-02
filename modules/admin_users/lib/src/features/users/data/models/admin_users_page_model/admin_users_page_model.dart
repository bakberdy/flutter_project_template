import 'package:core/core.dart';
import 'package:admin_users/src/features/users/data/models/admin_user_model/admin_user_model.dart';

class AdminUsersPageModel extends PaginatedResponse<AdminUserModel> {
  const AdminUsersPageModel({required super.items, required super.pagination});

  factory AdminUsersPageModel.fromJson(Map<String, dynamic> json) {
    final paginationData = json['pagination'];
    if (paginationData is! Map<String, dynamic>) {
      throw const FormatException('Missing users pagination data');
    }
    final itemsData = json['items'];
    if (itemsData is! List<dynamic>) {
      throw const FormatException('Missing users items data');
    }
    return AdminUsersPageModel(
      items: itemsData
          .map((item) => AdminUserModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: PaginationMeta(
        page: paginationData['page'] as int,
        limit: paginationData['limit'] as int,
        totalItems: paginationData['total_items'] as int,
        totalPages: paginationData['total_pages'] as int,
        hasNext: paginationData['has_next'] as bool,
        hasPrevious: paginationData['has_previous'] as bool,
      ),
    );
  }
}
