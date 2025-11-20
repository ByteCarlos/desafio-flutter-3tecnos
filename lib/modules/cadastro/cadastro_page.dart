import 'dart:io';
import 'package:desafio_3tecnos/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/utils/input_masks.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  File? foto;
  final picker = ImagePicker();

  Future pegarFoto() async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Tirar foto"),
                onTap: () async {
                  Navigator.pop(context);
                  final img = await picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (img != null) {
                    setState(() => foto = File(img.path));
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Escolher da galeria"),
                onTap: () async {
                  Navigator.pop(context);
                  final img = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (img != null) {
                    setState(() => foto = File(img.path));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  final cpfController = TextEditingController();
  final nomeController = TextEditingController();
  final phoneController = TextEditingController();

  // === VALIDAÇÃO DE CPF ===
  bool validarCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (cpf.length != 11) return false;
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;

    int soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += int.parse(cpf[i]) * (10 - i);
    }
    int digito1 = (soma * 10) % 11;
    if (digito1 == 10) digito1 = 0;
    if (digito1 != int.parse(cpf[9])) return false;

    soma = 0;
    for (int i = 0; i < 10; i++) {
      soma += int.parse(cpf[i]) * (11 - i);
    }
    int digito2 = (soma * 10) % 11;
    if (digito2 == 10) digito2 = 0;
    if (digito2 != int.parse(cpf[10])) return false;

    return true;
  }

  void cadastrar() {
    if (_formKey.currentState!.validate()) {
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
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("Cadastro")),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // FOTO
                  GestureDetector(
                    onTap: pegarFoto,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: foto != null ? FileImage(foto!) : null,
                      backgroundColor: Colors.white,
                      child: foto == null
                          ? const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // CAMPO CPF
                  TextFormField(
                    controller: cpfController,
                    inputFormatters: [cpfMask],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "CPF",
                      prefixIcon: const Icon(Icons.badge),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      String unmasked = cpfMask.getUnmaskedText();
                      if (unmasked.isEmpty) return "Digite seu CPF";
                      if (!validarCPF(unmasked)) return "CPF inválido";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // CAMPO NOME
                  TextFormField(
                    controller: nomeController,
                    decoration: InputDecoration(
                      hintText: "Nome",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Digite seu nome";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // CAMPO TELEFONE
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [phoneMask],
                    decoration: InputDecoration(
                      hintText: "Telefone",
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Digite seu telefone";
                      }
                      if (phoneMask.getUnmaskedText().length < 10) {
                        return "Telefone inválido";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // BOTÃO CADASTRAR
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: cadastrar,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: AppColors.secondary,
                      ),
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
