import 'package:flutter/material.dart';
import '/views/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  // Define the valid username and password
  final String validUsername = 'weather99';
  final String validPassword = 'weather99';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Weather App",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 50),
                Center(
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: [
                          _usernameTextField(),
                          const SizedBox(height: 20),
                          _passwordTextField(),
                          const SizedBox(height: 40),
                          _tombolLogin(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Username"),
      controller: _usernameCtrl,
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      obscureText: true,
      controller: _passwordCtrl,
    );
  }

  Widget _tombolLogin() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: const Text("Login"),
        onPressed: () {
          // Periksa nilai username dan password yang dimasukkan
          String username = _usernameCtrl.text;
          String password = _passwordCtrl.text;

          // Jika sesuai dengan yang diinginkan, arahkan ke halaman beranda
          if (username == validUsername && password == validPassword) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WeatherScreen()),
            );
          } else {
            // Jika tidak sesuai, tampilkan pesan kesalahan
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Login Gagal'),
                  content: const Text('Username atau Password Salah.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
