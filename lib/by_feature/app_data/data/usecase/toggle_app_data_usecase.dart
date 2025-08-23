import '../repository/app_data_repository.dart';
import '../../models/app_data_model.dart';

class ToggleAppDataUseCase {
  final AppDataRepository repository;

  const ToggleAppDataUseCase(this.repository);

  Future<AppDataModel> call(String id) async {
    return await repository.toggleAppData(id);
  }
}
