import '../frminicio_page/widgets/ninety_item_widget.dart';
import '../frminicio_page/widgets/recommended_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/custom_drop_down.dart';
import 'package:turisteando_ando/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class FrminicioPage extends StatelessWidget {
  FrminicioPage({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillOnPrimary,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30.v),
                    child: ListView(
                      children: [
                        Column(
                          children: [
                          SizedBox(height: 2.v),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: EdgeInsets.only(right: 5.h),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("Bienvenido",
                                            style: CustomTextStyles
                                                .bodyMediumMontserrat),
                                        Padding(
                                            padding: EdgeInsets.only(left: 41.h),
                                            child: CustomDropDown(
                                                width: 93.h,
                                                icon: Container(
                                                    margin:
                                                        EdgeInsets.only(left: 6.h),
                                                    child: CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgArrowdown,
                                                        height: 16.adaptSize,
                                                        width: 16.adaptSize)),
                                                hintText: "UserNameXx",
                                                items: dropdownItemList,
                                                onChanged: (value) {}))
                                      ]))),
                          SizedBox(height: 15.v),
                          _buildEightyThree(context),
                          SizedBox(height: 18.v),
                          Padding(
                              padding: EdgeInsets.only(left: 18.h, right: 16.h),
                              child: CustomSearchView(
                                  controller: searchController,
                                  hintText:
                                      "¿Buscas hacer algo en particular en ... ")),
                          SizedBox(height: 31.v),
                          _buildComponentNuevDest(context),
                          SizedBox(height: 40.v),
                          _buildComponentIntereses(context)
                        ]),
                      ],
                    )))));
  }

  /// Section Widget
  Widget _buildEightyThree(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomImageView(
              imagePath: ImageConstant.imgArrowDown2,
              height: 10.v,
              width: 5.h,
              margin: EdgeInsets.symmetric(vertical: 14.v)),
          Container(
              margin: EdgeInsets.only(left: 17.h),
              decoration: AppDecoration.outlineBlack,
              child:
                  Text("¿A dónde vamos?", style: theme.textTheme.headlineLarge))
        ]));
  }

  /// Section Widget
  Widget _buildComponentNuevDest(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Lo + popular",
              style: CustomTextStyles.titleMediumMontserratOnPrimaryContainer),
          SizedBox(height: 20.v),
          SizedBox(
              height: 240.v,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 8.h);
                  },
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return NinetyItemWidget();
                  }))
        ]));
  }

  /// Section Widget
  Widget _buildComponentIntereses(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 6.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(left: 9.h),
              child: Text("Tambien te podría interesar",
                  style: CustomTextStyles
                      .titleMediumMontserratOnPrimaryContainer)),
          SizedBox(height: 14.v),
          SizedBox(
              height: 138.v,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 13.h);
                  },
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return RecommendedItemWidget(onTapImgAcuarioInbursa: () {
                      onTapImgAcuarioInbursa(context);
                    });
                  }))
        ]));
  }

  /// Navigates to the frminfolugarScreen when the action is triggered.
  onTapImgAcuarioInbursa(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frminfolugarScreen);
  }
}
