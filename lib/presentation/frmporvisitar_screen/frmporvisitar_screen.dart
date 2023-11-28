import '../frmporvisitar_screen/widgets/frmporvisitar_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:ramirez_ayala_s_application16/core/app_export.dart';
import 'package:ramirez_ayala_s_application16/widgets/custom_drop_down.dart';

class FrmporvisitarScreen extends StatelessWidget {
  FrmporvisitarScreen({Key? key})
      : super(
          key: key,
        );

  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 7.h),
          child: Column(
            children: [
              SizedBox(height: 22.v),
              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropDown(
                        width: 93.h,
                        icon: Container(
                          margin: EdgeInsets.only(left: 6.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgArrowdown,
                            height: 16.adaptSize,
                            width: 16.adaptSize,
                          ),
                        ),
                        hintText: "UserNameXx",
                        alignment: Alignment.centerRight,
                        items: dropdownItemList,
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 11.v),
                      _buildFortyFive(context),
                      SizedBox(height: 12.v),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Que comience el viaje",
                          style: CustomTextStyles.titleMediumMontserrat,
                        ),
                      ),
                      SizedBox(height: 11.v),
                      _buildFrmPorVisitar(context),
                    ],
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
  Widget _buildFortyFive(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 3.h,
        right: 23.h,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgArrowDown2,
            height: 10.v,
            width: 5.h,
            margin: EdgeInsets.only(
              top: 15.v,
              bottom: 13.v,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 14.h),
            decoration: AppDecoration.outlineBlack,
            child: Text(
              "Lugares por visitar",
              style: theme.textTheme.headlineLarge,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrmPorVisitar(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 235.v,
          crossAxisCount: 2,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 20.h,
        ),
        physics: BouncingScrollPhysics(),
        itemCount: 16,
        itemBuilder: (context, index) {
          return FrmporvisitarItemWidget();
        },
      ),
    );
  }
}
