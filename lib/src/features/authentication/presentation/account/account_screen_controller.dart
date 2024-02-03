import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(
    authoRepository: authRepository,
  );
});

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authoRepository})
      : super(const AsyncValue<void>.data(null));
  final FakeAuthRepository authoRepository;

  Future<bool> signOut() async {
    try {
      state = const AsyncValue<void>.loading();
      await authoRepository.signOut();
      state = const AsyncValue<void>.data(null);
      return true;
    } catch (e, s) {
      state = AsyncValue<void>.error(e, s);
      return false;
    }
  }
}
