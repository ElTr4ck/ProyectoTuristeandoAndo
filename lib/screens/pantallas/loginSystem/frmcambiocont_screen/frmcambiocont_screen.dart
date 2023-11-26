import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turisteando Ando',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: 'cambioPass',
      routes: {'cambioPass': (_) => FrmcambiocontScreen()},
    );
  }
}

class FrmcambiocontScreen extends StatelessWidget {
  const FrmcambiocontScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 15.v),
          child: Column(
            children: [
              _buildComponentSeven(context),
              SizedBox(height: 31.v),
              _buildTextFieldOutline(context),
              SizedBox(height: 9.v),
              _buildTextFieldOutline1(context),
              SizedBox(height: 51.v),
              CustomElevatedButton(
                width: 235.h,
                text: "Aceptar",
                buttonStyle: CustomButtonStyles.fillPrimaryTL16,
              ),
              SizedBox(height: 14.v),
              CustomElevatedButton(
                width: 235.h,
                text: "Cancelar",
                buttonStyle: CustomButtonStyles.fillTeal,
              ),
              SizedBox(height: 6.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildComponentSeven(BuildContext context) {
    return SizedBox(
      height: 261.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 42.h),
              padding: EdgeInsets.symmetric(
                horizontal: 13.h,
                vertical: 8.v,
              ),
              decoration: AppDecoration.fillGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: SizedBox(
                width: 248.h,
                child: Text(
                  "Para asegurarnos de que tu cuenta esté protegida, tu nueva contraseña deberá tener una longitud mínima de 8 caracteres y máxima de 12 caracteres y deberá estar compuesta por lo menos de un número, una mayúscula, una minúscula y un carácter especial.",
                  maxLines: 9,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleSmallMontserratOnPrimaryContainer
                      .copyWith(
                    height: 1.41,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.maxFinite,
              decoration: AppDecoration.outlineBlack,
              child: Text(
                "¡Cambiemos tu contraseña!\n",
                maxLines: null,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headlineSmall!.copyWith(
                  height: 1.41,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTextFieldOutline(BuildContext context) {
    return SizedBox(
      height: 59.v,
      width: 328.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: AppDecoration.fillTeal.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 30.v),
                  Container(
                    height: 28.v,
                    width: 328.h,
                    decoration: BoxDecoration(
                      color: appTheme.teal100,
                      borderRadius: BorderRadius.circular(
                        12.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 12.h),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgPassword1,
                    height: 25.v,
                    width: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text(
                      "Contraseña",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTextFieldOutline1(BuildContext context) {
    return SizedBox(
      height: 59.v,
      width: 328.h,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: AppDecoration.fillTeal.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 30.v),
                  Container(
                    height: 28.v,
                    width: 328.h,
                    decoration: BoxDecoration(
                      color: appTheme.teal100,
                      borderRadius: BorderRadius.circular(
                        12.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 12.h,
                top: 15.v,
              ),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgPassword1,
                    height: 25.v,
                    width: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.h,
                      top: 2.v,
                    ),
                    child: Text(
                      "Confirmar contraseña",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
