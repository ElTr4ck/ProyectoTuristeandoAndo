import '../frmrese_a_page/widgets/frmrese_a_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';

class FrmreseAPage extends StatefulWidget {
  const FrmreseAPage({Key? key}) : super(key: key);

  @override
  FrmreseAPageState createState() => FrmreseAPageState();
}

class FrmreseAPageState extends State<FrmreseAPage>
    with AutomaticKeepAliveClientMixin<FrmreseAPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillOnPrimary,
                child: Column(children: [
                  SizedBox(height: 5.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.h),
                      child: Column(children: [
                        Padding(
                            padding: EdgeInsets.only(left: 12.h),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      decoration: AppDecoration.outlineBlack,
                                      child: Text("Reseñas",
                                          style:
                                              theme.textTheme.headlineSmall)),
                                  Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 6.v),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder9),
                                      child: Container(
                                          height: 17.v,
                                          width: 138.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder9),
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                        height: 17.v,
                                                        width: 138.h,
                                                        decoration: BoxDecoration(
                                                            color: theme
                                                                .colorScheme
                                                                .primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.h)))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          onTapTxtAceptar(
                                                              context);
                                                        },
                                                        child: Text(
                                                            "Escribir una reseña",
                                                            style: CustomTextStyles
                                                                .labelLargeNunitoGray5002)))
                                              ])))
                                ])),
                        SizedBox(height: 5.v),
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 5.v);
                            },
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return FrmreseAItemWidget(onTapView: () {
                                onTapView(context);
                              });
                            })
                      ]))
                ]))));
  }

  /// Navigates to the frmreportarreseAScreen when the action is triggered.
  onTapView(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmreportarreseAScreen);
  }

  /// Navigates to the frmnewreseAScreen when the action is triggered.
  onTapTxtAceptar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmnewreseAScreen);
  }
}
