import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/pantallas/rutas.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminfolugar_screen/frminfolugar_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminicio_page/frminicio_page.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmmarcadores_screen/frmmarcadores_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmnewrese_a_screen/frmnewrese_a_screen.dart';
import 'package:turisteando_ando/screens/rutaDestacada/frmRutaDestacada.dart';
import 'package:turisteando_ando/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class FrminicioContainerScreen extends StatelessWidget {
  FrminicioContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.frminicioPage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushReplacementNamed(
          navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Iconlycurvedhome:
        return AppRoutes.frminicioPage;
      case BottomBarEnum.Iconlylightticket:
        return AppRoutes.rutas; //TODO: Aqui va lo del mapa
      case BottomBarEnum.Iconlylightoutlineheart:
        return AppRoutes.frmmarcadoresScreen;
      case BottomBarEnum.Iconlylightprofile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.frminicioPage:
        return FrminicioPage();
      case AppRoutes.frmmarcadoresScreen:
        return FrmmarcadoresScreen();
      case AppRoutes.frminfolugarScreen:
        return FrminfolugarScreen(id: '',);
      case AppRoutes.frmnewreseAScreen:
        return FrmnewreseAScreen();
      case AppRoutes.rutas:
        return PolylineScreen();
      case AppRoutes.frmRutaDestacada:
        return FrmRutaDestacada();
      default:
        return DefaultWidget();
    }
  }
}
