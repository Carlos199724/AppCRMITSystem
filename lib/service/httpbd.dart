import 'dart:convert';
export 'package:crmproyect/main.dart';
import 'package:crmproyect/models/dashboardUser.dart';
import 'package:crmproyect/models/interestRecordatorio.dart';
import 'package:crmproyect/models/notification.dart';
import 'package:crmproyect/models/tificaciones.dart';
import 'package:crmproyect/models/ListInterest.dart';
import 'package:crmproyect/models/DetalleInterest.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class HttpService{
  static String _url= '';

  HttpService(){
    _url ='http://127.0.0.1:8000/api';
    //'https://crm2.itscloud.store/api'//;
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<Map<String, dynamic>> login(String username, String password, String id) async {
    final response = await http.post(
      Uri.parse('$_url/login'),
      body: {
        'username': username,
        'password': password,
        'id': id,
      },
    );

    if (response.statusCode == 200) {
      // Si la solicitud es exitosa, decodifica el cuerpo de la respuesta JSON
      // y devuélvelo como un mapa
      return jsonDecode(response.body);
    } else {
      // Si la solicitud falla, lanza una excepción con un mensaje de error
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }
// CONSUMIR LA API LISTA DE INTERESADOS
  Future<List<UserList>> getContactByUser()async{
    String? accessToken = await getAccessToken();
     if (accessToken == null) {
      // Manejar la situación donde no se encontró ningún token de acceso
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;
    final resp= await http.get(Uri.parse('$_url/interested_contacts_filter?user_id=$userId'), headers: {
      'Authorization': 'Bearer $accessToken',
    }
    );
    return (jsonDecode(resp.body)as List).map((interested_contacts) => UserList.fromJson(interested_contacts)).toList();
  }
  // CONSUMIR LA API DE HISTORIAL DE NOTIFICACIONES
  Future<List<Notifications>> getNotificationByUser() async {
  String? accessToken = await getAccessToken();
     if (accessToken == null) {
      // Manejar la situación donde no se encontró ningún token de acceso
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;
    final resp= await http.get(Uri.parse('$_url/notifications/$userId'), headers: {
      'Authorization': 'Bearer $accessToken',
    }
    );
    final Map<String, dynamic> jsonResponse = jsonDecode(resp.body);
    final List<dynamic> notificationsJson = jsonResponse['notifications'];      
    return notificationsJson.map((notification) => Notifications.fromJson(notification)).toList();
  }
  // CONSUMIR LA API DE DETALLES DE INTERESADOS  
  Future<UserDetalle>getDetalleUser(int userDet)async{
    String? accessToken = await getAccessToken();
     if (accessToken == null) {
      // Manejar la situación donde no se encontró ningún token de acceso
    }
    
    final resp= await http.get(Uri.parse('$_url/interested_contacts/$userDet'), headers: {
      'Authorization': 'Bearer $accessToken',
    }
    
    );
   
    final Map<String, dynamic> jsonResponse = jsonDecode(resp.body);
    
    UserDetalle userDetalle = UserDetalle.fromJson(jsonResponse);
  
    return userDetalle;
  }
  // CONSUMIR LA API DE LISTA DE RECORDATORIOS DE INTERESADOS  
  Future<List<InterestRecordatorio>> getRecordatorioByUser()async{
    String? accessToken = await getAccessToken();
     if (accessToken == null) {
      // Manejar la situación donde no se encontró ningún token de acceso
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;
    final resp= await http.get(Uri.parse('$_url/reminders?user_id=$userId'), headers: {
      'Authorization': 'Bearer $accessToken',
    }
    );
    return (jsonDecode(resp.body)as List).map((interested_contacts) => InterestRecordatorio.fromJson(interested_contacts)).toList();
  }
  // CONSUMIR LA API DASHBOARD
  Future<dashboardUser>getDashboarddUser()async{
    String? accessToken = await getAccessToken();
     if (accessToken == null) {
      // Manejar la situación donde no se encontró ningún token de acceso
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;
    final resp= await http.get(Uri.parse('$_url/status_frequency/$userId'), headers: {
      'Authorization': 'Bearer $accessToken',
    }
    
    );
   
    final Map<String, dynamic> jsonResponse = jsonDecode(resp.body);
    print(jsonResponse);
    
    dashboardUser userDashboard = dashboardUser.fromJson(jsonResponse);
  
    return userDashboard;
  }
  // CONSUMIR LA API DE TIPIFICACIONES 
 Future<List<Tipificaciones>> getTipificaciones()async{
    String? accessToken = await getAccessToken();
     if (accessToken == null) {
      // Manejar la situación donde no se encontró ningún token de acceso
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId')!;
    final resp= await http.get(Uri.parse('$_url/comments_the_ic?intere_contac_id=$userId'), headers: {
      'Authorization': 'Bearer $accessToken',
    }
    );
    return (jsonDecode(resp.body)as List).map((tipification) => Tipificaciones.fromJson(tipification)).toList();
  }
  //-----------------------POST REGISTER TIPIFICACIÓN-----------------------------------------
  Future<Map<String, dynamic>?> RegisterTipificacion(String comentariotipi, String fechaDate, int userDet) async {
    // Obtener el token de acceso
    String? accessToken = await getAccessToken();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    // Verificar si se obtuvo el token de acceso
    if (accessToken == null) {
      // Manejar caso en el que no se obtuvo el token de acceso
      print('No se pudo obtener el token de acceso.');
      return null;
    }

    // Construir la URL con el parámetro id
    Uri uri = Uri.parse('$_url/reminders');

    try {
      // Construir el cuerpo de la solicitud
      Map<String, dynamic> body = {'comment': comentariotipi, 'user': userId, 'intere_contac': userDet,'reminder_date':fechaDate };

      // Realizar la solicitud HTTP con el token de acceso
      final response = await http.post(
        uri,
        headers: {
          'Authorization':
              'Bearer $accessToken', // Incluir el token de acceso en el encabezado
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Verificar el código de estado de la respuesta
      if (response.statusCode == 201) {
        // Decodificar el cuerpo de la respuesta JSON
        Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse;
      } else if (response.statusCode == 400) {
        // Manejar caso de error en la respuesta
        Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse;
      } else if (response.statusCode == 403) {
        // Manejar caso de error en la respuesta
        Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse;
      } else if (response.statusCode == 500) {
        // Manejar caso de error en la respuesta
        Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse;
      } else {
        // Manejar caso de error en la respuesta
        print('Error en la solicitud HTTP: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Manejar errores de conexión u otros errores
      print('Error en la solicitud HTTP: $e');
      return null;
    }
  }
  //-----------------------GET HISTORIAL DE TIFICACIONES-----------------------------------------
  Future<List<dynamic>> getHistorialTipificaciones() async {
  try {
    // Obtener el token de acceso
    String? accessToken = await getAccessToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    
    // Verificar si el token de acceso es nulo
    if (accessToken == null) {
      throw Exception('El token de acceso es nulo');
    }
    
    // Construir la URL con los parámetros de la consulta
    Uri uri = Uri.parse('$_url/comments_the_ic?intere_contac_id=$userId');

    // Realizar la solicitud HTTP con el token de acceso
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $accessToken', // Incluir el token de acceso en el encabezado
        'Content-Type': 'application/json',
      },
    );

    // Verificar el código de estado de la respuesta
    if (response.statusCode == 200) {
      // Decodificar el cuerpo de la respuesta JSON
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data;
    } else {
      // Manejar caso de error en la respuesta
      print('Error en la solicitud HTTP: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    // Manejar errores de conexión u otros errores
    print('Error en la solicitud HTTP: $e');
    return [];
  }
}
//-----------------------POST REGISTER Cursos-----------------------------------------
  Future<Map<String, dynamic>?> RegisterCursos(String cursoId, int userDet) async {
    // Obtener el token de acceso
    String? accessToken = await getAccessToken();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    // Verificar si se obtuvo el token de acceso
    if (accessToken == null) {
      // Manejar caso en el que no se obtuvo el token de acceso
      print('No se pudo obtener el token de acceso.');
      return null;
    }

    // Construir la URL con el parámetro id
    Uri uri = Uri.parse('$_url/inscriptions');

    try {
      // Construir el cuerpo de la solicitud
      Map<String, dynamic> body = {'course': cursoId,'intere_contac': userDet,'assignment_contact':userId};

      // Realizar la solicitud HTTP con el token de acceso
      final response = await http.post(
        uri,
        headers: {
          'Authorization':
              'Bearer $accessToken', // Incluir el token de acceso en el encabezado
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Verificar el código de estado de la respuesta
      if (response.statusCode == 201) {
        // Decodificar el cuerpo de la respuesta JSON
        Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse;
      } else if (response.statusCode == 400) {
        // Manejar caso de error en la respuesta
        Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse;
      } else if (response.statusCode == 403) {
        // Manejar caso de error en la respuesta
        Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse;
      } else if (response.statusCode == 500) {
        // Manejar caso de error en la respuesta
        Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse;
      } else {
        // Manejar caso de error en la respuesta
        print('Error en la solicitud HTTP: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Manejar errores de conexión u otros errores
      print('Error en la solicitud HTTP: $e');
      return null;
    }
  }
}


