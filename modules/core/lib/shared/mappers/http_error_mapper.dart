import 'package:core/shared/entities/failure.dart';
import 'package:core/shared/models/http_error_model.dart';

extension HttpErrorMapper on HttpErrorModel {
  Failure toFailure(String source) {
    final parsedDetails = details;
    final fieldErrors = parsedDetails?.fieldErrors
        ?.map((e) => FieldFailure(fieldName: e.fieldName, message: e.message))
        .toList();
    final failureDetails = FailureDetails(
      statusCode: parsedDetails?.statusCode ?? code,
      type: FailureType.values.byName(parsedDetails?.type.name ?? 'snackbar'),
      fieldErrors: fieldErrors,
    );

    return Failure(
      message: message,
      source: source,
      reason: FailureReason.backend,
      details: failureDetails,
    );
  }
}
