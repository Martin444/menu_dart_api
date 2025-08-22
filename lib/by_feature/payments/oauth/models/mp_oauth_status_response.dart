import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_account.dart';

class MPOAuthStatusResponse {
  final bool isLinked;
  final MPOAuthAccount? account;

  MPOAuthStatusResponse({
    required this.isLinked,
    this.account,
  });

  factory MPOAuthStatusResponse.fromJson(Map<String, dynamic> json) {
    return MPOAuthStatusResponse(
      isLinked: json['isLinked'],
      account: json['account'] != null ? MPOAuthAccount.fromJson(json['account']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLinked': isLinked,
      if (account != null) 'account': account!.toJson(),
    };
  }
}
