import 'package:bloc_cubit_practice/logic/bloc/task_bloc.dart';
import 'package:bloc_cubit_practice/logic/cubit/task_cubit.dart';
import 'package:bloc_cubit_practice/presentation/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskCubit()),
        BlocProvider(create: (context) => TaskBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(color: Colors.black, toolbarHeight: 50),
      ),
      home: Root(),
    );
  }
}
