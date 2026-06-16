import 'dart:typed_data';

import 'package:menu_dart_api/by_feature/upload_images/data/provider/upload_image_provider.dart';

@Deprecated('Use Supabase Storage instead. Cloudinary upload endpoint is deprecated.')
class UploadFileUsesCase {
  UploadFileUsesCase();

  @Deprecated('Use Supabase Storage instead.')
  Future<String> execute(Uint8List file) async {
    try {
      var response = await UploadFileProvider().uploadFile(file);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
