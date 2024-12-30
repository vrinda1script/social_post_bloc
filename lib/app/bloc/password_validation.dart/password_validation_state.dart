abstract class PasswordVisibilityState {
  final bool isPasswordVisible;
  PasswordVisibilityState(this.isPasswordVisible);
}

class PasswordVisibilityInitial extends PasswordVisibilityState {
  PasswordVisibilityInitial() : super(false);
}

class PasswordVisibilityToggled extends PasswordVisibilityState {
  PasswordVisibilityToggled(super.isPasswordVisible);
}
