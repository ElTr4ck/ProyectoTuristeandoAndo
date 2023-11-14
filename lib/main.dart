import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/screens/frmCuestionario.dart';
import 'package:turisteando_ando/screens/frmSetLocation.dart'; // Importacion del frame de Set Location
import 'package:turisteando_ando/screens/frmMapa.dart'; // Importacion del frame de Set Location

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turisteando Ando',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), //only signin signout
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const //LoginScreen();
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return const //LoginScreen();
        },
      ),

      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      /*initialRoute: 'frmSetLocation',
      routes: {
        'frmSetLocation': (_) => frmSetLocation(),
        'frmMapa': (_) => frmMapa(),
        'frmCuestionario': (_) => frmCuestionario()
      },*/
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
