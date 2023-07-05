import 'package:dio/dio.dart';
import 'package:mall_ukm/app/service/helper/users_helper.dart';

// class ApiClient {
//   Future getData(String path) async {
//     try {
//       final resonse =
//           await Dio(BaseOptions(baseUrl: ApiConst.baseUrl)).get(path);
//       return resonse.data;
//     } on DioException catch (e) {
//       throw Exception(e.message);
//     }
//   }
// }

class ApiEndPoints {
  static final String baseUrl = 'https://nonameapi.my.id';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = '';
  final String loginEmail = '/api/auth/login';
  final String category = '/api/auth/category';
}
