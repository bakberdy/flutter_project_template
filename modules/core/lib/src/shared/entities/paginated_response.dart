import 'package:equatable/equatable.dart';

class PaginatedResponse<T> extends Equatable {
  final List<T> items;
  final PaginationMeta pagination;

  const PaginatedResponse({required this.items, required this.pagination});

  @override
  List<Object?> get props => [items, pagination];
}

class PaginationMeta extends Equatable {
  final int page;
  final int limit;
  final int totalItems;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  const PaginationMeta({
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

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
