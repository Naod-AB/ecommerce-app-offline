import 'package:ecommerce_app/src/features/cart/application/cart_service.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Controller for managing adding items to the cart
class AddToCartController extends StateNotifier<AsyncValue<int>> {
  // Constructor, injecting CartService dependency
  AddToCartController({required this.cartService}) : super(const AsyncData(1));
  final CartService cartService;

  // Updates the quantity of the item to be added
  void updateQuantity(int quantity) {
    state = AsyncData(quantity);
  }

  Future<void> addItem(ProductID productId) async {
// Create an Item object with the product ID and current quantity
    final item = Item(productId: productId, quantity: state.value!);
    state = const AsyncLoading<int>().copyWithPrevious(state);
    final value = await AsyncValue.guard(() => cartService.addItem(item));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(1);
    }
  }
}

final addToCartControllerProvider =
    StateNotifierProvider.autoDispose<AddToCartController, AsyncValue<int>>(
        (ref) {
  return AddToCartController(
    cartService: ref.watch(cartServiceProvider),
  );
});
