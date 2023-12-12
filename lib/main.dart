import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';  // Importa flutter_localizations
import 'package:firebase_core/firebase_core.dart';
import 'package:turisteando_ando/repositories/auth/wrapper.dart';
import 'package:turisteando_ando/repositories/geolocation/geolocation_repository.dart';
import 'package:turisteando_ando/repositories/places/PlacesRepository.dart';
import 'package:turisteando_ando/routes/app_routes.dart';
import 'package:turisteando_ando/theme/theme_helper.dart';

import 'blocs/autocomplete/auto_complete_bloc.dart';
import 'blocs/geolocation/geolocation_bloc.dart';
import 'blocs/place/place_bloc.dart';
import 'firebase_options.dart';

//... tus otras importaciones aquí ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            localizationsDelegates: const [          // Añade estos delegados
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [               // Añade tus localizaciones aquí
              Locale('es', ''),           // Español
              // Puedes añadir más localizaciones aquí
            ],
            theme: theme,
            debugShowCheckedModeBanner: false,
            title: 'Turisteando Ando',

            //home: const MyHomePage(title: 'Flutter Demo Home Page'),
            //initialRoute: AppRoutes.frmwelcomeScreen,
            home: Wrapper(),
            routes: AppRoutes.routes,
          ),
        ),
    );
  }
}