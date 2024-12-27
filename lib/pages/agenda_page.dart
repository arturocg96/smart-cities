import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Importación del servicio de API para obtener datos

/// Página que muestra los eventos disponibles en la agenda.
/// Es un widget con estado que actualiza dinámicamente los datos cuando se obtienen.
class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key}); // Uso de `super.key` para manejar claves en widgets correctamente

  @override
  State<AgendaPage> createState() => _AgendaPageState(); // Crea el estado asociado al widget
}

/// Clase de estado que controla la lógica de la página de agenda.
/// Incluye la obtención de datos de la API, gestión de estados y renderización.
class _AgendaPageState extends State<AgendaPage> {
  List<dynamic> agenda = []; // Lista para almacenar los datos de los eventos de la agenda
  bool isLoading = true; // Estado de carga para indicar si los datos están siendo obtenidos

  /// Método llamado automáticamente al inicializar el estado.
  /// Aquí se realiza la carga inicial de los datos de la agenda.
  @override
  void initState() {
    super.initState();
    fetchAgenda(); // Llama a la función que obtiene los datos desde la API
  }

  /// Método para obtener la lista de eventos de la agenda desde el servicio API.
  /// Maneja la lógica de actualización del estado según el resultado de la solicitud.
  Future<void> fetchAgenda() async {
    try {
      final response = await ApiService.getData('agenda'); // Solicita datos desde la API
      if (response != null) {
        setState(() {
          agenda = response; // Actualiza la lista de eventos
          isLoading = false; // Indica que los datos ya se cargaron
        });
      } else {
        setState(() {
          isLoading = false; // Finaliza el estado de carga aunque no haya datos disponibles
        });
      }
    } catch (e) {
      // En caso de error, actualiza el estado y maneja la excepción
      setState(() {
        isLoading = false;
      });
      // Opcional: Mostrar mensaje de error al usuario
    }
  }

  /// Método para construir el widget de la interfaz.
  /// Representa la interfaz gráfica de la página de la agenda.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'), // Título que se muestra en la barra de la aplicación
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Muestra un indicador de carga mientras se obtienen los datos
            )
          : agenda.isEmpty
              ? const Center(
                  child: Text(
                    'No hay eventos disponibles.', // Mensaje cuando no hay datos en la agenda
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: agenda.length, // Cantidad de elementos en la lista
                  itemBuilder: (context, index) {
                    final item = agenda[index]; // Elemento individual de la lista
                    return Card(
                      margin: const EdgeInsets.all(10.0), // Margen alrededor de cada tarjeta
                      elevation: 3, // Añade sombra para un diseño más elegante
                      child: ListTile(
                        leading: const Icon(
                          Icons.calendar_today, // Icono que representa eventos de calendario
                          color: Colors.orange, // Color destacado para el icono
                        ),
                        title: Text(
                          item['title'] ?? 'Sin título', // Título del evento, con fallback
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, // Hace el texto más llamativo
                          ),
                        ),
                        subtitle: Text(
                          '${item['event_date'] ?? 'Fecha no disponible'} - ${item['location'] ?? 'Ubicación no disponible'}', // Muestra la fecha y ubicación
                          style: const TextStyle(fontSize: 14.0), // Tamaño de texto ajustado
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
