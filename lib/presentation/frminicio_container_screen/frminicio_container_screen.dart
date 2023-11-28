import 'package:flutter/material.dart';
import 'package:ramirez_ayala_s_application16/core/app_export.dart';
import 'package:ramirez_ayala_s_application16/presentation/frminicio_page/frminicio_page.dart';
import 'package:ramirez_ayala_s_application16/widgets/custom_bottom_bar.dart';

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
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Iconlycurvedhome:
        return "/";
      case BottomBarEnum.Iconlylightticket:
        return AppRoutes.frminicioPage;
      case BottomBarEnum.Iconlylightoutlineheart:
        return "/";
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
      default:
        return DefaultWidget();
    }
  }
}
