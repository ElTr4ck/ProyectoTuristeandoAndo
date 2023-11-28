import 'package:flutter/material.dart';
import 'package:ramirez_ayala_s_application16/presentation/frminicio_container_screen/frminicio_container_screen.dart';
import 'package:ramirez_ayala_s_application16/presentation/frmporvisitar_screen/frmporvisitar_screen.dart';
import 'package:ramirez_ayala_s_application16/presentation/frmmarcadores_screen/frmmarcadores_screen.dart';
import 'package:ramirez_ayala_s_application16/presentation/frmmarcmapa_screen/frmmarcmapa_screen.dart';
import 'package:ramirez_ayala_s_application16/presentation/frminfolugar_screen/frminfolugar_screen.dart';
import 'package:ramirez_ayala_s_application16/presentation/frmrese_a_tab_container_screen/frmrese_a_tab_container_screen.dart';
import 'package:ramirez_ayala_s_application16/presentation/frmnewrese_a_screen/frmnewrese_a_screen.dart';
import 'package:ramirez_ayala_s_application16/presentation/frmreportarrese_a_screen/frmreportarrese_a_screen.dart';
import 'package:ramirez_ayala_s_application16/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String frminicioPage = '/frminicio_page';

  static const String frminicioContainerScreen = '/frminicio_container_screen';

  static const String frmporvisitarScreen = '/frmporvisitar_screen';

  static const String frmmarcadoresScreen = '/frmmarcadores_screen';

  static const String frmmarcmapaScreen = '/frmmarcmapa_screen';

  static const String frminfolugarScreen = '/frminfolugar_screen';

  static const String frmreseAPage = '/frmrese_a_page';

  static const String frmreseATabContainerScreen =
      '/frmrese_a_tab_container_screen';

  static const String frmnewreseAScreen = '/frmnewrese_a_screen';

  static const String frmreportarreseAScreen = '/frmreportarrese_a_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    frminicioContainerScreen: (context) => FrminicioContainerScreen(),
    frmporvisitarScreen: (context) => FrmporvisitarScreen(),
    frmmarcadoresScreen: (context) => FrmmarcadoresScreen(),
    frmmarcmapaScreen: (context) => FrmmarcmapaScreen(),
    frminfolugarScreen: (context) => FrminfolugarScreen(),
    frmreseATabContainerScreen: (context) => FrmreseATabContainerScreen(),
    frmnewreseAScreen: (context) => FrmnewreseAScreen(),
    frmreportarreseAScreen: (context) => FrmreportarreseAScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
