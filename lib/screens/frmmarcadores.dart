import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

void main() {
  runApp(Scene());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

TextStyle SafeGoogleFont(
    String fontFamily, {
      TextStyle? textStyle,
      Color? color,
      Color? backgroundColor,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      double? letterSpacing,
      double? wordSpacing,
      TextBaseline? textBaseline,
      double? height,
      Locale? locale,
      Paint? foreground,
      Paint? background,
      List<Shadow>? shadows,
      List<FontFeature>? fontFeatures,
      TextDecoration? decoration,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,
      double? decorationThickness,
    }) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      "Source Sans Pro",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}

class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          child: Container(
            // frmmarcadoresGoW (1:679)
            width: double.infinity,
            decoration: BoxDecoration (
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // autogroupbouxRTS (7ZmpnbrUspegogWgzUBoUx)
                  padding: EdgeInsets.fromLTRB(8*fem, 20*fem, 0*fem, 22*fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // autogroupmkrn8Mr (7ZmpGsD2a11yzJ3iRDmKRN)
                        margin: EdgeInsets.fromLTRB(4*fem, 0*fem, 0*fem, 7*fem),
                        width: 335.17*fem,
                        height: 78*fem,
                        child: Stack(
                          children: [
                            Positioned(
                              // headerqn4 (1:718)
                              left: 0*fem,
                              top: 0*fem,
                              child: Container(
                                width: 335.17*fem,
                                height: 55*fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // locationREU (1:719)
                                      left: 245*fem,
                                      top: 0*fem,
                                      child: Container(
                                        width: 90.17*fem,
                                        height: 17*fem,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // usernamexxk1r (1:720)
                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 8.83*fem, 0*fem),
                                              child: Text(
                                                'UserNameXx',
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 12*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff5f5f5f),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // iconlylightoutlinearrowdown2DA (1:721)
                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                                              width: 10.33*fem,
                                              height: 5.67*fem,
                                              child: Image.asset(
                                                'lib/assets/iconly-light-outline-arrow-down-2.png',
                                                width: 10.33*fem,
                                                height: 5.67*fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // greetskg (1:724)
                                      left: 0*fem,
                                      top: 0*fem,
                                      child: Container(
                                        width: 312*fem,
                                        height: 55*fem,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // favoritosnse (1:725)
                                              margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 7*fem),
                                              child: Text(
                                                'Favoritos',
                                                style: SafeGoogleFont (
                                                  'Montserrat',
                                                  fontSize: 14*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2175*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              // estossontusmarcadores6NY (1:726)
                                              'Estos son tus marcadores',
                                              style: SafeGoogleFont (
                                                'Montserrat',
                                                fontSize: 24*ffem,
                                                fontWeight: FontWeight.w500,
                                                height: 1.2175*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              // rectangle99621J (1:798)
                              left: 105*fem,
                              top: 54*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 125*fem,
                                  height: 24*fem,
                                  child: Container(
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(12*fem),
                                      color: Color(0xfff1f1f1),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x3f000000),
                                          offset: Offset(0*fem, 4*fem),
                                          blurRadius: 2*fem,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // verenmapaHC8 (1:799)
                              left: 128*fem,
                              top: 59*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 79*fem,
                                  height: 15*fem,
                                  child: TextButton(
                                    style: TextButton.styleFrom (
                                      padding: EdgeInsets.zero,
                                    ),
                                      onPressed:(){

                                      },
                                    child: Text(
                                      'Ver en mapa',
                                        style: SafeGoogleFont(
                                          'Montserrat',
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2175 * ffem / fem,
                                          color: Color(0xff0084ff),
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // lugaresguardadosA12 (1:762)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 31*fem),
                        width: 392*fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // autogroupjzpa5Nt (7Zmqq57ityJHZQnZDVjZPa)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 47*fem, 12*fem),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // lugaresguardadosCyJ (1:763)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 119*fem, 0*fem),
                                    child: Text(
                                      'Lugares guardados',
                                      style: SafeGoogleFont (
                                        'Montserrat',
                                        fontSize: 18*ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2175*ffem/fem,
                                        color: Color(0xff232323),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // vertodoKHE (1:764)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          onTap: (){
                                            print('Texto presionado');
                                          },
                                      child: Padding(
                                        padding : EdgeInsets.all(8.0),
                                        child: Text(
                                            'Ver todo',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 12*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3625*ffem/fem,
                                        ),
                                      ),
                                      ),
                                    ),
                                  ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // autogroup8i1aE9J (7ZmquuK1MaysyMcUm48i1a)
                              width: double.infinity,
                              height: 240*fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // group3421Aoe (1:781)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                    padding: EdgeInsets.fromLTRB(12*fem, 175*fem, 16*fem, 11*fem),
                                    height: double.infinity,
                                    decoration: BoxDecoration (
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        image: AssetImage (
                                          'lib/assets/group-3419-hGp.png',
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // frame1000000863ptC (1:791)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 25*fem, 0*fem),
                                          width: 111*fem,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // frame1000000859k1A (1:792)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                                                width: double.infinity,
                                                height: 24*fem,
                                                decoration: BoxDecoration (
                                                  color: Color(0xff4c5652),
                                                  borderRadius: BorderRadius.circular(59*fem),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Museo Soumaya',
                                                    style: SafeGoogleFont (
                                                      'Nunito',
                                                      fontSize: 12*ffem,
                                                      fontWeight: FontWeight.w200,
                                                      height: 1.3625*ffem/fem,
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // frame1000000860cJG (1:794)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 56*fem, 0*fem),
                                                padding: EdgeInsets.fromLTRB(12*fem, 5*fem, 10*fem, 5*fem),
                                                width: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: Color(0xff4c5652),
                                                  borderRadius: BorderRadius.circular(59*fem),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // stariMJ (1:795)
                                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6*fem, 0.67*fem),
                                                      width: 12*fem,
                                                      height: 11.33*fem,
                                                      child: Image.asset(
                                                        'lib/assets/star-Mfr.png',
                                                        width: 12*fem,
                                                        height: 11.33*fem,
                                                      ),
                                                    ),
                                                    Text(
                                                      // cha (1:796)
                                                      '4.8',
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontSize: 10*ffem,
                                                        fontWeight: FontWeight.w200,
                                                        height: 1.3625*ffem/fem,
                                                        fontStyle: FontStyle.italic,
                                                        color: Color(0xffffffff),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // iconlyboldheartkon (1:786)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                                          width: 24*fem,
                                          height: 24*fem,
                                          child: Image.asset(
                                            'lib/assets/iconly-bold-heart.png',
                                            width: 24*fem,
                                            height: 24*fem,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // group3420Ty6 (1:765)
                                    padding: EdgeInsets.fromLTRB(12*fem, 175*fem, 16*fem, 11*fem),
                                    width: 188*fem,
                                    height: double.infinity,
                                    decoration: BoxDecoration (
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        image: AssetImage (
                                          'lib/assets/group-3419-1YQ.png',
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // frame1000000863mD6 (1:775)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 37*fem, 0*fem),
                                          width: 99*fem,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // frame1000000859gqr (1:776)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                                                width: double.infinity,
                                                height: 24*fem,
                                                decoration: BoxDecoration (
                                                  color: Color(0xff4c5652),
                                                  borderRadius: BorderRadius.circular(59*fem),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Museo JUMEX',
                                                    style: SafeGoogleFont (
                                                      'Nunito',
                                                      fontSize: 12*ffem,
                                                      fontWeight: FontWeight.w200,
                                                      height: 1.3625*ffem/fem,
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // frame1000000860ZPr (1:778)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 44*fem, 0*fem),
                                                padding: EdgeInsets.fromLTRB(12*fem, 5*fem, 10*fem, 5*fem),
                                                width: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: Color(0xff4c5652),
                                                  borderRadius: BorderRadius.circular(59*fem),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // starG3N (1:779)
                                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6*fem, 0.67*fem),
                                                      width: 12*fem,
                                                      height: 11.33*fem,
                                                      child: Image.asset(
                                                        'lib/assets/star.png',
                                                        width: 12*fem,
                                                        height: 11.33*fem,
                                                      ),
                                                    ),
                                                    Text(
                                                      // aZr (1:780)
                                                      '4.6',
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontSize: 10*ffem,
                                                        fontWeight: FontWeight.w200,
                                                        height: 1.3625*ffem/fem,
                                                        fontStyle: FontStyle.italic,
                                                        color: Color(0xffffffff),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // iconlyboldheartKnL (1:770)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                                          width: 24*fem,
                                          height: 24*fem,
                                          child: Image.asset(
                                            'lib/assets/iconly-bold-heart-d2k.png',
                                            width: 24*fem,
                                            height: 24*fem,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // marcadorespersonalizados3TS (1:727)
                        width: 392*fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // autogroupfbfiaTN (7Zmq7kyE9N9hGdvjKcfbfi)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 47*fem, 12*fem),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // marcadorespersonalizados7CQ (1:728)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 44*fem, 0*fem),
                                    child: Text(
                                      'Marcadores Personalizados',
                                      style: SafeGoogleFont (
                                        'Montserrat',
                                        fontSize: 18*ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2175*ffem/fem,
                                        color: Color(0xff232323),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // vertodoKHE (1:764)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: (){
                                          print('Texto presionado');
                                        },
                                        child: Padding(
                                          padding : EdgeInsets.all(8.0),
                                          child: Text(
                                            'Ver todo',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 12*ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3625*ffem/fem,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // autogrouppyqrvfe (7ZmqCLfvkbzEuLvB6YPYqr)
                              width: double.infinity,
                              height: 240*fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // group3421TvU (1:746)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                    padding: EdgeInsets.fromLTRB(12*fem, 175*fem, 16*fem, 11*fem),
                                    height: double.infinity,
                                    decoration: BoxDecoration (
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        image: AssetImage (
                                          'lib/assets/group-3419-XfJ.png',
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // frame1000000863keg (1:756)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 41*fem, 0*fem),
                                          width: 95*fem,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // frame10000008595wr (1:757)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                                                width: double.infinity,
                                                height: 24*fem,
                                                decoration: BoxDecoration (
                                                  color: Color(0xff4c5652),
                                                  borderRadius: BorderRadius.circular(59*fem),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Rosso di Sera',
                                                    style: SafeGoogleFont (
                                                      'Nunito',
                                                      fontSize: 12*ffem,
                                                      fontWeight: FontWeight.w200,
                                                      height: 1.3625*ffem/fem,
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // frame1000000860mZn (1:759)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 40*fem, 0*fem),
                                                padding: EdgeInsets.fromLTRB(12*fem, 5*fem, 10*fem, 5*fem),
                                                width: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: Color(0xff4c5652),
                                                  borderRadius: BorderRadius.circular(59*fem),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // star5Ka (1:760)
                                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6*fem, 0.67*fem),
                                                      width: 12*fem,
                                                      height: 11.33*fem,
                                                      child: Image.asset(
                                                        'lib/assets/star-Lya.png',
                                                        width: 12*fem,
                                                        height: 11.33*fem,
                                                      ),
                                                    ),
                                                    Text(
                                                      // NpU (1:761)
                                                      '4.6',
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontSize: 10*ffem,
                                                        fontWeight: FontWeight.w200,
                                                        height: 1.3625*ffem/fem,
                                                        fontStyle: FontStyle.italic,
                                                        color: Color(0xffffffff),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // iconlyboldheartKji (1:751)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                                          width: 24*fem,
                                          height: 24*fem,
                                          child: Image.asset(
                                            'lib/assets/iconly-bold-heart-VMW.png',
                                            width: 24*fem,
                                            height: 24*fem,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // group3420qi4 (1:730)
                                    width: 188*fem,
                                    height: double.infinity,
                                    decoration: BoxDecoration (
                                      image: DecorationImage (
                                        fit: BoxFit.cover,
                                        image: AssetImage (
                                          'lib/assets/group-3419.png',
                                        ),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // iconlyboldheartZe4 (1:735)
                                          left: 148*fem,
                                          top: 200*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 24*fem,
                                              height: 24*fem,
                                              child: Image.asset(
                                                'lib/assets/iconly-bold-heart-pAQ.png',
                                                width: 24*fem,
                                                height: 24*fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // frame100000086356c (1:740)
                                          left: 12*fem,
                                          top: 175*fem,
                                          child: Container(
                                            width: 148*fem,
                                            height: 54*fem,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // frame1000000859CS8 (1:741)
                                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                                                  width: double.infinity,
                                                  height: 24*fem,
                                                  decoration: BoxDecoration (
                                                    color: Color(0xff4c5652),
                                                    borderRadius: BorderRadius.circular(59*fem),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Casa Hidalgo Coyoacán',
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontSize: 12*ffem,
                                                        fontWeight: FontWeight.w200,
                                                        height: 1.3625*ffem/fem,
                                                        fontStyle: FontStyle.italic,
                                                        color: Color(0xffffffff),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // frame1000000860fqW (1:743)
                                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 93*fem, 0*fem),
                                                  padding: EdgeInsets.fromLTRB(12*fem, 5*fem, 10*fem, 5*fem),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration (
                                                    color: Color(0xff4c5652),
                                                    borderRadius: BorderRadius.circular(59*fem),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        // stary5W (1:744)
                                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6*fem, 0.67*fem),
                                                        width: 12*fem,
                                                        height: 11.33*fem,
                                                        child: Image.asset(
                                                          'lib/assets/star-uVn.png',
                                                          width: 12*fem,
                                                          height: 11.33*fem,
                                                        ),
                                                      ),
                                                      Text(
                                                        // 6R2 (1:745)
                                                        '4.5',
                                                        style: SafeGoogleFont (
                                                          'Nunito',
                                                          fontSize: 10*ffem,
                                                          fontWeight: FontWeight.w200,
                                                          height: 1.3625*ffem/fem,
                                                          fontStyle: FontStyle.italic,
                                                          color: Color(0xffffffff),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // autogroupszkieBe (7ZmpXwcEw4NYP29GWhsZKi)
                  width: double.infinity,
                  height: 72*fem,
                  child: Stack(
                    children: [
                      Positioned(
                        // ExU (1:800)
                        left: 142.5*fem,
                        top: 24*fem,
                        child: Center(
                          child: Align(
                            child: SizedBox(
                              width: 10*fem,
                              height: 21*fem,
                              child: Text(
                                '',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont (
                                  'Font Awesome 5 Free',
                                  fontSize: 16*ffem,
                                  fontWeight: FontWeight.w900,
                                  height: 1.2575*ffem/fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // fill8JSY (1:801)
                        left: 210.5*fem,
                        top: 29.7667236328*fem,
                        child: Align(
                          child: SizedBox(
                            width: 14.4*fem,
                            height: 13.71*fem,
                            child: Image.asset(
                              'lib/assets/fill-8.png',
                              width: 14.4*fem,
                              height: 13.71*fem,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // fill4DZW (1:804)
                        left: 220*fem,
                        top: 32*fem,
                        child: Align(
                          child: SizedBox(
                            width: 2.4*fem,
                            height: 2.76*fem,
                            child: Image.asset(
                              'lib/assets/fill-4.png',
                              width: 2.4*fem,
                              height: 2.76*fem,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}