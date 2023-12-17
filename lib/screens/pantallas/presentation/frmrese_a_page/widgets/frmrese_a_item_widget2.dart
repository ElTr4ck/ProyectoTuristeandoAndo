import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/custom_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
typedef OnTapView = void Function(Map<String, dynamic> jsonData);

class FrmreseAItemWidget extends StatelessWidget {
  final Map<String, dynamic>? reviewData;
  final OnTapView onTapView;
  final Map<String, dynamic>? userData;

  FrmreseAItemWidget(
      {required this.userData,
      required this.reviewData,
      required this.onTapView,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Reseña: ${reviewData}');
    print('Usuario: ${userData}');
    if (userData != null && reviewData != null) {
      var review = reviewData;
      print('después de acceder a review, review: $review');
      var photo = userData?['photo'];
      print('después de acceder a photo, photo: $photo');
      var name = userData?['name'];
      print('después de acceder a name, name: $name');
      var lastname = userData?['lastname'];
      print('después de acceder a last, last: $lastname');
      if (photo == null || name == null || lastname == null || review == null) {
        print('Algo null');
        return SizedBox
            .shrink(); // Retorna un contenedor vacío, puedes ajustar esto de acuerdo a tus requerimientos.
      }
      String formattedDate = "${(review?['fecha']).toDate()}";
      String dateWithoutNanos = formattedDate.split('.')[0];
      print(dateWithoutNanos);
      return Container(
        padding: EdgeInsets.all(12.h),
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder33,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 4.v),
            Padding(
              padding: EdgeInsets.only(right: 49.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 3.v, bottom: 6.v),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.h),
                      child: Image.network(
                        photo,
                        height: 32.adaptSize,
                        width: 32.adaptSize,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${userData?['name']} ${userData?['lastname']}",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 6.v),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.v),
                              child: CustomRatingBar(
                                initialRating:
                                    review?['calificacion'].toDouble(),
                                itemSize: 13,
                                color: appTheme.yellow700,
                              ),
                            ),
                            Text(
                              "${dateWithoutNanos}",
                              style: theme.textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.v),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16.v,
                      width: 20.h,
                      margin: EdgeInsets.only(bottom: 56.v),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                onTapView!.call(reviewData!);
                              },
                              child: Container(
                                height: 16.v,
                                width: 20.h,
                                decoration: BoxDecoration(
                                  color: appTheme.teal100,
                                  borderRadius: BorderRadius.circular(
                                    8.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "!",
                              style:
                                  CustomTextStyles.bodyMediumPollerOnePrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 231.h,
                        margin: EdgeInsets.only(left: 21.h),
                        child: Text(
                          "${reviewData?['comentario']}",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            review['fotos'].isNotEmpty
                ? Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: review['fotos'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(review['fotos'][index],
                                loadingBuilder: (BuildContext context,
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
                            }));
                      },
                    ),
                  )
                : const SizedBox(height: 0),
          ],
        ),
      );
    } else {
      print('Reseña: ${reviewData}');
      print('Usuario: ${userData}');
      return SizedBox
          .shrink(); // Retorna un contenedor vacío, puedes ajustar esto de acuerdo a tus requerimientos. Retorna un contenedor vacío, puedes ajustar esto de acuerdo a tus requerimientos.
    }
  }
}
