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
  static _ProductEndPoints productEndPoints = _ProductEndPoints();
  static _CartEndPoints cartEndPoints = _CartEndPoints();
  static _AddressEndPoints addressEndPoints = _AddressEndPoints();
  static _RajaOngkirEndPoints rajaOngkirEndPoints = _RajaOngkirEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = '';
  final String loginEmail = '/api/auth/login';
  final String logout = '/api/auth/logout';
  final String me = '/api/auth/me';
}

class _AddressEndPoints {
  final String addressIndex = '/api/auth/address';
  final String addressAdd = '/api/auth/address';
  final String updateStatus = '/api/auth/address/update/';
  final String addressSelect = '/api/auth/address/selected';
}

class _RajaOngkirEndPoints {
  final String shippingData = 'https://pro.rajaongkir.com/api/cost';
}

class _ProductEndPoints {
  final String category = '/api/category';
  final String product = '/api/product/';
  final String show = '/api/product/show/';
  final String recomend = '/api/product/recomendation/';
  final String carousel = '/api/carousel/';
}

class _CartEndPoints {
  final String cart = '/api/auth/cart';
  final String store = '/api/auth/cart';
  final String delete = '/api/auth/cart/delete/';
  final String update = '/api/auth/cart/update/';
}
