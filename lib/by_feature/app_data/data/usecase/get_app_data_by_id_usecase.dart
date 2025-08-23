import '../repository/app_data_repository.dart';
import '../../models/app_data_model.dart';

class GetAppDataByIdUseCase {
  final AppDataRepository repository;

  const GetAppDataByIdUseCase(this.repository);

  Future<AppDataModel> call(String id) async {
    return await repository.getAppDataById(id);
  }
}
