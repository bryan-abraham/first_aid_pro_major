import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Model/Image_upload_model/image_upload_model.dart';
import '../core/data/api_client.dart';
import '../core/data/api_endpoint.dart';

class ImageUploadViewModelRepo extends ApiClient {
  ImageUploadViewModelRepo();
// POST
  Future<ImageUpload> imageUpload(String filePath, context) async {
    String filename = filePath.split('/').last;

    FormData body = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath, filename: filename),
    });
    try {
      final response =
          await postRequest(path: ApiEndPointUrls.imageUpload, body: body);

      if (response.statusCode == 200) {
        final responseData = imageUploadFromJson(jsonEncode(response.data));
        return responseData;
      } else {
        ImageUpload();
      }
    } on Exception catch (e) {
      VxToast.show(context, msg: e.toString());
      ImageUpload();
    }

    return ImageUpload();
  }
}
