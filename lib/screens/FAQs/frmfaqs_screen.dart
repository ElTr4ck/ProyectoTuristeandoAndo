import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_subtitle.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title_image.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_drop_down.dart';

// ignore: must_be_immutable
class FrmfaqsScreen extends StatelessWidget {
  FrmfaqsScreen({Key? key})
      : super(
          key: key,
        );
//QUESTIONS AND ANSWERS CREATED BY DOCUMENTATION TEAM
  //Check the "options", if is better only with the answer
  List<String> dropdownItemList = [
    "Question1", //QUESTION1
    "Lorem ipsum dolor sit amet consectetur adipiscing elit erat est, lacus nullam cum donec diam sem mollis urna. Mus nascetur nam tortor in molestie enim ad laoreet, hac ante himenaeos quis blandit dapibus facilisis erat, cursus magna risus sem morbi vivamus tincidunt", //ANSWER
  ];

  List<String> dropdownItemList1 = [
    "Question2",//QUESTION2
    "Item Two",//ANSWER
  ];

  List<String> dropdownItemList2 = [
    "Question3",//QUESTION3
    "Item Two",//ANSWER
  ];

  List<String> dropdownItemList3 = [
    "Question4",//QUESTION4
    "Item Two",//ANSWER
  ];

  List<String> dropdownItemList4 = [
    "Question5",//QUESTION5
    "Item Two",//ANSWER
  ];

  List<String> dropdownItemList5 = [
    "Question6",//QUESTION6
    "Item Two",//ANSWER
  ];

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 13.v),
              Container(
                decoration: AppDecoration.outlineBlack,
                child: Text(
                  "Estamos aquí para ayudarte",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 19.v),
              Container(
                width: 313.h,
                margin: EdgeInsets.symmetric(horizontal: 23.h),
                child: Text(
                  "La planificación de un viaje puede generar preguntas. No te preocupes, estamos aquí para ayudarte en cada etapa. Consulta nuestras preguntas frecuentes para respuestas rápidas y útiles.",
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyMediumMontserrat,
                ),
              ),
              SizedBox(height: 38.v),
              SizedBox(
                height: 526.v,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage22,
                      height: 526.v,
                      width: 360.h,
                      radius: BorderRadius.vertical(
                        top: Radius.circular(33.h),
                      ),
                      alignment: Alignment.center,
                    ),
                    _buildQuestions(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: SizedBox(
        height: 30.v,
        width: 328.h,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            AppbarSubtitle(
              text: "Turisteando Ando",
            ),
            AppbarTitleImage(
              imagePath: ImageConstant.imgRegresar,
              margin: EdgeInsets.fromLTRB(5.h, 5.v, 318.h, 15.v),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildQuestions(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDropDown(
              icon: Container(
                margin: EdgeInsets.fromLTRB(30.h, 17.v, 11.h, 17.v),
                child: CustomImageView(
                  imagePath: ImageConstant.imgArrowdown,
                  height: 11.v,
                  width: 20.h,
                ),
              ),
              hintText: "Pregunta1 ",//add the question
              items: dropdownItemList,
              onChanged: (value) {},
            ),
            SizedBox(height: 24.v),
            CustomDropDown(
              icon: Container(
                margin: EdgeInsets.fromLTRB(30.h, 17.v, 11.h, 17.v),
                child: CustomImageView(
                  imagePath: ImageConstant.imgShowinfo,
                  height: 10.v,
                  width: 20.h,
                ),
              ),
              hintText: "Pregunta2",//add the question
              items: dropdownItemList1,
              onChanged: (value) {},
            ),
            SizedBox(height: 24.v),
            CustomDropDown(
              icon: Container(
                margin: EdgeInsets.fromLTRB(30.h, 17.v, 11.h, 17.v),
                child: CustomImageView(
                  imagePath: ImageConstant.imgShowinfo,
                  height: 10.v,
                  width: 20.h,
                ),
              ),
              hintText: "Pregunta3",//add the question
              items: dropdownItemList2,
              onChanged: (value) {},
            ),
            SizedBox(height: 24.v),
            CustomDropDown(
              icon: Container(
                margin: EdgeInsets.fromLTRB(30.h, 17.v, 11.h, 17.v),
                child: CustomImageView(
                  imagePath: ImageConstant.imgShowinfo,
                  height: 10.v,
                  width: 20.h,
                ),
              ),
              hintText: "Pregunta4",//add the question
              items: dropdownItemList3,
              onChanged: (value) {},
            ),
            SizedBox(height: 24.v),
            CustomDropDown(
              icon: Container(
                margin: EdgeInsets.fromLTRB(30.h, 17.v, 11.h, 17.v),
                child: CustomImageView(
                  imagePath: ImageConstant.imgShowinfo,
                  height: 10.v,
                  width: 20.h,
                ),
              ),
              hintText: "Pregunta5",//add the question
              items: dropdownItemList4,
              onChanged: (value) {},
            ),
            SizedBox(height: 24.v),
            CustomDropDown(
              icon: Container(
                margin: EdgeInsets.fromLTRB(30.h, 17.v, 11.h, 17.v),
                child: CustomImageView(
                  imagePath: ImageConstant.imgShowinfo,
                  height: 10.v,
                  width: 20.h,
                ),
              ),
              hintText: "Pregunta6",//add the question
              items: dropdownItemList5,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
