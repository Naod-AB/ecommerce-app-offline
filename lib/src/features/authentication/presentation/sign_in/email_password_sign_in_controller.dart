import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart'; // Likely a class for interacting with authentication mechanisms
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart'; // Likely an enum defining sign in form types (e.g. sign in, register)
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Provider library for state management

class EmailPasswordSignInController extends StateNotifier<AsyncValue<void>> {
  EmailPasswordSignInController(this.ref) : super(const AsyncData<void>(null));

  final Ref ref;

  // Function to handle sign in/register form submission
  Future<bool> submit({
    required String email,
    required String password,
    required EmailPasswordSignInFormType formType,
  }) async {
    // Update state to show loading indicator
    state = const AsyncValue.loading();

    // Try to authenticate and update state with the result
    state =
        await AsyncValue.guard(() => _authenticate(email, password, formType));

    // Return true if there are no errors in the state
    return state.hasError == false;
  }

  // Internal function for authentication logic
  Future<void> _authenticate(
      String email, String password, EmailPasswordSignInFormType formType) {
    // Read the auth repository provider
    final authRepository = ref.read(authRepositoryProvider);

    // Perform different actions based on the form type
    switch (formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return authRepository.createUserWithEmailAndPassword(email, password);
    }
  }
}

// Provider to access the EmailPasswordSignInController
final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose<
    EmailPasswordSignInController, AsyncValue<void>>((ref) {
  return EmailPasswordSignInController(ref);
});
