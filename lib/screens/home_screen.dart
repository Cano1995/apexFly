import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene el token pasado como argumento
    final String token = ModalRoute.of(context)!.settings.arguments as String;

    void _logout() {
      Navigator.pushReplacementNamed(context, '/login');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imagenes/Oracle-APEX.jpg'),
                fit: BoxFit.cover, // Asegura que la imagen ocupe toda la pantalla
              ),
            ),
          ),
          // Contenido semi-transparente encima de la imagen
          Container(
            color: Colors.black.withOpacity(0.5), // Fondo semi-transparente
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "¡Bienvenido!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Tu token:",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      token,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
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
