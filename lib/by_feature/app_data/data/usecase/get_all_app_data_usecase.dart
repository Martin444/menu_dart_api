import '../repository/app_data_repository.dart';
import '../../models/app_data_model.dart';

class GetAllAppDataUseCase {
  final AppDataRepository repository;

  const GetAllAppDataUseCase(this.repository);

  Future<List<AppDataModel>> call() async {
    return await repository.getAllAppData();
  }
}
