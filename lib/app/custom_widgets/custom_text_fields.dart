import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_task_bloc_project/app/common/app_colors.dart';

import '../bloc/password_validation.dart/password_validation_bloc.dart';
import '../bloc/password_validation.dart/password_validation_event.dart';
import '../bloc/password_validation.dart/password_validation_state.dart';
import '../common/app_errors.dart';

class UniversalTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final int maxLines;
  final bool readOnly;
  final bool isMakeDullOnReadOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  const UniversalTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.maxLines = 1,
    this.validator,
    this.readOnly = false,
    this.isMakeDullOnReadOnly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      focusNode: focusNode,
      controller: controller,
      validator: (email) {
        const emailPattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

        final isMatch = RegExp(emailPattern).hasMatch(email ?? '');
        if (email == null || email.isEmpty) {
          return AppErrors.fieldIsRequired;
        } else if (isMatch == false) {
          return AppErrors.emailErrorText;
        } else {
          return null;
        }
      },
      keyboardType: keyboardType ?? TextInputType.text,
      textCapitalization: textCapitalization,
      cursorColor: AppColors.primary,
      cursorWidth: 1.5,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor:
            isMakeDullOnReadOnly && readOnly ? AppColors.lightgrey : null,
        filled: readOnly && isMakeDullOnReadOnly,
        errorMaxLines: 2,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleMedium,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 2.0,
          ),
        ),
      ),
      inputFormatters: inputFormatters,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(color: AppColors.black),
      maxLines: maxLines,
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;

  const PasswordTextField({super.key, required this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordVisibilityBloc(),
      child: BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            obscureText: !state.isPasswordVisible, // Manage visibility here
            decoration: InputDecoration(
              hintText: hintText ?? "Emter ",
              hintStyle: Theme.of(context).textTheme.titleMedium,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.red,
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.red,
                  width: 2.0,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  state.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  context
                      .read<PasswordVisibilityBloc>()
                      .add(TogglePasswordVisibility());
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password cannot be empty';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
