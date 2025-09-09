import 'package:flutter_test/flutter_test.dart';
import 'package:menu_dart_api/menu_com_api.dart';

void main() {
  group('GetUsersByRoles Tests', () {
    test('UsersByRolesParams should convert to JSON correctly', () {
      // Arrange
      const params = UsersByRolesParams(
        roles: [RolesUsers.dinning, RolesUsers.clothes],
        withVinculedAccount: true,
      );

      // Act
      final json = params.toJson();

      // Assert
      expect(json['roles'], equals(['dinning', 'clothes']));
      expect(json['withVinculedAccount'], equals(true));
    });

    test('UsersByRolesParams should create from JSON correctly', () {
      // Arrange
      final json = {
        'roles': ['dinning', 'admin'],
        'withVinculedAccount': false,
      };

      // Act
      final params = UsersByRolesParams.fromJson(json);

      // Assert
      expect(params.roles, contains(RolesUsers.dinning));
      expect(params.roles, contains(RolesUsers.admin));
      expect(params.withVinculedAccount, equals(false));
    });

    test('UserByRoleModel should parse from JSON correctly', () {
      // Arrange
      final json = {
        'id': 'user-123',
        'name': 'Test User',
        'email': 'test@example.com',
        'role': 'dinning',
        'isEmailVerified': true,
        'needToChangepassword': false,
        'createAt': '2024-01-01T00:00:00.000Z',
      };

      // Act
      final user = UserByRoleModel.fromJson(json);

      // Assert
      expect(user.id, equals('user-123'));
      expect(user.name, equals('Test User'));
      expect(user.email, equals('test@example.com'));
      expect(user.role, equals('dinning'));
      expect(user.isEmailVerified, equals(true));
      expect(user.needToChangepassword, equals(false));
      expect(user.createAt, isA<DateTime>());
    });

    test('UsersByRolesResponse should handle direct array response', () {
      // Arrange - respuesta directa como array (caso real de la API)
      final json = [
        {
          'id': 'user-1',
          'name': 'User 1',
          'email': 'user1@example.com',
          'role': 'dinning',
          'isEmailVerified': true,
          'needToChangepassword': false,
        }
      ];

      // Act
      final response = UsersByRolesResponse.fromJson(json);

      // Assert
      expect(response.users.length, equals(1));
      expect(response.total, equals(1));
      expect(response.hasUsers, equals(true));
    });

    test('UsersByRolesResponse should filter users by role', () {
      // Arrange
      final json = [
        {
          'id': 'user-1',
          'name': 'User 1',
          'role': 'dinning',
        },
        {
          'id': 'user-2',
          'name': 'User 2',
          'role': 'clothes',
        },
        {
          'id': 'user-3',
          'name': 'User 3',
          'role': 'dinning',
        }
      ];

      // Act
      final response = UsersByRolesResponse.fromJson(json);
      final dinningUsers = response.getUsersByRole('dinning');

      // Assert
      expect(dinningUsers.length, equals(2));
      expect(dinningUsers.every((user) => user.role == 'dinning'), equals(true));
    });

    test('UsersByRolesResponse should filter users with verified email', () {
      // Arrange
      final json = [
        {
          'id': 'user-1',
          'name': 'User 1',
          'isEmailVerified': true,
        },
        {
          'id': 'user-2',
          'name': 'User 2',
          'isEmailVerified': false,
        },
        {
          'id': 'user-3',
          'name': 'User 3',
          'isEmailVerified': true,
        }
      ];

      // Act
      final response = UsersByRolesResponse.fromJson(json);
      final usersWithVerifiedEmail = response.getUsersWithVerifiedEmail();

      // Assert
      expect(usersWithVerifiedEmail.length, equals(2));
      expect(
        usersWithVerifiedEmail.every((user) => user.isEmailVerified == true),
        equals(true),
      );
    });

    test('UsersByRolesResponse should filter users with social auth', () {
      // Arrange
      final json = [
        {
          'id': 'user-1',
          'name': 'User 1',
          'socialToken': 'token123',
          'firebaseProvider': null,
        },
        {
          'id': 'user-2',
          'name': 'User 2',
          'socialToken': null,
          'firebaseProvider': 'google',
        },
        {
          'id': 'user-3',
          'name': 'User 3',
          'socialToken': null,
          'firebaseProvider': null,
        }
      ];

      // Act
      final response = UsersByRolesResponse.fromJson(json);
      final usersWithSocial = response.getUsersWithSocialAuth();

      // Assert
      expect(usersWithSocial.length, equals(2));
    });

    test('GetUsersByRolesUseCase should validate empty roles list', () {
      // Arrange
      final useCase = GetUsersByRolesUseCase();
      const params = UsersByRolesParams(roles: []);

      // Act & Assert
      expect(
        () => useCase.execute(params),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
