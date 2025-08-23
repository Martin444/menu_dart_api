import '../repository/app_data_repository.dart';
import '../../models/app_data_model.dart';
import '../../models/update_app_data_params.dart';

class UpdateAppDataUseCase {
  final AppDataRepository repository;

  const UpdateAppDataUseCase(this.repository);

  Future<AppDataModel> call(String id, UpdateAppDataParams params) async {
    return await repository.updateAppData(id, params);
  }
}
