import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/discount_result_model.dart';

/// Caso de uso para aplicar un cupón de descuento
class ApplyMembershipDiscountUseCase {
  final MembershipRepository _repository;

  ApplyMembershipDiscountUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<DiscountResultModel> call(String coupon) async {
    return await _repository.applyDiscount(coupon);
  }
}
