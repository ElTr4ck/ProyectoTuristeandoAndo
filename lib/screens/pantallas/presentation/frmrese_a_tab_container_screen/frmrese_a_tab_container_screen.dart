import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminicio_page/frminicio_page.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmrese_a_page/frmrese_a_page.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title_searchview.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_bottom_bar.dart';
import 'package:turisteando_ando/widgets/custom_rating_bar.dart';

class FrmreseATabContainerScreen extends StatefulWidget {
  const FrmreseATabContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  FrmreseATabContainerScreenState createState() =>
      FrmreseATabContainerScreenState();
}

class FrmreseATabContainerScreenState extends State<FrmreseATabContainerScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late TabController tabviewController;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          //width: double.maxFinite,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildTwelve(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 16.v),
                  _buildComponentPlaceStars(context),
                  SizedBox(height: 5.v),
                  _buildComponentCalif(context),
                  SizedBox(height: 17.v),
                  Container(
                    height: 35.v,
                    width: 127.h,
                    margin: EdgeInsets.only(left: 21.h),
                    decoration: BoxDecoration(
                      color: appTheme.blueA4000c,
                      borderRadius: BorderRadius.circular(
                        17.h,
                      ),
                      border: Border.all(
                        color: appTheme.gray400,
                        width: 1.h,
                      ),
                    ),
                    child: TabBar(
                      controller: tabviewController,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                          child: SizedBox(
                            height: 32.v,
                            width: 61.h,
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgBg,
                                  height: 32.v,
                                  width: 61.h,
                                  radius: BorderRadius.circular(
                                    16.h,
                                  ),
                                  alignment: Alignment.center,
                                  color: const Color.fromARGB(255, 246, 246, 246),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10.h,
                                      bottom: 6.v,
                                    ),
                                    child: Text(
                                      "Google",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "App",
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildTabBarView(context),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildTwelve(BuildContext context) {
    return SizedBox(
      //height: 217.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImagen20231010221458620,
            height: 217.v,
            width: 360.h,
            radius: BorderRadius.circular(
              33.h,
            ),
            alignment: Alignment.center,
          ),
          CustomAppBar(
            height: 70.v,
            leadingWidth: 30.h,
            leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowDown2,
              margin: EdgeInsets.only(
                left: 25.h,
                top: 15.v,
                bottom: 20.v,
              ),
            ),
            centerTitle: true,
            title: AppbarTitleSearchview(
              hintText: "¿Buscas hacer algo ... ",
              controller: searchController,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentPlaceStars(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(
          left: 46.h,
          right: 17.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.v),
              child: Text(
                "Museo Tamayo",
                style: CustomTextStyles.titleLargeNunito,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 4.v),
              padding: EdgeInsets.symmetric(
                horizontal: 4.h,
                vertical: 8.v,
              ),
              decoration: AppDecoration.fillErrorContainer1.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRatingBar(
                    initialRating: 5,
                    itemSize: 13,
                    color: appTheme.yellow700,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentCalif(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 29.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 65.h,
              margin: EdgeInsets.only(
                top: 8.v,
                bottom: 13.v,
              ),
              padding: EdgeInsets.symmetric(vertical: 7.v),
              decoration: AppDecoration.fillOnPrimary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "4.6",
                    style: CustomTextStyles.titleLargeInterBlack900,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgFrameYellow700,
                    height: 20.v,
                    width: 22.h,
                    margin: EdgeInsets.only(
                      left: 3.h,
                      top: 2.v,
                      bottom: 2.v,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 9.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "5",
                          style: theme.textTheme.labelLarge,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 13.h,
                              top: 3.v,
                              bottom: 2.v,
                            ),
                            child: Container(
                              height: 8.v,
                              width: 208.h,
                              decoration: BoxDecoration(
                                color: appTheme.gray200,
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                                child: LinearProgressIndicator(
                                  value: 0.46,
                                  backgroundColor: appTheme.gray200,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    appTheme.yellow700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "4",
                          style: theme.textTheme.labelLarge,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 13.h,
                              top: 3.v,
                              bottom: 2.v,
                            ),
                            child: Container(
                              height: 8.v,
                              width: 208.h,
                              decoration: BoxDecoration(
                                color: appTheme.gray200,
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                                child: LinearProgressIndicator(
                                  value: 0.25,
                                  backgroundColor: appTheme.gray200,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    appTheme.yellow700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "3",
                          style: theme.textTheme.labelLarge,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 13.h,
                              top: 3.v,
                              bottom: 2.v,
                            ),
                            child: Container(
                              height: 8.v,
                              width: 208.h,
                              decoration: BoxDecoration(
                                color: appTheme.gray200,
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                                child: LinearProgressIndicator(
                                  value: 0.42,
                                  backgroundColor: appTheme.gray200,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    appTheme.yellow700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "2",
                          style: theme.textTheme.labelLarge,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 13.h,
                              top: 3.v,
                              bottom: 2.v,
                            ),
                            child: Container(
                              height: 8.v,
                              width: 208.h,
                              decoration: BoxDecoration(
                                color: appTheme.gray200,
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                                child: LinearProgressIndicator(
                                  value: 0.6,
                                  backgroundColor: appTheme.gray200,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    appTheme.yellow700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "1",
                          style: theme.textTheme.labelLarge,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 16.h,
                              top: 3.v,
                              bottom: 2.v,
                            ),
                            child: Container(
                              height: 8.v,
                              width: 208.h,
                              decoration: BoxDecoration(
                                color: appTheme.gray200,
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  2.h,
                                ),
                                child: LinearProgressIndicator(
                                  value: 0.42,
                                  backgroundColor: appTheme.gray200,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    appTheme.yellow700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTabBarView(BuildContext context) {
    return SizedBox(
      height: 700.v,
      child: TabBarView(
        controller: tabviewController,
        children: [
          FrmreseAPage(),
          FrmreseAPage(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
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
