import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/user/update_user_role/data/repository/update_user_role_repository.dart';
import 'package:menu_dart_api/by_feature/user/update_user_role/model/update_user_role_request.dart';
import 'package:menu_dart_api/by_feature/user/update_user_role/model/update_user_role_response.dart';
import 'package:menu_dart_api/core/api.dart';

class UpdateUserRoleProvider extends UpdateUserRoleRepository {
  @override
  Future<UpdateUserRoleResponse> updateMyRole(UpdateUserRoleRequest request) async {
    try {
      final String url = '${API.defaulBaseUrl}/user/my-role';

      final response = await API.dioClient.dio.patch(
        url,
        data: request.toJson(),
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer ${API.loginAccessToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data is String ? response.data : response.data;

        if (responseData is Map<String, dynamic>) {
          return UpdateUserRoleResponse.fromJson(responseData);
        } else {
          return UpdateUserRoleResponse(
            success: true,
            message: 'Rol actualizado exitosamente',
            role: request.role,
          );
        }
      } else {
        return UpdateUserRoleResponse.error(
          'Error: ${response.statusCode ?? 'desconocido'}',
        );
      }
    } on dio.DioException catch (e) {
      String errorMessage = 'Error de conexión';

      if (e.response != null) {
        errorMessage = 'Error ${e.response?.statusCode}: ${e.response?.data}';
        return UpdateUserRoleResponse.error(errorMessage);
      } else {
        return UpdateUserRoleResponse.error(errorMessage);
      }
    } catch (e) {
      return UpdateUserRoleResponse.error('Error inesperado: ${e.toString()}');
    }
  }
}
