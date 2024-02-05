import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountScreenControllerProvider =
    StateNotifierProvider.autoDispose<AccountScreenController, AsyncValue>(
        (ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(
    authoRepository: authRepository,
  );
});

class AccountScreenController extends StateNotifier<AsyncValue> {
  AccountScreenController({required this.authoRepository})
      : super(const AsyncValue.data(null));
  final FakeAuthRepository authoRepository;

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => authoRepository.signOut());

// try {
    //   await authoRepository.signOut();
    //   state = const AsyncValue.data(null);
    //   return true;
    // } catch (e, s) {
    //   state = AsyncValue.error(e, s);
    //   return false;
    // }
  }
}
