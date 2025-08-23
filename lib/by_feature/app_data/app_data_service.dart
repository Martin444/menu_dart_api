import 'package:http/http.dart' as http;
import 'models/models.dart';
import 'data/provider/app_data_provider.dart';
import 'data/repository/app_data_repository_impl.dart';
import 'data/usecase/usecases.dart';

/// Comprehensive service for App Data operations
///
/// This service provides all App Data functionality including:
/// - Create new app data entries
/// - Read all or specific app data entries
/// - Update existing app data entries
/// - Delete app data entries
/// - Toggle active status
///
/// Example usage:
/// ```dart
/// final service = AppDataService(
///   client: http.Client(),
///   baseUrl: 'https://api.example.com',
///   token: 'your-jwt-token',
/// );
///
/// // Create new app data
/// final newData = await service.createAppData(
///   CreateAppDataParams(
///     key: 'theme_color',
///     value: '#FF5722',
///     description: 'Primary theme color',
///   ),
/// );
///
/// // Get all app data
/// final allData = await service.getAllAppData();
///
/// // Get specific app data by key
/// final themeData = await service.getAppDataByKey('theme_color');
/// ```
class AppDataService {
  late final CreateAppDataUseCase _createAppDataUseCase;
  late final GetAllAppDataUseCase _getAllAppDataUseCase;
  late final GetAppDataByIdUseCase _getAppDataByIdUseCase;
  late final GetAppDataByKeyUseCase _getAppDataByKeyUseCase;
  late final UpdateAppDataUseCase _updateAppDataUseCase;
  late final DeleteAppDataUseCase _deleteAppDataUseCase;
  late final ToggleAppDataUseCase _toggleAppDataUseCase;

  AppDataService({
    required http.Client client,
    required String baseUrl,
    String? token,
  }) {
    final provider = AppDataProvider(client: client, baseUrl: baseUrl);
    final repository = AppDataRepositoryImpl(provider: provider, token: token);

    _createAppDataUseCase = CreateAppDataUseCase(repository);
    _getAllAppDataUseCase = GetAllAppDataUseCase(repository);
    _getAppDataByIdUseCase = GetAppDataByIdUseCase(repository);
    _getAppDataByKeyUseCase = GetAppDataByKeyUseCase(repository);
    _updateAppDataUseCase = UpdateAppDataUseCase(repository);
    _deleteAppDataUseCase = DeleteAppDataUseCase(repository);
    _toggleAppDataUseCase = ToggleAppDataUseCase(repository);
  }

  /// Create a new app data entry
  ///
  /// [params] - Parameters for creating the app data
  /// Returns the created [AppDataModel]
  Future<AppDataModel> createAppData(CreateAppDataParams params) async {
    return await _createAppDataUseCase(params);
  }

  /// Get all app data entries
  ///
  /// Returns a list of all [AppDataModel] entries
  Future<List<AppDataModel>> getAllAppData() async {
    return await _getAllAppDataUseCase();
  }

  /// Get app data by ID
  ///
  /// [id] - The ID of the app data entry
  /// Returns the [AppDataModel] with the specified ID
  Future<AppDataModel> getAppDataById(String id) async {
    return await _getAppDataByIdUseCase(id);
  }

  /// Get app data by key
  ///
  /// [key] - The unique key of the app data entry
  /// Returns the [AppDataModel] with the specified key
  Future<AppDataModel> getAppDataByKey(String key) async {
    return await _getAppDataByKeyUseCase(key);
  }

  /// Update an existing app data entry
  ///
  /// [id] - The ID of the app data entry to update
  /// [params] - Parameters for updating the app data
  /// Returns the updated [AppDataModel]
  Future<AppDataModel> updateAppData(String id, UpdateAppDataParams params) async {
    return await _updateAppDataUseCase(id, params);
  }

  /// Delete an app data entry
  ///
  /// [id] - The ID of the app data entry to delete
  Future<void> deleteAppData(String id) async {
    return await _deleteAppDataUseCase(id);
  }

  /// Toggle the active status of an app data entry
  ///
  /// [id] - The ID of the app data entry to toggle
  /// Returns the updated [AppDataModel] with toggled status
  Future<AppDataModel> toggleAppData(String id) async {
    return await _toggleAppDataUseCase(id);
  }

  /// Convenience method to check if a specific app data key exists and is active
  ///
  /// [key] - The key to check
  /// Returns true if the key exists and is active, false otherwise
  Future<bool> isAppDataActive(String key) async {
    try {
      final data = await getAppDataByKey(key);
      return data.isActive;
    } catch (e) {
      return false;
    }
  }

  /// Convenience method to get the value of a specific app data key
  ///
  /// [key] - The key to get the value for
  /// [defaultValue] - Default value if key doesn't exist or is inactive
  /// Returns the value if found and active, otherwise returns defaultValue
  Future<String?> getAppDataValue(String key, {String? defaultValue}) async {
    try {
      final data = await getAppDataByKey(key);
      return data.isActive ? data.value : defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Convenience method to create or update app data
  ///
  /// If a key already exists, it will be updated. Otherwise, a new entry will be created.
  /// [key] - The unique key
  /// [value] - The value to set
  /// [description] - Optional description
  /// Returns the created or updated [AppDataModel]
  Future<AppDataModel> setAppData(
    String key,
    String value, {
    String? description,
  }) async {
    try {
      // Try to get existing data by key
      final existing = await getAppDataByKey(key);
      // Update existing entry
      return await updateAppData(
        existing.id!,
        UpdateAppDataParams(
          value: value,
          description: description,
          isActive: true,
        ),
      );
    } catch (e) {
      // Key doesn't exist, create new entry
      return await createAppData(
        CreateAppDataParams(
          key: key,
          value: value,
          description: description ?? 'App configuration data',
        ),
      );
    }
  }
}
