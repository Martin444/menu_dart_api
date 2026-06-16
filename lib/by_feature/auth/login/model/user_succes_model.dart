class UserSuccess {
  final String accessToken;
  final bool needToChangePassword;
  final String? commerceId;

  UserSuccess({
    required this.accessToken,
    required this.needToChangePassword,
    this.commerceId,
  });
}
