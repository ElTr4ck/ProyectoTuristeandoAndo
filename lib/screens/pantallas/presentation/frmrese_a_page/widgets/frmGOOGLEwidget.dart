import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/custom_rating_bar.dart';

// ignore: must_be_immutable
class FrmreseAItemWidget2 extends StatelessWidget {
  final Map<String, dynamic>? jsonData;
  FrmreseAItemWidget2({required this.jsonData, Key? key, required Null Function() onTapView}) : super(key: key);
  VoidCallback? onTapView;

  @override
  Widget build(BuildContext context) {
    //print(jsonData);
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
                      jsonData?["authorAttribution"]['photoUri'],
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
                        '${jsonData?["authorAttribution"]["displayName"]}',
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 6.v),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.v),
                            child: CustomRatingBar(
                              initialRating: jsonData?['rating'].toDouble(),
                              itemSize: 13,
                              color: appTheme.yellow700,
                            ),
                          ),
                          Text(
                            "${jsonData?["relativePublishTimeDescription"]}",
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
                              onTapView!.call();
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
                            style: CustomTextStyles.bodyMediumPollerOnePrimary,
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
                        "${jsonData?["text"]["text"]}",
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
        ],
      ),
    );
  }
}
