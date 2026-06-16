import 'package:menu_dart_api/by_feature/commerce/data/provider/commerce_provider.dart';
import 'package:menu_dart_api/by_feature/commerce/data/repository/commerce_repository.dart';
import 'package:menu_dart_api/by_feature/commerce/models/commerce.dart';
import 'package:menu_dart_api/by_feature/commerce/models/commerce_requests.dart';

class CreateCommerceUseCase {
  final CommerceRepository _repository;

  CreateCommerceUseCase([CommerceRepository? repository])
      : _repository = repository ?? CommerceProvider();

  Future<Commerce> execute(CreateCommerceRequest request) async {
    return await _repository.create(request);
  }
}

class GetMyCommercesUseCase {
  final CommerceRepository _repository;

  GetMyCommercesUseCase([CommerceRepository? repository])
      : _repository = repository ?? CommerceProvider();

  Future<List<Commerce>> execute() async {
    return await _repository.getMyCommerces();
  }
}

class GetCommerceByIdUseCase {
  final CommerceRepository _repository;

  GetCommerceByIdUseCase([CommerceRepository? repository])
      : _repository = repository ?? CommerceProvider();

  Future<Commerce> execute(String commerceId) async {
    return await _repository.getById(commerceId);
  }
}

class UpdateCommerceUseCase {
  final CommerceRepository _repository;

  UpdateCommerceUseCase([CommerceRepository? repository])
      : _repository = repository ?? CommerceProvider();

  Future<Commerce> execute(String commerceId, UpdateCommerceRequest request) async {
    return await _repository.update(commerceId, request);
  }
}

class DeleteCommerceUseCase {
  final CommerceRepository _repository;

  DeleteCommerceUseCase([CommerceRepository? repository])
      : _repository = repository ?? CommerceProvider();

  Future<void> execute(String commerceId) async {
    await _repository.delete(commerceId);
  }
}
