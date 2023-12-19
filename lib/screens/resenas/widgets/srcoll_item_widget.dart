import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/models/users/user.dart' as model;
import 'package:turisteando_ando/repositories/auth/firestore_methods.dart';
import 'package:turisteando_ando/widgets/custom_rating_bar.dart';
import 'package:turisteando_ando/widgets/foto.dart';

// ignore: must_be_immutable
class SrcollItemWidget extends StatelessWidget {
  final Map<String, dynamic> place;
  final model.User? user;
  final Map<String, dynamic> review;
  final ValueChanged<int> update;
  final int index;
  SrcollItemWidget(
      {required this.place, //info del lugar
      required this.user, //info del usuario
      required this.review, //info de la review
      required this.update, //funcion para actualizar widget al borrar elemento
      required this.index, //index para borrar elemento
      Key? key})
      : super(
          key: key,
        );

  String timeAgoCustom(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "Hace ${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "año" : "años"}";
    if (diff.inDays > 30)
      return "Hace ${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "mes" : "meses"}";
    if (diff.inDays > 7)
      return "Hace ${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "semana" : "semanas"}";
    if (diff.inDays > 0) return "${DateFormat.E('es').add_jm().format(d)}";
    if (diff.inHours > 0) //return "Hoy ${DateFormat('jm').format(d)}";
      return "Hace ${diff.inHours} ${diff.inHours == 1 ? "hora" : "horas"}";
    if (diff.inMinutes > 0)
      return "Hace ${diff.inMinutes} ${diff.inMinutes == 1 ? "minuto" : "minutos"}";
    return "Justo ahora";
  }

  @override
  Widget build(BuildContext context) {
    Timestamp formattedDate = review['fecha'];
    String dateWithoutNanos = timeAgoCustom(formattedDate.toDate());
    print(dateWithoutNanos);
    return Container(
      //DECORATION CONTAINER
      padding: EdgeInsets.all(12.h),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder33,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(right: 17.h),
              child: Row(
                children: [
                  /*CustomImageView(
                    imagePath: ImageConstant
                        .imgAvatar32x32, //PHOTOS OF THE BD ACORDING TO THE REVIEW´S USER
                    height: 32.adaptSize,
                    width: 32.adaptSize,
                    radius: BorderRadius.circular(
                      16.h,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.v),
                  ),*/
                  CircleAvatar(
                    radius: 17,
                    backgroundImage: NetworkImage(user!.photo),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //AutofillHints.name,  //NAME USER
                          user!.name,
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(
                          width: 132.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /*CustomImageView(
                                imagePath: ImageConstant.imgClose,
                                height: 12.v,
                                width: 60.h,
                                margin: EdgeInsets.symmetric(vertical: 1.v),
                              ),*/
                              CustomRatingBar(
                                initialRating:
                                    review['calificacion'].toDouble(),
                                itemSize: 13,
                                color: appTheme.yellow700,
                              ),
                              Text(
                                "     $dateWithoutNanos", //DATE
                                style: theme.textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    //eliminar review
                    onTap: () {
                      StoreMethods().deleteReview(review['id']);
                      print('eliminado');
                      print(review['id']);
                      update(index);
                    },
                    child: CustomImageView(
                      imagePath: ImageConstant.imgTrashBlack900,
                      height: 16.v,
                      width: 16.h,
                      margin: EdgeInsets.symmetric(vertical: 15.v),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.v),
          Text(
            place['title'], //NAME PLACE
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 1.v),
          SizedBox(
            width: 293.h,
            child: Text(
              review['comentario'],
              maxLines: 3,
              //check this section because don´t show the complete review
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 14.v),
          /*Padding(
            padding: EdgeInsets.only(right: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomImageView(
                    imagePath: ImageConstant.imgRectangle993, //img BD
                    height: 100.v,
                    width: 100.h,
                    radius: BorderRadius.circular(
                      24.h,
                    ),
                    margin: EdgeInsets.only(right: 5.h),
                  ),
                ),
                
              ],
            ),
          ),*/
          review['fotos'].isNotEmpty //determinar si hay fotos
              ? Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: review['fotos'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            //determinar click en una foto
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                //String aux = '${prediction.lat}, ${prediction.lng}';
                                return Foto(
                                    url: review['fotos'][
                                        index]); //mostrar la foto en fullscreen
                              }));
                            },
                            child: Image.network(review['fotos'][index],
                                loadingBuilder: (BuildContext
                                        context, //determinar si la foto no ha cargado
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                widthFactor: 2.5.h,
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }),
                          ));
                    },
                  ),
                )
              : const SizedBox(height: 0),
        ],
      ),
    );
  }
}
