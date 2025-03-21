import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    //aqui se crea provider que escucha los cambios de taskprovider. aqui envuelve todo para que cualquier hijo pueda escuchar 
    ChangeNotifierProvider(
      //instancia de tp que es donde se definen las tareas 
      create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: ThemeData(primarySwatch: Colors.indigo),
      ),
    ),
  );
}
