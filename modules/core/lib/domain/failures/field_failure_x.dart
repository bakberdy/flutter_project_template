import 'package:core/domain/failures/field_failure.dart';

extension FieldFailuresX on Iterable<FieldFailure> {
  String? backendMessageForField(String fieldName) =>
      backendMessageForAnyField({fieldName});

  String? backendMessageForAnyField(Set<String> fieldNames) {
    for (final failure in whereType<BackendFieldFailure>()) {
      if (fieldNames.contains(failure.fieldName)) {
        return failure.message;
      }
    }
    return null;
  }
}
