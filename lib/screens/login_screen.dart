import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showError("Por favor, completa todos los campos.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://gc4529031ed9eb7-p3zpjccedme5d537.adb.sa-saopaulo-1.oraclecloudapps.com/ords/dev/apexfly/autenticacion'), // Cambia por tu endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          String token = data['token']; // Almacena el token recibido
          Navigator.pushReplacementNamed(context, '/home', arguments: token);
        } else {
          _showError(data['message']);
        }
      } else {
        _showError("Error de autenticación. Intenta nuevamente.");
      }
    } catch (e) {
      _showError("Ocurrió un error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Error",
          style: TextStyle(
            color: Color(0xFFFF0000), // Rojo
            fontSize: 20, // Tamaño opcional
            fontWeight: FontWeight.bold, // Negrita opcional
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Iniciar Sesión")),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          Color(0xFFFDEB71),
          Color(0xFFF8A170),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  labelText: "Usuario", labelStyle: GoogleFonts.bebasNeue()),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: "Contraseña", labelStyle: GoogleFonts.bebasNeue()),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 12.0),
                      backgroundColor: const Color(0xFF4A90E2), // Color base
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Bordes redondeados
                      ),
                      elevation: 5, // Sombra
                    ),
                    child: const Text(
                      "Iniciar Sesión",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
