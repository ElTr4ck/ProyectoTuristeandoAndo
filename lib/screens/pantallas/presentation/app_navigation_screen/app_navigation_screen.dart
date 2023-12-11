import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "frmInicio - Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.frminicioContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "frmPorVisitar",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.frmporvisitarScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "frmMarcadores",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.frmmarcadoresScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "frmMarcMapa",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.frmmarcmapaScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "frmInfoLugar",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.frminfolugarScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "frmReseña - Tab Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.frmreseATabContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "frmNewReseña",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.frmnewreseAScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "frmReportarReseña",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.frmreportarreseAScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
