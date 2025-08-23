import '../repository/app_data_repository.dart';
import '../../models/app_data_model.dart';
import '../../models/create_app_data_params.dart';

class CreateAppDataUseCase {
  final AppDataRepository repository;

  const CreateAppDataUseCase(this.repository);

  Future<AppDataModel> call(CreateAppDataParams params) async {
    return await repository.createAppData(params);
  }
}
