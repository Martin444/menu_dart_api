import '../repository/app_data_repository.dart';

class DeleteAppDataUseCase {
  final AppDataRepository repository;

  const DeleteAppDataUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteAppData(id);
  }
}
