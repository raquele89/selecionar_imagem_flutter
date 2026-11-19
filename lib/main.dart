import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Selecionar Imagem',
      home: const TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  File? imagemSelecionada;

  final ImagePicker picker = ImagePicker();

  Future<void> selecionarImagem() async {
    final XFile? imagem = await picker.pickImage(source: ImageSource.gallery);
    if (!mounted) return;

    if (imagem != null) {
      setState(() {
        imagemSelecionada = File(imagem.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhuma imagem foi selecionada!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecionar Imagem'), centerTitle: true),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: selecionarImagem,
              child: const Text('Selecionar imagem'),
            ),

            const SizedBox(height: 20),

            imagemSelecionada != null
                ? Image.file(
                    imagemSelecionada!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : const Text('Nenhuma imagem selecionada'),
          ],
        ),
      ),
    );
  }
}
