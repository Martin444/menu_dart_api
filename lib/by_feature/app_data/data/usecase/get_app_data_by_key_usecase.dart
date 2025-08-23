import '../repository/app_data_repository.dart';
import '../../models/app_data_model.dart';

class GetAppDataByKeyUseCase {
  final AppDataRepository repository;

  const GetAppDataByKeyUseCase(this.repository);

  Future<AppDataModel> call(String key) async {
    return await repository.getAppDataByKey(key);
  }
}
