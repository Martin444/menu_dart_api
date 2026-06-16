import 'package:menu_dart_api/by_feature/auth/switch_context/model/switch_context.dart';

abstract class SwitchContextRepository {
  Future<SwitchContextResponse> switchContext(SwitchContextRequest request);
}
