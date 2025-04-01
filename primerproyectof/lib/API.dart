import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for using json.decode()

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      title: 'Consumo API Rest',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista que contiene información sobre los posts
  List _loadedPosts = [];

  // Función que obtiene datos de la API
  Future<void> _fetchData() async {
    const apiUrl = 'https://jsonplaceholder.typicode.com/posts';

    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);

    setState(() {
      _loadedPosts = data;
    });
  }

  // Función que realiza un POST en la API
  Future<void> _post() async {
    const apiUrl = 'https://jsonplaceholder.typicode.com/posts';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'title': 'Post Title',
        'body': 'Lorem ipsum',
        'userId': '10',
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = jsonDecode(response.body);
    print(data);
  }

  // Función que realiza un PUT en la API
  Future<void> _put() async {
    const apiUrl = 'https://jsonplaceholder.typicode.com/posts/1';

    final response = await http.put(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'title': 'Updated Title',
        'body': 'Updated body',
        'userId': '10',
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = jsonDecode(response.body);
    print(data);
  }

  // Función que realiza un DELETE en la API
  Future<void> _delete() async {
    const apiUrl = 'https://jsonplaceholder.typicode.com/posts/1';

    final response = await http.delete(Uri.parse(apiUrl));
    final data = jsonDecode(response.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo API'),
      ),
      body: SafeArea(
        child: _loadedPosts.isEmpty
          ? Center(
              child: ElevatedButton(
                onPressed: _fetchData,
                child: const Text('Load Posts'),
              ),
            )
          : ListView.builder(
              itemCount: _loadedPosts.length,
              itemBuilder: (BuildContext ctx, index) {
                return ListTile(
                  title: Text(_loadedPosts[index]["title"]),
                  subtitle: Text('Post ID: ${_loadedPosts[index]["id"]}'),
                );
              },
            ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _post,
            child: const Icon(Icons.add),
            tooltip: 'Add Post',
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _put,
            child: const Icon(Icons.update),
            tooltip: 'Update Post',
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _delete,
            child: const Icon(Icons.delete),
            tooltip: 'Delete Post',
          ),
        ],
      ),
    );
  }
}
