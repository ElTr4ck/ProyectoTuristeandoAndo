import 'package:flutter/material.dart';
import 'package:turisteando_ando/pantallas/rutas.dart';
import 'package:turisteando_ando/screens/FAQs/frmfaqs_screen.dart';
import 'package:turisteando_ando/screens/frm_ruta_propia.dart';
import 'package:turisteando_ando/screens/perfilUsuario/frmeditaperfil_screen/frmeditaperfil_screen.dart';
import 'package:turisteando_ando/screens/perfilUsuario/frmperfil_screen/frmperfil_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminicio_container_screen/frminicio_container_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmporvisitar_screen/frmporvisitar_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmmarcadores_screen/frmmarcadores_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmmarcmapa_screen/frmmarcmapa_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminfolugar_screen/frminfolugar_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmrese_a_tab_container_screen/frmrese_a_tab_container_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmrese_a_tab_container_screen/frmrese_a_tab_container_screen2.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmnewrese_a_screen/frmnewrese_a_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmreportarrese_a_screen/frmreportarrese_a_screen.dart';
import 'package:turisteando_ando/screens/frmSetLocation.dart';
import 'package:turisteando_ando/screens/frmCuestionario.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmwelcome_screen/frmwelcome_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmlogin_screen/frmlogin_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmcontrase_a_screen/frmcontrase_a_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmcorreo_screen/frmcorreo_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmcambiocont_screen/frmcambiocont_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmregistro_screen/frmregistro_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frminvitado_screen/frminvitado_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/app_navigation_screen/app_navigation_screen.dart';
import 'package:turisteando_ando/screens/resenas/frmtusrese_as_screen.dart';
import 'package:turisteando_ando/screens/rutaDestacada/frmRutaDestacada.dart';
import 'package:turisteando_ando/widgets/foto.dart';
import '../screens/pantallas/presentation/frmrese_a_tab_container_screen/frmrese_a_tab_container_screen2.dart';

class AppRoutes {
  static const String frmwelcomeScreen = '/frmwelcome_screen';

  static const String frmloginScreen = '/frmlogin_screen';

  static const String frmcontraseAScreen = '/frmcontrase_a_screen';

  static const String frmcorreoScreen = '/frmcorreo_screen';

  static const String frmcambiocontScreen = '/frmcambiocont_screen';

  static const String frmregistroScreen = '/frmregistro_screen';

  static const String frminvitadoScreen = '/frminvitado_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String frmSetLocation = '/frmSetLocation.dart';

  static const String frmCuestionario = '/frmCuestionario.dart';

  static const String frminicioPage = '/frminicio_page';

  static const String frminicioContainerScreen = '/frminicio_container_screen';

  static const String frmporvisitarScreen = '/frmporvisitar_screen';

  static const String frmmarcadoresScreen = '/frmmarcadores_screen';

  static const String frmmarcmapaScreen = '/frmmarcmapa_screen';

  static const String frminfolugarScreen = '/frminfolugar_screen';

  static const String frmreseAPage = '/frmrese_a_page';

  static const String frmreseATabContainerScreen2 =
      '/frmrese_a_tab_container_screen2';

  static const String frmreseATabContainerScreen =
      '/frmrese_a_tab_container_screen';

  static const String frmnewreseAScreen = '/frmnewrese_a_screen';

  static const String frmreportarreseAScreen = '/frmreportarrese_a_screen';

  static const String rutas = '/rutas.dart';

  static const String rutasUno = '/rutasUno.dart';

  static const String frmRutaDestacada = '/frmRutaDestacada';

  static const String frmperfilScreen = '/frmperfil_screen';

  static const String frmEditaPerfil = '/frmeditaperfil_screen';

  static const String frm_ruta_propia = '/frm_ruta_propia';

  static const String frmfaqsScreen = '/frmfaqs_screen';

  static const String frmtusreseAsScreen = '/frmtusrese_as_screen';
  static const String foto = '/foto';
  static Map<String, WidgetBuilder> routes = {
    frminicioContainerScreen: (context) => FrminicioContainerScreen(),
    frmporvisitarScreen: (context) => FrmporvisitarScreen(),
    frmmarcadoresScreen: (context) => FrmmarcadoresScreen(),
    frmmarcmapaScreen: (context) => FrmmarcmapaScreen(),
    frminfolugarScreen: (context) => FrminfolugarScreen(
          id: '',
        ),
    frmreseATabContainerScreen2: (context) => FrmreseATabContainerScreen2(
          id: '',
          index: 0,
        ),
    frmreseATabContainerScreen: (context) =>
        FrmreseATabContainerScreen(jsonData: null),
    frmnewreseAScreen: (context) => FrmnewreseAScreen(
          id: '',
        ),
    frmreportarreseAScreen: (context) => FrmreportarreseAScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    frmwelcomeScreen: (context) => FrmwelcomeScreen(),
    frmloginScreen: (context) => FrmloginScreen(),
    frmcontraseAScreen: (context) => FrmcontraseAScreen(),
    frmcorreoScreen: (context) => FrmcorreoScreen(),
    frmcambiocontScreen: (context) => FrmcambiocontScreen(),
    frmregistroScreen: (context) => FrmregistroScreen(),
    frminvitadoScreen: (context) => FrminvitadoScreen(),
    frmSetLocation: (context) => FrmSetLocation(),

    frmCuestionario: (context) => FrmCuestionario(),

    rutas: (context) => PolylineScreen(),

    frmRutaDestacada: (context) => FrmRutaDestacada(),

    frmperfilScreen: (context) => FrmperfilScreen(),

    frmEditaPerfil: (context) => FrmeditaperfilScreen(),

    frm_ruta_propia: (context) => FrmRutaPropia(null),

    frmfaqsScreen: (context) => FrmfaqsScreen(),

    frmtusreseAsScreen: (context) => FrmtusreseAsScreen(),
    foto: (context) => Foto(url: ''),

    //rutasUno: (context) => RutaUno(predictionDescription: predictionDescription) //TODO: Aqui que onda jaja
  };
}
