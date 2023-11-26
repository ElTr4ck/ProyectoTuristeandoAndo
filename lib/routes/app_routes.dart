import 'package:flutter/material.dart';
import 'package:turisteando_ando/screens/frmSetLocation2.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmwelcome_screen/frmwelcome_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmlogin_screen/frmlogin_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmcontrase_a_screen/frmcontrase_a_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmcorreo_screen/frmcorreo_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmcambiocont_screen/frmcambiocont_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmregistro_screen/frmregistro_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frminvitado_screen/frminvitado_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String frmwelcomeScreen = '/frmwelcome_screen';

  static const String frmloginScreen = '/frmlogin_screen';

  static const String frmcontraseAScreen = '/frmcontrase_a_screen';

  static const String frmcorreoScreen = '/frmcorreo_screen';

  static const String frmcambiocontScreen = '/frmcambiocont_screen';

  static const String frmregistroScreen = '/frmregistro_screen';

  static const String frminvitadoScreen = '/frminvitado_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String frmSetLocation = '/frmSetLocation2.dart';

  static Map<String, WidgetBuilder> routes = {
    frmwelcomeScreen: (context) => FrmwelcomeScreen(),
    frmloginScreen: (context) => FrmloginScreen(),
    frmcontraseAScreen: (context) => FrmcontraseAScreen(),
    frmcorreoScreen: (context) => FrmcorreoScreen(),
    frmcambiocontScreen: (context) => FrmcambiocontScreen(),
    frmregistroScreen: (context) => FrmregistroScreen(),
    frminvitadoScreen: (context) => FrminvitadoScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    frmSetLocation: (context) => FrmSetLocation(),
  };
}
