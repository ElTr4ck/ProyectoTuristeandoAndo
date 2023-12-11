import '../frmmarcmapa_screen/widgets/cerca_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_subtitle.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';

class FrmmarcmapaScreen extends StatelessWidget {
  const FrmmarcmapaScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: mediaQueryData.size.height,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        ImageConstant.imgGroup2,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: _buildAppBar(context),
                ),
              ),
              _buildFourteen(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 81.v,
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Marcadores",
      ),
      styleType: Style.bgStyle,
    );
  }

  /// Section Widget
  Widget _buildFourteen(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 180.v,
        width: double.maxFinite,
        margin: EdgeInsets.only(bottom: 10.v),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 122.h,
                  vertical: 3.v,
                ),
                decoration: AppDecoration.outlineBlack900.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderTL20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgVector,
                      height: 16.v,
                      width: 13.h,
                      margin: EdgeInsets.only(bottom: 156.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 5.h,
                        bottom: 155.v,
                      ),
                      child: Text(
                        "Cerca de ti",
                        style: CustomTextStyles.titleSmallSemiBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 178.v,
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    left: 3.h,
                    top: 29.v,
                    bottom: 9.v,
                  ),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (
                    context,
                    index,
                  ) {
                    return SizedBox(
                      width: 4.h,
                    );
                  },
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CercaItemWidget();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
