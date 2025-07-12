import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'attivita.dart';

class ListaAttivitaPage extends StatefulWidget {
  const ListaAttivitaPage({super.key});

  @override
  State<ListaAttivitaPage> createState() => _ListaAttivitaPageState();
}

class _ListaAttivitaPageState extends State<ListaAttivitaPage> {
  List<Attivita> attivitaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAttivita();
  }

  Future<void> fetchAttivita() async {
    final url = Uri.parse('http://localhost:5270/api/attivita'); // Modifica se serve
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      setState(() {
        attivitaList = jsonList.map((e) => Attivita.fromJson(e)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore nel recupero dati: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Le tue attività')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: attivitaList.length,
              itemBuilder: (context, index) {
                final a = attivitaList[index];
                return ListTile(
                  title: Text('${a.nome} - ${a.km} km'),
                  subtitle: Text('Data: ${a.data.toLocal().toString().split(' ')[0]}'),
                );
              },
            ),
    );
  }
}
