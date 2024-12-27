import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Servicio para obtener datos de la API

/// Página que muestra la lista de eventos disponibles.
/// Obtiene los datos desde una API y los renderiza en un diseño profesional.
class EventsPage extends StatefulWidget {
  const EventsPage({super.key}); // Uso de `super.key` para evitar errores con claves en widgets.

  @override
  State<EventsPage> createState() => _EventsPageState(); // Asocia el estado con este widget.
}

/// Clase de estado que gestiona la lógica y el renderizado de la página de eventos.
class _EventsPageState extends State<EventsPage> {
  List<dynamic> events = []; // Lista para almacenar los datos de los eventos.
  bool isLoading = true; // Indicador de estado de carga.

  @override
  void initState() {
    super.initState();
    fetchEvents(); // Llama al método para obtener los eventos al iniciar.
  }

  /// Método para obtener los datos de eventos desde la API.
  /// Maneja el estado de la lista de eventos y el indicador de carga.
  Future<void> fetchEvents() async {
    try {
      final response = await ApiService.getData('eventos'); // Llama al servicio de la API.
      if (response != null) {
        setState(() {
          events = response; // Actualiza la lista de eventos con los datos recibidos.
          isLoading = false; // Cambia el estado de carga a completado.
        });
      } else {
        setState(() {
          isLoading = false; // Finaliza la carga aunque no haya datos disponibles.
        });
      }
    } catch (e) {
      // Manejo de errores: Cambia el estado para finalizar la carga y registrar el error si es necesario.
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Construye la interfaz gráfica de la página.
  /// Renderiza un indicador de carga, un mensaje de no datos o la lista de eventos.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'), // Título de la página.
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Indicador de carga mientras se obtienen datos.
            )
          : events.isEmpty
              ? const Center(
                  child: Text(
                    'No hay eventos disponibles.', // Mensaje cuando no hay datos.
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: events.length, // Número total de eventos en la lista.
                  itemBuilder: (context, index) {
                    final event = events[index]; // Evento actual.
                    return Card(
                      margin: const EdgeInsets.all(10.0), // Espaciado entre tarjetas.
                      elevation: 3, // Sombra para un diseño más atractivo.
                      child: ListTile(
                        leading: const Icon(
                          Icons.event, // Icono asociado a cada evento.
                          color: Colors.orange, // Color del icono.
                        ),
                        title: Text(
                          event['title'] ?? 'Sin título', // Muestra el título del evento o un fallback.
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, // Resalta el título.
                          ),
                        ),
                        subtitle: Text(
                          '${event['event_date'] ?? 'Fecha no disponible'} - ${event['location'] ?? 'Ubicación no disponible'}',
                          style: const TextStyle(fontSize: 14.0), // Estilo del subtítulo.
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
