import 'package:flutter/material.dart';
import 'home_page.dart'; // Página principal de la aplicación

/// Página de bienvenida que introduce al usuario a la aplicación.
/// Diseñada con un diseño atractivo y profesional para causar una buena primera impresión.
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key); // Uso de `super.key` para soporte de claves de widgets.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // La estructura principal de la página
      body: Stack(
        children: [
          // Fondo con degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange], // Degradado del naranja claro al oscuro
                begin: Alignment.topLeft, // Punto inicial del degradado
                end: Alignment.bottomRight, // Punto final del degradado
              ),
            ),
          ),
          // Contenido principal centrado
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0), // Margen alrededor del contenido
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
                children: [
                  // Título de la aplicación
                  const Text(
                    'Smart City León',
                    style: TextStyle(
                      fontSize: 32, // Tamaño grande para destacar
                      fontWeight: FontWeight.bold, // Negrita para énfasis
                      color: Colors.white, // Contraste con el fondo
                    ),
                  ),
                  const SizedBox(height: 20), // Espacio entre el título y la descripción
                  // Descripción de la aplicación
                  const Text(
                    'Explora eventos, agenda y avisos importantes '
                    'de la ciudad de León. Tu guía completa para una '
                    'experiencia urbana inteligente.',
                    textAlign: TextAlign.center, // Centra el texto
                    style: TextStyle(
                      fontSize: 16, // Tamaño moderado para ser legible
                      color: Colors.white70, // Color ligeramente más tenue
                    ),
                  ),
                  const SizedBox(height: 40), // Espacio entre la descripción y el botón
                  // Botón para comenzar la experiencia
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Tamaño del botón
                      backgroundColor: Colors.white, // Fondo blanco para contraste
                      foregroundColor: Colors.deepOrange, // Color del texto y borde
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Esquinas redondeadas
                      ),
                    ),
                    onPressed: () {
                      // Navega a la página principal al presionar el botón
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    child: const Text(
                      'Comenzar',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Texto claro y destacado
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
