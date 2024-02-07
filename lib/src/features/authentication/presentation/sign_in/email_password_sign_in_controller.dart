import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Controller for managing email/password sign-in and registration actions
class EmailPasswordSignInController
    extends StateNotifier<EmailPasswordSignInState> {
  // Constructor, injecting dependencies
  EmailPasswordSignInController({
    required EmailPasswordSignInFormType
        formType, // Type of form (sign in or register)
    required this.authRepository, // Repository for authentication operations
  }) : super(EmailPasswordSignInState(formType: formType));

  final FakeAuthRepository authRepository; // Repository for authentication

  // Submits the email and password for authentication
  Future<bool> submit(String email, String password) async {
    // Update state to indicate loading
    state = state.copyWith(value: const AsyncValue.loading());

    // Try authenticating with error handling
    final value = await AsyncValue.guard(() => _authenticate(email, password));

    // Update state with authentication result
    state = state.copyWith(value: value);

    // Return whether authentication was successful or not
    return value.hasError == false;
  }

  // Performs authentication based on form type (sign in or register)
  Future<void> _authenticate(String email, String password) {
    switch (state.formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return authRepository.createUserWithEmailAndPassword(email, password);
    }
  }

  // Updates the form type (sign in or register)
  void updateFormType(EmailPasswordSignInFormType formType) {
    state = state.copyWith(formType: formType);
  }
}

// Provider for creating EmailPasswordSignInController instances
final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose
    .family<EmailPasswordSignInController, EmailPasswordSignInState,
        EmailPasswordSignInFormType>(
  (ref, formType) {
    // Access authentication repository
    final authRepository = ref.watch(authRepositoryProvider);

    // Create and return controller
    return EmailPasswordSignInController(
      authRepository: authRepository,
      formType: formType,
    );
  },
);
