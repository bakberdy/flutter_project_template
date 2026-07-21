import 'package:core/domain/failures/failure.dart';
import 'package:core/domain/failures/field_failure.dart';
import 'package:core/shared/models/http_error_model.dart';

extension HttpErrorMapper on HttpErrorModel {
  Failure toFailure(String source) {
    final parsedDetails = details;
    final fieldErrors = parsedDetails?.fieldErrors
        ?.map(
          (error) => BackendFieldFailure(
            fieldName: error.fieldName,
            message: error.message,
          ),
        )
        .toList();
    final failureDetails = FailureDetails(
      statusCode: parsedDetails?.statusCode ?? code,
      type: FailureType.values.byName(parsedDetails?.type.name ?? 'snackbar'),
      fieldErrors: fieldErrors,
    );

    return BackendFailure(
      message: message,
      source: source,
      details: failureDetails,
    );
  }
}
