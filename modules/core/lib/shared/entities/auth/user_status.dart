import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum UserStatus { active, blocked, deletionRequested, deleted }
