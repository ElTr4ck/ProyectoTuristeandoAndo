import '../resenas/widgets/srcoll_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';

class FrmtusreseAsScreen extends StatelessWidget {
  const FrmtusreseAsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 21.h),
          child: Column(
            children: [
              SizedBox(height: 1.v),
              Container(
                width: 285.h,
                margin: EdgeInsets.only(
                  left: 17.h,
                  right: 15.h,
                ),
                child: Text(
                  "Explora todas las reseñas que has creado. \n\n ¡Gracias por contribuir con tus valiosas opiniones!",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: 20.v),
              _buildSrcoll(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 70.v,
      leadingWidth: 23.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgRegresar,
        //onTap: , ACTIONS
        margin: EdgeInsets.only(
          left: 18.h,
          top: 22.v,
          bottom: 23.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Tus reseñas",
      ),
    );
  }

  /// Section Widget
  Widget _buildSrcoll(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 1.h),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 20.v,
            );
          },
          itemCount: 7,//check the dinamic scroll
          //number controller
          itemBuilder: (context, index) {
            return SrcollItemWidget();
          },
        ),
      ),
    );
  }
}
