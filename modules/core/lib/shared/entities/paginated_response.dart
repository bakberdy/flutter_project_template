import 'package:equatable/equatable.dart';

class PaginatedResponse<T> extends Equatable {
  const PaginatedResponse({required this.items, required this.pagination});
  final List<T> items;
  final PaginationMeta pagination;

  @override
  List<Object?> get props => [items, pagination];
}

class PaginationMeta extends Equatable {
  const PaginationMeta({
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });
  final int page;
  final int limit;
  final int totalItems;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  @override
  List<Object?> get props => [
    page,
    limit,
    totalItems,
    totalPages,
    hasNext,
    hasPrevious,
  ];
}
