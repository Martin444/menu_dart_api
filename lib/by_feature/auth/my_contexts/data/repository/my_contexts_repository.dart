import 'package:menu_dart_api/by_feature/auth/models/commerce_context.dart';

abstract class MyContextsRepository {
  Future<List<CommerceContext>> getMyContexts();
}
