import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_model.dart';

class MenuParams {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? userId;

  MenuParams({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.userId,
  });
}

class PostMenuUsecase {
  static Future<dynamic> execute(MenuParams params) async {
    throw UnimplementedError('PostMenuUsecase needs to be implemented');
  }
}
