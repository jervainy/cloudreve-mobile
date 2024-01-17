import 'package:cloudreve_mobile/common/global.dart';
import 'package:cloudreve_mobile/common/http.dart';
import 'package:cloudreve_mobile/models/file_model.dart';
import 'package:cloudreve_mobile/models/token.dart';

class WebDavApi {

  static const String _apiVersion = '/api/v3';

  static String _apiPath(String path) {
    return "$_apiVersion$path";
  }

  static Future<TokenUserData> login(String username, String password) async {
    var response = await HttpDio.dio.post(_apiPath('/user/session'), data: {
      'userName': username,
      'Password': password,
      'captchaCode': ''
    });
    Global.saveToken(response.headers.value('Set-Cookie') as String);
    final responseData = response.data as Map<String, dynamic>;
    final dataMap = responseData['data'] as Map<String, dynamic>;
    return TokenUserData(dataMap['id'] as String, dataMap['user_name'] as String, dataMap['nickname'] as String,
      avatar: dataMap['avatar'] as String
    );
  }

  static Future<FileModel> fileList(String path) async {
    var response = await HttpDio.dio.get(_apiPath("/directory$path"));
    var responseData = response.data as Map<String, dynamic>;
    var dataMap = responseData['data'] as Map<String, dynamic>;
    var objectsData = dataMap['objects'] as List<dynamic>;
    var objects = objectsData.map((e) {
      var obj = e as Map<String, dynamic>;
      return FileItemModel(
        obj['id'] as String,
        obj['path'] as String,
        obj['name'] as String,
        obj['type'] as String,
        size: obj['size'] as int,
        createdAt: obj['create_date'] as String,
        lastAt: obj['date'] as String
      );
    }).toList();
    return FileModel(dataMap['parent'] as String, objects);
  }

}