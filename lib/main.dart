import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/blocs/autocomplete/auto_complete_bloc.dart';
import 'package:turisteando_ando/blocs/geolocation/geolocation_bloc.dart';
import 'package:turisteando_ando/blocs/place/place_bloc.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/auth/wrapper.dart';
import 'package:turisteando_ando/repositories/geolocation/geolocation_repository.dart';
import 'package:turisteando_ando/repositories/places/PlacesRepository.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthMethods()));
  ThemeHelper().changeTheme('primary');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PlacesRepository>(
          create: (_) => PlacesRepository(),
        ),
        RepositoryProvider<GeolocationRepository>(
          create: (_) => GeolocationRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AutoCompleteBloc(
                  placesRepository: context.read<PlacesRepository>())
                ..add(LoadAutoComplete())),
          BlocProvider(
              create: (context) => PlaceBloc(
                  placesRepository: context.read<PlacesRepository>())),
          BlocProvider(
              create: (context) => GeolocationBloc(
                  geolocationRepository: context.read<GeolocationRepository>())
                ..add(LoadGeolocation()))
        ],
        child: MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          title: 'Turisteando Ando',

          /* theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),*/
          //home: const MyHomePage(title: 'Flutter Demo Home Page'),
          //initialRoute: AppRoutes.frmwelcomeScreen,
          navigatorKey: Get.key,
          home: Wrapper(),
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}
