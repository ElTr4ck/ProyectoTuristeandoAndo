import '../frmmarcadores_screen/widgets/seventy_item_widget.dart';
import '../frmmarcadores_screen/widgets/seventysix_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminicio_page/frminicio_page.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_subtitle_three.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_trailing_dropdown.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_bottom_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_side_bar.dart';

// ignore_for_file: must_be_immutable
class FrmmarcadoresScreen extends StatelessWidget {
  FrmmarcadoresScreen({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: null,
      ),
      body: SizedBox(
          width: double.maxFinite,
          child: ListView(
            children: [
              Column(children: [
                Container(
                    decoration: AppDecoration.outlineBlack,
                    child: Text("Estos son tus marcadores",
                        style: theme.textTheme.headlineMedium)),
                SizedBox(height: 11.v),
                CustomElevatedButton(
                    height: 24.v,
                    width: 125.h,
                    text: "Ver en mapa",
                    buttonStyle: CustomButtonStyles.outlineBlack,
                    buttonTextStyle:
                        CustomTextStyles.labelLargeMontserratTeal400,
                    onPressed: () {
                      onTapVerEnMapa(context);
                    }),
                SizedBox(height: 5.v),
                _buildComponentNuevDest(context),
                SizedBox(height: 15.v),
                _buildComponentNuevDest1(context),
                SizedBox(height: 5.v)
              ]),
            ],
          )),
      //bottomNavigationBar: _buildBottomBar(context)
    ));
  }

  /// Section Widget
  // PreferredSizeWidget _buildAppBar(BuildContext context) {
  //   return CustomAppBar(
  //       title: AppbarSubtitleThree(
  //           text: "Favoritos", margin: EdgeInsets.only(left: 14.h)),
  //       actions: [
  //         AppbarTrailingDropdown(
  //             margin: EdgeInsets.fromLTRB(8.h, 14.v, 8.h, 24.v),
  //             hintText: "UserNameXx",
  //             items: dropdownItemList,
  //             onTap: (value) {})
  //       ]);
  // }

  /// Section Widget
  Widget _buildComponentNuevDest(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Tus destinos favoritos",
              style: CustomTextStyles.titleMediumMontserratOnPrimaryContainer),
          SizedBox(height: 21.v),
          SizedBox(
              height: 241.v,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 8.h);
                  },
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return SeventyItemWidget();
                  }))
        ]));
  }

  /// Section Widget
  Widget _buildComponentNuevDest1(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Descubre nuevos destinos",
              style: CustomTextStyles.titleMediumMontserratOnPrimaryContainer),
          SizedBox(height: 22.v),
          SizedBox(
              height: 240.v,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 9.h);
                  },
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return SeventysixItemWidget();
                  }))
        ]));
  }

  /// Navigates to the frmmarcmapaScreen when the action is triggered.
  onTapVerEnMapa(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmmarcmapaScreen);
  }
}
