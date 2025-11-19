import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../shared/utils/input_masks.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("CPF ou senha inválidos")),
      );
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
            const Placeholder(
              fallbackHeight: 120,
              fallbackWidth: 120,
            ), // Espaço para LOGO

            const SizedBox(height: 32),

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

            ElevatedButton(
              onPressed: entrar,
              child: const Text("Entrar"),
            ),

            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.cadastro),
              child: const Text("Criar conta"),
            )
          ],
        ),
      ),
    );
  }
}
