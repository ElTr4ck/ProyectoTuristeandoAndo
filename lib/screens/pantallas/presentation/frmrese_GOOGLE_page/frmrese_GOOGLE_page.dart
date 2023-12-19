import '../frmrese_a_page/widgets/frmGOOGLEwidget.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';

class FrmreseAPageG extends StatefulWidget {
  final Map<String, dynamic>? jsonData;
  const FrmreseAPageG({required this.jsonData, Key? key}) : super(key: key);

  @override
  FrmreseAPageState createState() => FrmreseAPageState();
}

class FrmreseAPageState extends State<FrmreseAPageG>
    with AutomaticKeepAliveClientMixin<FrmreseAPageG> {
  int? finale = 0;
  int? five = 0;
  int? four = 0;
  int? three = 0;
  int? two = 0;
  int? one = 0;
  double? rating = 0.0;
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    int i = 0;
    int cinco = 0;
    int cuatro = 0;
    int tres = 0;
    int dos = 0;
    int uno = 0;
    while (widget.jsonData?["reviews"] != null &&
        i < widget.jsonData?["reviews"].length) {
      if (widget.jsonData?["reviews"][i]["rating"] == 5) {
        cinco++;
      } else if (widget.jsonData?["reviews"][i]["rating"] == 4) {
        cuatro++;
      } else if (widget.jsonData?["reviews"][i]["rating"] == 3) {
        tres++;
      } else if (widget.jsonData?["reviews"][i]["rating"] == 2) {
        dos++;
      } else if (widget.jsonData?["reviews"][i]["rating"] == 1) {
        uno++;
      }
      print(widget.jsonData?["reviews"][i]["rating"]);
      i++;
    }
    finale = i;
    one = uno;
    two = dos;
    three = tres;
    four = cuatro;
    five = cinco;
    rating = 1 / i;
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
                                      child: Text("Reseñas de Google",
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Nunito'))),
                                ])),
                        SizedBox(height: 5.v),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 350, // o el valor máximo deseado
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: generateResenasWidgets().length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.v),
                                  child: generateResenasWidgets()[index],
                                );
                              },
                            ),
                          ),
                        )
                      ]))
                ]))));
  }

  List<Widget> generateResenasWidgets() {
    int i = 0;
    List<Widget> widgets = [];

    while (widget.jsonData?["reviews"] != null &&
        i < widget.jsonData?["reviews"].length) {
      Map<String, dynamic>? resena = widget.jsonData?["reviews"][i];

      if (resena != null) {
        widgets.add(
          FrmreseAItemWidget2(
            // ... otras propiedades únicas
            onTapView: () {
              onTapView(context, jsonData: resena);
            },
            jsonData: resena,
          ),
        );
      }

      i++;
    }

    return widgets;
  }

  /// Navigates to the frmreportarreseAScreen when the action is triggered.
  onTapView(BuildContext context, {required jsonData}) {
    Navigator.pushNamed(context, AppRoutes.frmreportarreseAScreen);
  }

  /// Navigates to the frmnewreseAScreen when the action is triggered.
  onTapTxtAceptar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmnewreseAScreen);
  }
}
