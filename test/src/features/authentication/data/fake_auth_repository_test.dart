import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final productsRepository = FakeProductsRepository();
  test('getProductsList returns global list', () {
    expect(productsRepository.getProductsList(), kTestProducts);
  });

  test('getProduct(1) returns first item', () {
    expect(productsRepository.getProduct('1'), kTestProducts[0]);
  });

  test('getProduct(100) returns null', () {
    expect(() => productsRepository.getProduct('100'), throwsStateError);
  });
}
