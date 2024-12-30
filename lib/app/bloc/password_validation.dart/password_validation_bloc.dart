import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_task_bloc_project/app/bloc/password_validation.dart/password_validation_event.dart';

import 'password_validation_state.dart';

class PasswordVisibilityBloc
    extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc() : super(PasswordVisibilityInitial()) {
    on<TogglePasswordVisibility>(
      (event, emit) {
        emit(PasswordVisibilityToggled(!state.isPasswordVisible));
      },
    );
  }
}
