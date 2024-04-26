import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piadas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JokePage(),
    );
  }
}

class JokePage extends StatefulWidget {
  const JokePage({Key? key}) : super(key: key);

  @override
  _JokePageState createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  String _joke = '';

  Future<void> _fetchJoke() async {
    final response = await http.get(Uri.parse('https://api.piadas.dev/v1/piadas/random'));
    if (response.statusCode == 200) {
      setState(() {
        _joke = json.decode(response.body)['piada'];
      });
    } else {
      throw Exception('Failed to load joke');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piadas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _joke.isNotEmpty ? _joke : 'Pressione o botão para obter uma piada!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchJoke,
              child: const Text('Obter Piada'),
            ),
          ],
        ),
      ),
    );
  }
}
