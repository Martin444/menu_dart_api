import 'package:flutter_test/flutter_test.dart';
import 'package:menu_dart_api/by_feature/user/update_user/update_user.dart';
import 'dart:typed_data';

void main() {
  group('UpdateUser Module Tests', () {
    test('UpdateUserRequest should create valid form data', () {
      final request = UpdateUserRequest(
        userId: 'test-user-id',
        name: 'Test User',
        email: 'test@example.com',
        phone: '123456789',
        role: 'admin',
        needToChangePassword: true,
      );

      final formData = request.toFormData();

      expect(formData['name'], equals('Test User'));
      expect(formData['email'], equals('test@example.com'));
      expect(formData['phone'], equals('123456789'));
      expect(formData['role'], equals('admin'));
      expect(formData['needToChangepassword'], equals('true'));
    });

    test('UpdateUserRequest should handle null values', () {
      final request = UpdateUserRequest(
        userId: 'test-user-id',
        name: null,
        email: 'test@example.com',
      );

      final formData = request.toFormData();

      expect(formData.containsKey('name'), isFalse);
      expect(formData['email'], equals('test@example.com'));
      expect(formData.containsKey('phone'), isFalse);
    });

    test('UpdateUserRequest should detect photo presence', () {
      final requestWithoutPhoto = UpdateUserRequest(userId: 'test-id');
      expect(requestWithoutPhoto.hasPhoto, isFalse);

      final requestWithPhoto = UpdateUserRequest(
        userId: 'test-id',
        photoBytes: Uint8List.fromList([1, 2, 3, 4]),
      );
      expect(requestWithPhoto.hasPhoto, isTrue);

      final requestWithEmptyPhoto = UpdateUserRequest(
        userId: 'test-id',
        photoBytes: Uint8List(0),
      );
      expect(requestWithEmptyPhoto.hasPhoto, isFalse);
    });

    test('UpdateUserResponse should create from JSON', () {
      final json = {
        'success': true,
        'message': 'Usuario actualizado exitosamente',
        'data': {'id': 'user-123', 'name': 'Updated User'},
      };

      final response = UpdateUserResponse.fromJson(json);

      expect(response.success, isTrue);
      expect(response.message, equals('Usuario actualizado exitosamente'));
      expect(response.userData?['id'], equals('user-123'));
    });

    test('UpdateUserResponse should handle error creation', () {
      final response = UpdateUserResponse.error('Test error message');

      expect(response.success, isFalse);
      expect(response.message, equals('Test error message'));
      expect(response.userData, isNull);
    });

    test('UpdateUserResponse should use default values for missing JSON fields', () {
      final json = <String, dynamic>{};

      final response = UpdateUserResponse.fromJson(json);

      expect(response.success, isTrue);
      expect(response.message, equals('Usuario actualizado exitosamente'));
      expect(response.userData, isNull);
    });
  });
}
