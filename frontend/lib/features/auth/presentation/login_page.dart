import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/brand_mark.dart';
import '../../../shared/widgets/password_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/text_link.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.of(context).pushReplacementNamed('/home');
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
                    'Selamat datang kembali! Mari kita masak.',
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
                    hint: 'Masukkan kata sandi',
                    prefixIcon: Icons.lock_outline_rounded,
                    controller: _passwordCtrl,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextLink(
                      text: 'Lupa kata sandi?',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(label: 'Masuk', onPressed: _submit),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun?',
                        style: AppTypography.body.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 4),
                      TextLink(
                        text: 'Daftar di sini',
                        onTap: () =>
                            Navigator.of(context).pushNamed('/register'),
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
