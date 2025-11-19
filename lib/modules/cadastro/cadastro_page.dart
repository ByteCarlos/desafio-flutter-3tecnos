import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/utils/input_masks.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  File? foto;
  final picker = ImagePicker();

  Future pegarFoto() async {
    final img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() => foto = File(img.path));
    }
  }

  final cpfController = TextEditingController();
  final nomeController = TextEditingController();
  final phoneController = TextEditingController();

  void cadastrar() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Sucesso!"),
        content: const Text("Cadastrado com sucesso."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pegarFoto,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: foto != null ? FileImage(foto!) : null,
                child: foto == null
                    ? const Icon(Icons.camera_alt, size: 40)
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: cpfController,
              decoration: const InputDecoration(labelText: "CPF"),
              inputFormatters: [cpfMask],
            ),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome"),
            ),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Telefone"),
              keyboardType: TextInputType.number,
              inputFormatters: [phoneMask],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: cadastrar,
              child: const Text("Cadastrar"),
            )
          ],
        ),
      ),
    );
  }
}
