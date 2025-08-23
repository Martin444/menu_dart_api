import '../provider/app_data_provider.dart';
import '../repository/app_data_repository.dart';
import '../../models/app_data_model.dart';
import '../../models/create_app_data_params.dart';
import '../../models/update_app_data_params.dart';

class AppDataRepositoryImpl implements AppDataRepository {
  final AppDataProvider provider;
  final String? token;

  const AppDataRepositoryImpl({
    required this.provider,
    this.token,
  });

  @override
  Future<AppDataModel> createAppData(CreateAppDataParams params) async {
    return await provider.createAppData(params, token: token);
  }

  @override
  Future<List<AppDataModel>> getAllAppData() async {
    return await provider.getAllAppData(token: token);
  }

  @override
  Future<AppDataModel> getAppDataById(String id) async {
    return await provider.getAppDataById(id, token: token);
  }

  @override
  Future<AppDataModel> getAppDataByKey(String key) async {
    return await provider.getAppDataByKey(key, token: token);
  }

  @override
  Future<AppDataModel> updateAppData(String id, UpdateAppDataParams params) async {
    return await provider.updateAppData(id, params, token: token);
  }

  @override
  Future<void> deleteAppData(String id) async {
    return await provider.deleteAppData(id, token: token);
  }

  @override
  Future<AppDataModel> toggleAppData(String id) async {
    return await provider.toggleAppData(id, token: token);
  }
}
