import 'package:core/src/shared/entities/paginated_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_response_model.g.dart';

class PaginatedResponseModel<T> extends PaginatedResponse<T> {
  const PaginatedResponseModel({
    required super.items,
    required super.pagination,
  });

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return PaginatedResponseModel<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
      pagination: PaginationMetaModel.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );
  }
}

@JsonSerializable(createToJson: false)
class PaginationMetaModel extends PaginationMeta {
  const PaginationMetaModel({
    required super.page,
    required super.limit,
    required super.totalItems,
    required super.totalPages,
    required super.hasNext,
    required super.hasPrevious,
  });

  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaModelFromJson(json);
}
