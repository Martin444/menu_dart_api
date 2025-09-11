import 'dart:typed_data';

class UpdateUserRequest {
  final String userId;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final bool? needToChangePassword;
  final Uint8List? photoBytes;
  final String? photoFilename;

  UpdateUserRequest({
    required this.userId,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.needToChangePassword,
    this.photoBytes,
    this.photoFilename,
  });

  Map<String, dynamic> toFormData() {
    final Map<String, dynamic> formData = {};

    if (name != null) formData['name'] = name;
    if (email != null) formData['email'] = email;
    if (phone != null) formData['phone'] = phone;
    if (role != null) formData['role'] = role;
    if (needToChangePassword != null) {
      formData['needToChangepassword'] = needToChangePassword.toString();
    }

    return formData;
  }

  bool get hasPhoto => photoBytes != null && photoBytes!.isNotEmpty;
}
