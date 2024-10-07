import 'package:menu_dart_api/by_feature/wardrobe/get_clothing_bywardeobe/model/wardrobe_response_params.dart';

abstract class GetClothingsRespository {
  Future<WardrobeResponseParams> getClothingByUserAcount(String idUser);
}
