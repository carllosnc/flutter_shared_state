import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared State'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Counter'),
              onTap: () {
                Navigator.pushNamed(context, '/counter');
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Todo List'),
              onTap: () {
                Navigator.pushNamed(context, '/todo_list');
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
