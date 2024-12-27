import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Servicio para obtener datos desde la API

/// Página que muestra la lista de avisos disponibles.
/// Organiza los avisos en dos secciones: Tráfico y Suministros.
class AvisosPage extends StatefulWidget {
  const AvisosPage({super.key}); // Uso de `super.key` para manejar claves en widgets correctamente

  @override
  State<AvisosPage> createState() => _AvisosPageState(); // Asocia el estado a este widget
}

/// Clase de estado para gestionar la lógica y el renderizado de la página de avisos.
class _AvisosPageState extends State<AvisosPage> {
  List<dynamic> avisos = []; // Lista que contiene todos los avisos
  List<dynamic> avisosTrafico = []; // Lista de avisos de tráfico
  List<dynamic> avisosSuministros = []; // Lista de avisos de suministros
  bool isLoading = true; // Indica si los datos aún están cargándose

  @override
  void initState() {
    super.initState();
    fetchAvisos(); // Llama al método para obtener datos al iniciar
  }

  /// Método para obtener los datos de avisos desde la API.
  /// Clasifica los datos en dos categorías: Tráfico y Suministros.
  Future<void> fetchAvisos() async {
    try {
      final response = await ApiService.getData('avisos'); // Llama al servicio de API
      if (response != null) {
        setState(() {
          avisos = response; // Actualiza la lista completa de avisos
          avisosTrafico = avisos
              .where((aviso) =>
                  !(aviso['title']?.toString().toLowerCase().contains('agua') ??
                      false))
              .toList(); // Filtra avisos de tráfico
          avisosSuministros = avisos
              .where((aviso) =>
                  aviso['title']?.toString().toLowerCase().contains('agua') ??
                  false)
              .toList(); // Filtra avisos de suministros
          isLoading = false; // Finaliza la carga
        });
      } else {
        setState(() {
          isLoading = false; // Finaliza la carga aunque no haya datos
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Manejo de errores: Cambia el estado para finalizar la carga
      });
      // Opcional: Mostrar mensaje de error al usuario o registrarlo
    }
  }

  /// Construye la sección de avisos con un encabezado y una lista.
  Widget buildSection(String title, List<dynamic> avisos, IconData icon, Color iconColor) {
    return avisos.isEmpty
        ? const SizedBox.shrink() // No muestra la sección si no hay avisos
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true, // Evita ocupar espacio infinito
                physics: const NeverScrollableScrollPhysics(), // Deshabilita el scroll interno
                itemCount: avisos.length,
                itemBuilder: (context, index) {
                  final aviso = avisos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(
                        icon,
                        color: iconColor,
                      ),
                      title: Text(
                        aviso['title'] ?? 'Sin título',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        aviso['subtitle'] ?? 'Sin subtítulo',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avisos'), // Título que se muestra en la barra superior
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Indicador de carga mientras se obtienen datos
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSection(
                    'Avisos de Tráfico',
                    avisosTrafico,
                    Icons.traffic,
                    Colors.orange,
                  ), // Sección de tráfico
                  buildSection(
                    'Avisos de Suministros',
                    avisosSuministros,
                    Icons.water_drop_outlined,
                    Colors.blue,
                  ), // Sección de suministros
                ],
              ),
            ),
    );
  }
}
