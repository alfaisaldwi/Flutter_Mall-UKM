class ApiEndPoints {
  static final String baseUrl = 'https://nonameapi.my.id';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
  static _ProductEndPoints productEndPoints = _ProductEndPoints();
  static _CartEndPoints cartEndPoints = _CartEndPoints();
  static _AddressEndPoints addressEndPoints = _AddressEndPoints();
  static _RajaOngkirEndPoints rajaOngkirEndPoints = _RajaOngkirEndPoints();
  static _TransactionEndPoints transactionEndPoints = _TransactionEndPoints();
  static _ProfileCompany profileCompany = _ProfileCompany();
  static _CheckHaversine checkHaversine = _CheckHaversine();
  static _CSI csi = _CSI();
}

class _AuthEndPoints {
  final String register = '/api/auth/register';
  final String loginEmail = '/api/auth/login';
  final String logout = '/api/auth/logout';
  final String me = '/api/auth/me';
}

class _ProfileCompany {
  final String index = '/api/profile/company';
}

class _CheckHaversine {
  final String check = '/api/check/haverinse';
}
class _CSI {
  final String question = '/api/auth/question';
  final String store = '/api/auth/result/store';
}

class _AddressEndPoints {
  final String addressIndex = '/api/auth/address';
  final String addressAdd = '/api/auth/address/store';
  final String updateStatus = '/api/auth/address/update/';
  final String addressSelect = '/api/auth/address/selected';
  final String addressDelete = '/api/auth/address/delete/';
}

class _RajaOngkirEndPoints {
  final String shippingData = 'https://pro.rajaongkir.com/api/cost';
}

class _TransactionEndPoints {
  final String index = '/api/auth/transaction';
  final String show = '/api/auth/transaction/show';
  final String store = '/api/auth/transaction/store';
  final String unpaid = '/api/auth/transaction/unpaid';
  final String paid = '/api/auth/transaction/paid';
}

class _ProductEndPoints {
  final String category = '/api/category';
  final String categoryshow = '/api/category/show';
  final String product = '/api/product/';
  final String show = '/api/product/show/';
  final String recomend = '/api/product/recomendation/';
  final String carousel = '/api/carousel/';
  final String recomendshow = '/api/category/recomendation';
}

class _CartEndPoints {
  final String cart = '/api/auth/cart';
  final String store = '/api/auth/cart/store';
  final String delete = '/api/auth/cart/delete/';
  final String update = '/api/auth/cart/update/';
}
