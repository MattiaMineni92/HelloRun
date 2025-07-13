import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'lista_attivita_page.dart';

void main() {
  runApp(const HelloRunApp());
}

class HelloRunApp extends StatelessWidget {
  const HelloRunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HelloRun',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AttivitaFormPage(),
    );
  }
}

class AttivitaFormPage extends StatefulWidget {
  const AttivitaFormPage({super.key});

  @override
  State<AttivitaFormPage> createState() => _AttivitaFormPageState();
}

class _AttivitaFormPageState extends State<AttivitaFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();

  Future<void> _inviaDati() async {
    final nome = _nomeController.text;
    final km = double.tryParse(_kmController.text);

    if (km == null || nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inserisci nome e km validi')),
      );
      return;
    }

    final url = Uri.parse('https://hello-run-api.onrender.com/api/attivita'); // modifica se serve
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nome': nome, 'km': km}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attività salvata!')),
      );
      _nomeController.clear();
      _kmController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore: ${response.body}')),
      );
    }
  }

  void _vaiAllaLista() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListaAttivitaPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuova Attività')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome Attività'),
            ),
            TextFormField(
              controller: _kmController,
              decoration: const InputDecoration(labelText: 'Km percorsi'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _inviaDati,
              child: const Text('Salva'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _vaiAllaLista,
              child: const Text('Visualizza Attività'),
            ),
          ],
        ),
      ),
    );
  }
}
