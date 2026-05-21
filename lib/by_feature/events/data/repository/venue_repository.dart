import 'package:menu_dart_api/by_feature/events/models/venue_model.dart';
import 'package:menu_dart_api/by_feature/events/models/create_venue_params.dart';

abstract class VenueRepository {
  Future<VenueModel> create(CreateVenueParams params);
  Future<List<VenueModel>> list();
  Future<VenueModel> getById(String id);
  Future<void> delete(String id);
}
