import 'package:flutter/material.dart';
import 'package:conexionfirebase/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conexion a Firebase (Agregar Usuarios)'),
      ),
      body: FutureBuilder<List>(
        future: getUsuarios(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(data[index]['nombre']),
                    subtitle: Text(data[index]['email']),
                    leading: CircleAvatar(
                      child: Text(data[index]['nombre'].substring(0, 1)),
                    ),
                    onTap: () async {
                      await Navigator.pushNamed(context, '/edit', arguments: {
                        'uid': data[index]['uid'],
                        'nombre': data[index]['nombre'],
                        'email': data[index]['email'],
                        'nocuenta': data[index]['nocuenta'],
                      });
                      setState(() {});
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
