import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    // await Future.delayed(const Duration(seconds: 2));
    // throw Exception('Connection failed');
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    // yield* Stream.value(_products);
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListStreamProvider = StreamProvider<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsList();
});

final productsListFutureProvider = FutureProvider<List<Product>>((ref) async {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsList();
});
