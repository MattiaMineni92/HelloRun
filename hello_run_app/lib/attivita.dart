class Attivita {
  final int id;
  final String nome;
  final double km;
  final DateTime data;

  Attivita({required this.id, required this.nome, required this.km, required this.data});

  factory Attivita.fromJson(Map<String, dynamic> json) {
    return Attivita(
      id: json['id'],
      nome: json['nome'],
      km: (json['km'] as num).toDouble(),
      data: DateTime.parse(json['data']),
    );
  }
}
