import 'package:bloc_cubit_practice/presentation/screens/bloc_todo.dart';
import 'package:bloc_cubit_practice/presentation/screens/cubit_todo.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlocTodo()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                minimumSize: Size(200, 80),
              ),
              child: Text(
                "BLOC",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CubitTodo()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                minimumSize: Size(200, 80),
              ),
              child: Text(
                "CUBIT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
