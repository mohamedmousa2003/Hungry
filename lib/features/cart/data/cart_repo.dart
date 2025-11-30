import 'package:untitled/core/network/api_service.dart';
import '../../../core/network/api_error.dart';
import 'model/CartModel.dart';
import 'model/GetCardResponse.dart';

class CartRepo {
  final ApiService apiService = ApiService();


  // App to cart
  Future<void> addToCart(CartModel cartData) async {
    try {
      final res = await apiService.post('/cart/add', cartData.toJson());
      if (res['code']==200&& res['data'] == null) {
        throw ApiError(message: res['message']);
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError(message: 'Something went wrong while adding to cart');
    }
  }

  // get cart
  Future<GetCardResponse?> getToCart() async {
    try {
      final res = await apiService.get('/cart');
      if (res is ApiError) {
        throw ApiError(message: res.message);
      }
      return GetCardResponse.fromJson(res); // هنا نحول JSON لكائن
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError(message: 'Something went wrong while fetching cart');
    }
  }

  //? remove
  Future<void> removeToCart(int id) async {
    try {
      final res = await apiService.delete('/cart/remove/${id}', {});
      if (res['code']==200&& res['data'] == null) {
        throw ApiError(message: res['message'] ?? 'Failed to delete product to cart');
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError(message: 'Something went wrong while adding to cart');
    }
  }



}
