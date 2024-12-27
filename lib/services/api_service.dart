import 'dart:convert'; // Librería para manejo de JSON
import 'package:http/http.dart' as http; // Librería para realizar solicitudes HTTP

/// Servicio de API para manejar solicitudes y obtener datos desde un servidor.
class ApiService {
  /// Base URL del servidor
  static const String _baseUrl = 'http://localhost:3000/api';

  /// Método para realizar una solicitud GET a un endpoint específico.
  ///
  /// Parámetros:
  /// - [endpoint]: El nombre del endpoint al que se desea hacer la solicitud.
  ///
  /// Retorna:
  /// - Una lista con los datos obtenidos si la solicitud fue exitosa.
  /// - `null` si hubo algún error o el servidor no devolvió un estado HTTP 200.
  static Future<List?> getData(String endpoint) async {
    try {
      // Construye la URL completa para el endpoint solicitado
      final url = Uri.parse('$_baseUrl/$endpoint/');
      final response = await http.get(url); // Realiza la solicitud GET

      // Verifica si la respuesta tiene un código de estado 200 (éxito)
      if (response.statusCode == 200) {
        // Decodifica el cuerpo de la respuesta JSON y retorna los datos
        return json.decode(response.body) as List;
      } else {
        // Retorna null si el código de estado no es 200
        return null;
      }
    } catch (e) {
      // Manejo de errores en caso de que ocurra una excepción
      print('Error al obtener datos de la API: $e'); // Log para depuración
      return null;
    }
  }
}
