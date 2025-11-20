import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/utils/input_masks.dart';
import '../../shared/theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cpfController = TextEditingController();
  final senhaController = TextEditingController();

  void entrar() {
    final senha = senhaController.text;
    final cpf = cpfMask.getUnmaskedText();

    if (senha == "123456" && cpf.length == 11) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("CPF ou senha inválidos")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 300,
              child: Image.asset(
                "assets/images/logo_3tecnos.png",
                fit: BoxFit.contain,
              ),
            ),

            TextField(
              controller: cpfController,
              decoration: const InputDecoration(labelText: "CPF"),
              keyboardType: TextInputType.number,
              inputFormatters: [cpfMask],
            ),

            TextField(
              controller: senhaController,
              decoration: const InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: entrar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: AppColors.secondary,
                ),
                child: const Text(
                  "Entrar",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.cadastro),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: AppColors.light,
                ),
                child: const Text(
                  "Cadastrar-se",
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
