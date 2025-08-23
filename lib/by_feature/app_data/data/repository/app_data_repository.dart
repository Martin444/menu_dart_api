import '../../models/app_data_model.dart';
import '../../models/create_app_data_params.dart';
import '../../models/update_app_data_params.dart';

abstract class AppDataRepository {
  /// Create a new app data entry
  Future<AppDataModel> createAppData(CreateAppDataParams params);

  /// Get all app data entries
  Future<List<AppDataModel>> getAllAppData();

  /// Get app data by ID
  Future<AppDataModel> getAppDataById(String id);

  /// Get app data by key
  Future<AppDataModel> getAppDataByKey(String key);

  /// Update an existing app data entry
  Future<AppDataModel> updateAppData(String id, UpdateAppDataParams params);

  /// Delete an app data entry
  Future<void> deleteAppData(String id);

  /// Toggle the isActive status of an app data entry
  Future<AppDataModel> toggleAppData(String id);
}
