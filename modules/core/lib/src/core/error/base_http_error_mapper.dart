import 'package:core/src/core/error/base_http_error_model.dart';
import 'package:core/src/core/error/error.dart';

extension BaseHttpErrorMapper on BaseHttpErrorModel {
  Failure toFailure(String source) {
    final parsedDetails = details;
    final fieldErrors = parsedDetails?.fieldErrors
        ?.map((e) => FieldFailure(fieldName: e.fieldName, message: e.message))
        .toList();
    final failureDetails = parsedDetails is AuthHttpErrorDetailsModel
        ? AuthFailureDetails(
            statusCode: parsedDetails.statusCode,
            type: FailureType.values.byName(parsedDetails.type.name),
            attemptsLeft: parsedDetails.attemptsLeft,
            blockedUntil: parsedDetails.blockedUntil,
            fieldErrors: fieldErrors,
          )
        : FailureDetails(
            statusCode: parsedDetails?.statusCode ?? code,
            type: FailureType.values.byName(
              parsedDetails?.type.name ?? 'snackbar',
            ),
            fieldErrors: fieldErrors,
          );

    return Failure(message: message, source: source, details: failureDetails);
  }
}
