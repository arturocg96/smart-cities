import 'package:flutter/material.dart';
import 'package:ayto_leon/pages/events_page.dart'; // Página para mostrar eventos
import 'package:ayto_leon/pages/agenda_page.dart'; // Página para mostrar agenda
import 'package:ayto_leon/pages/avisos_page.dart'; // Página para mostrar avisos

/// Clase principal que implementa la navegación inferior con múltiples páginas.
class HomePage extends StatefulWidget {
  const HomePage({super.key}); // Uso de `super.key` para soporte de claves de widgets.

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Clase de estado que gestiona la lógica y renderizado del `HomePage`.
class _HomePageState extends State<HomePage> {
  // Índice de la página actualmente seleccionada en la barra de navegación.
  int _selectedIndex = 0;

  // Lista de páginas asociadas a cada opción de la barra de navegación.
  final List<Widget> _pages = [
    const EventsPage(), // Página de eventos
    const AgendaPage(), // Página de agenda
    const AvisosPage(), // Página de avisos
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Contenedor principal para renderizar la página seleccionada.
      body: IndexedStack(
        index: _selectedIndex, // Renderiza solo la página activa para mantener el estado.
        children: _pages, // Lista de páginas.
      ),
      // Barra de navegación inferior que permite cambiar entre páginas.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Índice de la página seleccionada.
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Cambia a la página seleccionada.
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event), // Icono para la pestaña de eventos.
            label: 'Eventos', // Etiqueta de la pestaña de eventos.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), // Icono para la pestaña de agenda.
            label: 'Agenda', // Etiqueta de la pestaña de agenda.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning), // Icono para la pestaña de avisos.
            label: 'Avisos', // Etiqueta de la pestaña de avisos.
          ),
        ],
        selectedItemColor: Colors.orange, // Color del icono y etiqueta seleccionados.
        unselectedItemColor: Colors.grey, // Color de los iconos y etiquetas no seleccionados.
        backgroundColor: Colors.white, // Color de fondo de la barra de navegación.
        type: BottomNavigationBarType.fixed, // Evita animaciones en la barra.
        showUnselectedLabels: true, // Muestra etiquetas incluso si no están seleccionadas.
        elevation: 8.0, // Elevación para agregar sombra y profundidad.
      ),
    );
  }
}
