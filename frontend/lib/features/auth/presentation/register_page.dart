import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/brand_mark.dart';
import '../../../shared/widgets/password_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/text_link.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String route = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.edge,
              vertical: AppSpacing.lg,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 384),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BrandMark(
                    size: 80,
                    icon: Icons.restaurant_rounded,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'AsalKenyang',
                    textAlign: TextAlign.center,
                    style: AppTypography.h1.copyWith(color: AppColors.primary),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Mulai atur bekal harianmu.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyLg.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: 'Email',
                    mode: LabelMode.fixed,
                    hint: 'contoh@email.com',
                    prefixIcon: Icons.mail_outline_rounded,
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  PasswordField(
                    label: 'Kata Sandi',
                    mode: LabelMode.fixed,
                    hint: 'Minimal 8 karakter',
                    prefixIcon: Icons.lock_outline_rounded,
                    controller: _passwordCtrl,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  PasswordField(
                    label: 'Ulangi Kata Sandi',
                    mode: LabelMode.fixed,
                    hint: 'Ketik ulang kata sandi',
                    prefixIcon: Icons.lock_outline_rounded,
                    controller: _confirmCtrl,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(label: 'Daftar', onPressed: _submit),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun?',
                        style: AppTypography.body.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 4),
                      TextLink(
                        text: 'Masuk di sini',
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
