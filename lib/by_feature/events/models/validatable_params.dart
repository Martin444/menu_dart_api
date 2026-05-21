/// Exception thrown when validation fails.
class ValidationException implements Exception {
  final String message;
  final String? field;
  final Map<String, dynamic>? errors;

  const ValidationException(
    this.message, {
    this.field,
    this.errors,
  });

  @override
  String toString() => 'ValidationException: $message';
}

/// Mixin that provides validation utilities for parameter classes.
mixin ValidatableParams {
  /// Validates all parameters.
  ///
  /// Throws [ValidationException] if validation fails.
  void validate();

  /// Validates that a string is not empty.
  void validateRequiredString(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      throw ValidationException(
        '$fieldName is required',
        field: fieldName,
      );
    }
  }

  /// Validates that a string is a valid email.
  void validateEmail(String? value, String fieldName) {
    validateRequiredString(value, fieldName);
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value!)) {
      throw ValidationException(
        '$fieldName must be a valid email address',
        field: fieldName,
      );
    }
  }

  /// Validates that a number is positive.
  void validatePositive(num? value, String fieldName) {
    if (value == null || value <= 0) {
      throw ValidationException(
        '$fieldName must be greater than 0',
        field: fieldName,
      );
    }
  }

  /// Validates that an integer is non-negative.
  void validateNonNegative(int? value, String fieldName) {
    if (value == null || value < 0) {
      throw ValidationException(
        '$fieldName must be 0 or greater',
        field: fieldName,
      );
    }
  }

  /// Validates that a date is in the future.
  void validateFutureDate(DateTime? value, String fieldName) {
    if (value == null) {
      throw ValidationException(
        '$fieldName is required',
        field: fieldName,
      );
    }
    
    if (value.isBefore(DateTime.now())) {
      throw ValidationException(
        '$fieldName must be in the future',
        field: fieldName,
      );
    }
  }

  /// Validates that an end date is after a start date.
  void validateDateRange(
    DateTime? startDate,
    DateTime? endDate,
    String startFieldName,
    String endFieldName,
  ) {
    if (startDate == null) {
      throw ValidationException(
        '$startFieldName is required',
        field: startFieldName,
      );
    }
    if (endDate == null) {
      throw ValidationException(
        '$endFieldName is required',
        field: endFieldName,
      );
    }
    
    if (endDate.isBefore(startDate) || endDate.isAtSameMomentAs(startDate)) {
      throw ValidationException(
        '$endFieldName must be after $startFieldName',
        field: endFieldName,
      );
    }
  }

  /// Validates string length is within range.
  void validateStringLength(
    String? value,
    String fieldName, {
    int minLength = 1,
    int? maxLength,
  }) {
    if (value == null) {
      throw ValidationException(
        '$fieldName is required',
        field: fieldName,
      );
    }
    
    if (value.length < minLength) {
      throw ValidationException(
        '$fieldName must be at least $minLength characters',
        field: fieldName,
      );
    }
    
    if (maxLength != null && value.length > maxLength) {
      throw ValidationException(
        '$fieldName must be at most $maxLength characters',
        field: fieldName,
      );
    }
  }
}
