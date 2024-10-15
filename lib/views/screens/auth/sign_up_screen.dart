import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_allam/controllers/services/auth_provider.dart';
import 'package:t_allam/views/screens/home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 80),
                Center(child: Image.asset('lib/assets/images/logo.png', height: 200)),
                const SizedBox(height: 40),
                _buildTextField(
                  controller: _emailController,
                  label: 'أدخل بريدك الإلكتروني',
                  validator: (value) => value!.isEmpty ? 'البريد الإلكتروني مطلوب' : null,
                ),
                const SizedBox(height: 20),
                _buildPasswordField(controller: _passwordController, label: 'أدخل كلمة المرور', isForConfirmPassword: false),
                const SizedBox(height: 20),
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  label: 'تأكيد كلمة المرور',
                  validator: (value) => value != _passwordController.text ? 'كلمات المرور غير متطابقة' : null,
                  isForConfirmPassword: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: const Color(0xFF8A2BE2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('سجل الآن', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isForConfirmPassword,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: isForConfirmPassword ? _toggleConfirmPasswordVisibility : _togglePasswordVisibility,
        ),
      ),
      validator: validator ?? (value) => value!.isEmpty ? 'كلمة المرور مطلوبة' : null,
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      await Provider.of<AuthProvider>(context, listen: false).signUp(email: _emailController.text.trim(), password: _passwordController.text.trim());
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    }
  }
}
