# Failure Handling Guidelines

These instructions are mandatory for tasks involving failures, exceptions,
backend errors, field validation, or failure-to-UI mapping.

## Failure Types and Ownership

- Represent failures with concrete `Failure` subclasses, never reason enums.
- Keep core failures under `modules/core/lib/domain/failures/`.
- Create every feature-specific failure under the owning feature's
  `lib/src/features/<feature>/domain/failures/` directory.
- Never place a feature-specific failure in `core` or `shared`. Expose only the
  failure types required by that feature package's public contract.
- Use shared core failure types for reusable transport conditions such as no
  connection, timeout, invalid response, and service unavailability.
- Create an operation-specific or business-specific failure, such as
  `GetAppInfoFailure`, when a local operation fails for its own reason.

## Messages and Values

- Only `BackendFailure` may carry a user-facing `message`.
- Only `BackendFieldFailure` may carry a backend field-validation message. No
  other failure type may store localized or diagnostic text.
- Represent every distinct locally produced, user-visible error condition with
  its own concrete failure class in the module that owns the operation.
- Do not pass an error string through state or reuse one generic failure with a
  reason enum. For example, represent "Email is too short" with
  `EmailTooShortFailure`; field-specific validation failures must extend
  `FieldFailure`.
- A failure may carry the raw, non-localized values required to render its
  message. For example,
  `StartDateCannotBeBiggerThanEndDateFailure(startDate: ..., endDate: ...)`
  may carry both dates.
- Include raw values in equality and map the failure type and values to a
  parameterized ARB message in the owning presentation layer.
- Never store a rendered, localized, or diagnostic message in a local failure.

## Backend and Field Failures

- Name feature-specific failures by the precise condition they represent.
- Do not infer a typed failure from backend prose. Use a stable backend error
  code when one is available; otherwise preserve it as a
  `BackendFieldFailure`.
- Resolve backend field messages through `FieldFailuresX`, using
  `backendMessageForField` or `backendMessageForAnyField`.
- Do not duplicate loops that filter `BackendFieldFailure` by `fieldName` in
  feature code.

## Layer Boundaries

- Convert exceptions to typed failures at the data or repository boundary.
- Do not pass exceptions or locally generated error strings into presentation.
- Map non-backend failure types to ARB messages in presentation code.
- Preserve a non-empty `BackendFailure.message` exactly as returned by the
  backend.
- Do not introduce a localization data source into repositories or use cases.
- Keep generic failure-to-UI mapping in `shared`.
- Resolve feature-specific failures inside their owning feature; `shared` must
  not import feature packages.
