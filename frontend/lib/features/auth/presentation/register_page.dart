import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/brand_mark.dart';
import '../../../shared/widgets/password_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/text_link.dart';
import '../../shell/presentation/home_shell.dart';
import '../application/auth_controller.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  static const String route = '/register';

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
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

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;
    final confirm = _confirmCtrl.text;
    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      _showSnack('Lengkapi semua kolom.');
      return;
    }
    if (password.length < 8) {
      _showSnack('Kata sandi minimal 8 karakter.');
      return;
    }
    if (password != confirm) {
      _showSnack('Konfirmasi kata sandi tidak cocok.');
      return;
    }
    await ref
        .read(authControllerProvider.notifier)
        .register(email, password);
    if (!mounted) return;
    final state = ref.read(authControllerProvider);
    if (state.hasError) {
      _showSnack(authErrorMessage(state.error!));
    } else if (state.value != null) {
      Navigator.of(context).pushReplacementNamed(HomeShell.route);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authControllerProvider).isLoading;
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
                  const BrandMark(size: 80, icon: Icons.restaurant_rounded),
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
                    enabled: !loading,
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
                  PrimaryButton(
                    label: loading ? 'Memuat...' : 'Daftar',
                    onPressed: loading ? null : _submit,
                  ),
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
